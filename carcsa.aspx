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
        q_desc=1;
        q_tables = 's';
        var q_name = "carcsa";
        var q_readonly = ['txtNoa'];
        var q_readonlys = [];
        var bbmNum = [['txtWeight',14, 3, 1],['txtMount',10, 0, 1],['txtAddmoney',14, 0, 1],['txtMoney',18, 0, 1],['txtPrice',18, 0, 1]];  
        var bbsNum = [['txtWeight',14, 3, 1],['txtInprice',14, 0, 1],['txtInmount',14, 3, 1],['txtInmoney',14, 0, 1],['txtOutprice',14, 0, 1],['txtOutmount',14, 3, 1],['txtOutmoney',14, 0, 1],['txtMount',14, 3, 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtDriverno_', 'btnDriver_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx'],
        							['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
        							['txtCarno_', 'btnCarno_', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();   
           q_gt(q_name, q_content, q_sqlCount, 1)  
        });

        //////////////////   end Ready
        function main() {
            if (dataErr)  
            {
                dataErr = false;
                return;
            }

            mainForm(1); 
        }
        function mainPost() { 
        
            q_getFormat();
            bbmMask = [['txtDatea', r_picd],['txtBtime', '99:99'],['txtEtime', '99:99'],['txtMon', r_picm]];
            q_mask(bbmMask);
            
            q_cmbParse("cmbType", ('').concat(new Array('','1@TR00 中鴻 全拖 4712', '2@TR00 中鴻 半拖 2480', '3@TR00 廠內 半拖 605', '4@TR35 廠內 605', '5@TR35 廠外 570', '6@TR13 大寮 1600')));
            q_cmbParse("cmbTypea2", ('').concat(new Array('','全拖', '半拖', '小時', '塊')));
            
            $('#cmbType').change(function () {
            	var i = $('#cmbType').val();
            	switch (i) {   
                case '1':
                    $('#txtCartype').val('TR00');
                    $('#txtAddr').val('中鴻');
                    $('#cmbTypea2').val('全拖');
                    q_tr('txtPrice',4712);
                    sum();
                    break;
                case '2':
                    $('#txtCartype').val('TR00');
                    $('#txtAddr').val('中鴻');
                    $('#cmbTypea2').val('半拖');
                    q_tr('txtPrice',2480);
                    sum();
                    break;
                case '3':
                    $('#txtCartype').val('TR00');
                    $('#txtAddr').val('廠內');
                    $('#cmbTypea2').val('半拖');
                    q_tr('txtPrice',605);
                    sum();
                    break;
                case '4':
                    $('#txtCartype').val('TR35');
                    $('#txtAddr').val('廠內');
                    $('#cmbTypea2').val('');
                    q_tr('txtPrice',605);
                    sum();
                    break;
                case '5':
                    $('#txtCartype').val('TR35');
                    $('#txtAddr').val('廠外');
                    $('#cmbTypea2').val('');
                    q_tr('txtPrice',570);
                    sum();
                    break;
                case '6':
                    $('#txtCartype').val('TR13');
                    $('#txtAddr').val('大寮');
                    $('#cmbTypea2').val('');
                    q_tr('txtPrice',1600);
                    sum();
                    break;
            	}   /// end Switch
            });
            $('#txtPrice').change(function () {
            	sum();
            });
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 
            var ret;
            switch (b_pop) {   
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
                case q_name: if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
        }

        function combPay_chg() {   
        }

        function bbsAssign() {  
        	for (var j = 0; j < q_bbsCount; j++) {
		          $('#txtMount_'+j).change(function () {
		          	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
		          	$('#txtInmount_'+b_seq).val($('#txtMount_'+b_seq).val());
		          	$('#txtOutmount_'+b_seq).val($('#txtMount_'+b_seq).val());
		            sum();
		          });
		          $('#txtDiscount_'+j).change(function () {
		            sum();
		          });
            }//end for
            _bbsAssign();
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
            $('#txtProduct').focus();
            
           
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['carno'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['datea'] = abbm2['datea'];
            as['mon'] = abbm2['mon'];
            as['cardealno'] = abbm2['cardealno'];
            as['cardeal'] = abbm2['cardeal'];
            as['addr'] = abbm2['addr'];
            as['inprice'] = abbm2['price'];
            as['outprice'] = abbm2['price'];
            as['ordeno'] = abbm2['ordeno'];

            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0,money_total=0;
            for (var j = 0; j < q_bbsCount; j++) {
            	 q_tr('txtInmoney_'+j ,Math.round(q_float('txtPrice')*q_float('txtInmount_'+j)));
            	 q_tr('txtOutmoney_'+j ,Math.round(q_float('txtPrice')*q_float('txtDiscount_'+j)*q_float('txtOutmount_'+j)));
            }  // j
        }
        
       

        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
            for (var j = 0; j < q_bbsCount; j++) {
            	$('#txtMount_'+j).val($('#txtOutmount_'+j).val());
            }
       }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            
        }

        function btnMinus(id) {
            _btnMinus(id);
            sum();
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield); 
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
          #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 23%;
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
                width: 75%;
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
                width: 47%;
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
            
            .tbbs a {
                font-size: medium;
            }
            .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width:100%;}
			 .dbbs .tbbs tr{height:35px;}
			 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
            .num {
                text-align: right;
            }
            .bbs{
            	float:left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
    <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center"><a id='vewOrdeno'></a></td>
               <td align="center" style="width:25%"><a id='vewPrice'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='ordeno'>~ordeno</td>
                   <td align="center" id='price'>~price</td>              
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 74%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='td1'><span> </span><a id="lblNoa" class="lbl"></a></td>
            <td class='td2'><input id="txtNoa"  type="text" class="txt c1" /></td>
            <td class='td3'><span> </span><a id="lblDatea" class="lbl"></a></td>
            <td class='td4'><input id="txtDatea" type="text" class="txt c1"/></td>
            <td class='td5'><span> </span><a id="lblOrdeno" class="lbl"></a></td>
            <td class='td6'><input id="txtOrdeno" type="text" class="txt c1"/></td>
       </tr>
       <tr>
       		<td class='td1'><span> </span><a id="lblType" class="lbl"></a></td>
      		<td class='td2'><select id="cmbType" class="txt c1" style="font-size: medium;"></select></td>
      		<td class='td3'><span> </span><a id="lblMon" class="lbl"></a></td>
      		<td class='td4'><input id="txtMon" type="text" class="txt c1"/></td>
       </tr>
       <tr>           
			<td class='td1'><span> </span><a id="lblCartype" class="lbl"></a></td>
            <td class='td2'><input id="txtCartype" type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblAddr" class="lbl"></a></td>
            <td class='td4'><input id="txtAddr"  type="text"  class="txt c1"/></td>
            <td class='td5'><span> </span><a id="lblTypea" class="lbl"></a></td>
            <td class='td6'>
            	<input id="txtTypea" type="text" class="txt c2"/>
            	<select id="cmbTypea2" style="width:70%;font-size: medium;"></select>
            </td>
       </tr>        
        <tr>           
			<td class='td1'><span> </span><a id="lblBtime" class="lbl"></a></td>
            <td class='td2'><input id="txtBtime"  type="text" class="txt c1" /></td>
            <td class='td3'><span> </span><a id="lblOntime" class="lbl"></a></td>
            <td class='td4'><input id="txtOntime" type="text" class="txt c1"/></td>
            <td class='td5'><span> </span><a id="lblEtime" class="lbl"></a></td>
            <td class='td6'><input id="txtEtime" type="text" class="txt c1"/></td>
       </tr>        
        <tr>
            <td class='td1'><span> </span><a id="lblWeight" class="lbl"></a></td>
            <td class='td2'><input id="txtWeight"  type="text" class="txt c1" /></td>
            <td class='td3'><span> </span><a id="lblMount" class="lbl"></a></td>
            <td class='td4'><input id="txtMount" type="text" class="txt c1"/></td>
            <td class='td5'><span> </span><a id="lblCarno" class="lbl"></a></td>
            <td class='td6'><input id="txtCarno" type="text" class="txt c1"/></td>
       </tr>
       <tr>
       		<td class='td1'><span> </span><a id="lblPrice" class="lbl"></a></td>
            <td class='td2'><input id="txtPrice" type="text" class="txt c1"/></td>
            <td class='td1'><span> </span><a id="lblAddmoney" class="lbl"></a></td>
            <td class='td2'><input id="txtAddmoney" type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblMoney" class="lbl"></a></td>
            <td class='td4'><input id="txtMoney" type="text" class="txt c1"/></td>
        </tr>
        <tr>
            <td class='td1'><span> </span><a id="lblCardeal" class="lbl btn"></a></td>
            <td class='td2' colspan='2'><input id="txtCardealno"  type="text"  class="txt c2"/><input id="txtCardeal"  type="text"  class="txt c3"/></td>
        </tr> 
        </table>
        </div>
		</div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                <!--<td align="center" style="width:8%"><a id='lblDateas'></a></td>-->
                <td align="center" style="width:8%"><a id='lblCarnos'></a></td>
                <td align="center" style="width:8%"><a id='lblDrivers'></a></td>
                <!--<td align="center" style="width:14%"><a id='lblCardeals'></a></td>-->
                <td align="center" style="width:8%"><a id='lblWeights'></a></td>
                <td align="center" style="width:12%"><a id='lblMounts'></a></td>
                <td align="center" style="width:12%"><a id='lblDiscounts'></a></td>
                <td align="center" style="width:14%"><a id='lblIns'></a></td>
                <td align="center" style="width:14%"><a id='lblOuts'></a></td>
            </tr>
            <tr >
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <!--<td ><input class="txt c1" id="txtDatea.*" type="text" /></td>-->
                <td >
                		<input class="txt c3" id="txtCarno.*" type="text" />
                		<input class="btn"  id="btnCarno.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
                </td>
                <td >
                	<input class="txt c3" id="txtDriverno.*" type="text" />
                	<input class="btn"  id="btnDriver.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
                	<input class="txt c1" id="txtDriver.*" type="text" />
                </td>
                <!--<td >
                		<input class="txt c3" id="txtCardealno.*" type="text" />
                		<input class="btn"  id="btnCardeal.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
                		<input class="txt c1" id="txtCardeal.*" type="text" />
                </td>-->
                <td ><input class="txt num c1" id="txtWeight.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtMount.*" type="text" /></td>
                <td >
                	<input class="txt num c1" id="txtDiscount.*" type="text" />
                </td>
                <td >
                	<!--<input class="txt num c1" id="txtInprice.*" type="text" />-->
                	<input class="txt num c4" id="txtInmount.*" type="hidden" />
                	<input class="txt num c1" id="txtInmoney.*" type="text" />
                </td>
                <td >
                	<!--<input class="txt num c4" id="txtOutprice.*" type="text" />-->
                	<input class="txt num c4" id="txtOutmount.*" type="hidden" />
                	<input class="txt num c1" id="txtOutmoney.*" type="text" />
                	<input id="txtNoq.*" type="hidden" />
                </td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
