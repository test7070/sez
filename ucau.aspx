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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        q_tables = 's';
        var q_name = "ucau";
        var decbbs = [];
        var decbbm = [];
        var q_readonly = ['txtNoa','txtWorker']; 
        var q_readonlys = ['txtNoq']; 
        var bbmNum = [];  
        var bbsNum = [['txtMount', 15, 2,1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'Datea'; q_desc = 1;
        
        
        aPop = new Array(['txtProductno_', 'btnProductno_', 'uca', 'noa,product', 'txtProductno_,txtProduct_', 'uca_b.aspx']
        	);


        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];

            q_brwCount();   
			//q_gt(q_name, q_content, q_sqlCount, 1)
			q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            /*if (!q_gt(q_name, q_content, q_sqlCount, 1))
                return;*/
        });

        //////////////////   end Ready
       function main() {
           if (dataErr)  
           {
               dataErr = false;
               return;
           }

            q_mask(bbmMask);

            mainForm(1); 

            $('#txtDatea').focus();
            
        }  ///  end Main()


        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd], ['txtChgdate', r_picd]];
            q_mask(bbmMask);
          
            
        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 
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
                case q_name: 
               		if (q_cur == 4)  
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        

        function btnOk() {
        	t_err = ''
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')] ]);  // �ˬd�ť� 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();
			var t_date = $('#txtDatea').val();
            var s1 = $('#txt' + bbmKey[0][0].toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")  
                q_gtnoa(q_name, replaceAll(q_getPara('sys.key_work') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('ucau_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   
        }
        

        function bbsAssign() {  
        	for(var j = 0; j < q_bbsCount; j++) {
           			$('#lblNo_'+j).text(j+1);	
                    if ($('#btnMinus_' + j).hasClass('isAssign'))/// 重要
                        continue;
           		}
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txtNoa').val('AUTO');
            $('#txtChgdate').val(q_date())
            $('#txtDatea').val(q_date()).focus()
            $('#txtTypea').focus();
         }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtReason').focus();
        }
        function btnPrint() {
			//q_box('z_work.aspx'+ "?;;;;"+r_accy+";", '', "95%", "95%", q_getMsg("popPrint")); 
        }

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0][0].toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
        }

        function bbsSave(as) {  
            if (!as['productno'] && !as['product'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();      
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j
        }
        
        function refresh(recno) {
            _refresh(recno);
            for(var j = 0; j < q_bbsCount; j++) {
            	$('#btnTproductno_'+j).hide();
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
            if (q_tables == 's')
                bbsAssign();   
        }

        function q_appendData(t_Table) {
            dataErr = !_q_appendData(t_Table);
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
                width: 30%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 68%;
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
                width: 65px;
                float: left;
            }
            .txt.c3 {
                width: 130px;
                float: left;
            }
            .txt.c4 {
                width: 25%;
                float: left;
            }
            .txt.c5 {
                width: 71%;
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
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            .tbbs
        	{
	            FONT-SIZE: medium;
	            COLOR: blue ;
	            TEXT-ALIGN: left;
	             BORDER:1PX LIGHTGREY SOLID;
	             width:100% ; height:98% ;  
        	} 
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div class="dview" id="dview" style="float: left;  width:30%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:20%"><a id='vewChgdate'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox"></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='chgdate'>~chgdate</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 70%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
	        <tr class="tr1">
		        <td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
		        <td class="td2"><input id="txtNoa" type="text"  class="txt c1"/></td>
		        <td class="td3"><span> </span><a id="lblTypea" class="lbl"> </a></td>
		        <td class="td4"><input id="txtTypea" type="text"  class="txt c1"/></td>
				<td class="td5"><span> </span><a id="lblDatea" class="lbl"> </a></td>
				<td class="td6"><input id="txtDatea" type="text"  class="txt c1"/></td> 
			</tr>
			<tr class="tr1">
		        <td class="td1"><span> </span><a id="lblChgdate" class="lbl"> </a></td>
		        <td class="td2"><input id="txtChgdate" type="text"  class="txt c1"/></td>
		        <td class="td3"><span> </span><a id="lblReason" class="lbl"> </a></td>
		        <td class="td4" colspan="3"><input id="txtReason" type="text"  class="txt c1"/></td> 
			</tr>
	        <tr class="tr2">
		        <td class="td1"><span> </span><a id="lblEmergency" class="lbl"> </a></td>
		        <td class="td2">
		        	<input id="txtEmergency" type="text"  class="txt c1" />
		        </td>
		        <td class="td1"><span> </span><a id="lblSign" class="lbl"> </a></td>
		        <td class="td2" colspan="3"><input id="txtSign" type="text"  class="txt c1"/></td>
		        
	        </tr>
	        <tr class="tr3">
		        <td class="td1"><span> </span><a id="lblWorker" class="lbl"> </a></td>
		        <td class="td2">
		        	<input id="txtWorker" type="text"  class="txt c1" />
		        </td>
		        <td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
		        <td class="td2" colspan="3"><input id="txtMemo" type="text"  class="txt c1"/></td>
			</tr>
        </table>
        </div>

        <div class='dbbs'>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:3%;"><a id='lblNoq_s'> </a></td>
                <td align="center" style="width:12%;"><a id='lblProductno_s'> </a></td>
                <td align="center" style="width:15%;"><a id='lblProduct_s'> </a></td>
                <td align="center" style="width:6%;"><a id='lblSpec_s'> </a></td>
                <td align="center" style="width:6%;"><a id='lblUnit_s'> </a></td>
                <td align="center" style="width:6%;"><a id='lblTypea_s'> </a></td>
                <td align="center" style="width:6%;"><a id='lblEdition_s'> </a></td>
                <td align="center" style="width:6%;"><a id='lblMount_s'> </a></td>
                <td align="center" style="width:6%;"><a id='lblWorktype_s'> </a></td>
                <td align="center" style="width:12%;"><a id='lblWorklist_s'> </a></td>
                <td align="center" style="width:18%;"><a id='lblReason_s'> </a></td>
                <td align="center" style="width:7%;"><a id='lblConfirm_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td>	<input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
                	<input id="Noq.*" type="hidden" />
                </td>
                <td>
                	<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;" />
                	<input id="txtProductno.*" type="text" class="txt" style="width: 70%;"/>
                </td>
                <td><input id="txtProduct.*" type="text" class="txt c1"/></td>
                <td><input id="txtSpec.*" type="text" class="txt c1"/></td>
                <td><input id="txtUnit.*" type="text" class="txt c1"/></td>
                <td><input id="txtTypea.*" type="text" class="txt c1"/></td>
                <td><input id="txtEdition.*" type="text" class="txt c1"/></td>
                <td><input id="txtMount.*" type="text" class="txt num c1"/></td>
                <td><input id="txtWorktype.*" type="text" class="txt c1"/></td>
                <td><input id="txtWorklist.*" type="text" class="txt c1"/></td>
                <td><input id="txtReason.*" type="text" class="txt c1"/></td>
                <td><input id="txtConfirm.*" type="text" class="txt c1"/>
                	<input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
