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
        q_tables = 's';
        var q_name = "cuc";
        var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
        var q_readonlys = [];
        var bbmNum = [['txtGen',10,3,1]];  
        var bbsNum = [['txtRadius',10,3,1],['txtWidth',10,3,1],['txtDime',10,3,1],['txtLengthb',10,3,1],
        			  ['txtHours',10,3,1],['txtMount',10,3,1],['txtWeight',10,3,1]
        			 ];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6;
		brwCount = 6;
		brwList = [];
		brwNowPage = 0;
		brwKey = 'Noa';
		brwCount2= 6;
		aPop = new Array(
			['txtMechno', 'lblMechno', 'mech', 'noa,mech,gen', 'txtMechno,txtMech,txtGen', 'mech_b.aspx'],
			['txtMechno_', 'btnMechno_', 'mech', 'noa,mech', 'txtMechno_,txtMech_', 'mech_b.aspx'],
			['txtCustno_', 'btnCustno_', 'cust', 'noa,comp', 'txtCustno_,txtCust_', 'cust_b.aspx'],
			['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']
		);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();   
            q_gt(q_name, q_content, q_sqlCount, 1);
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
            bbmMask = [['txtDatea',r_picd]];
            bbsMask = [['txtDatea',r_picd],['txtUdate',r_picd],['txtDate2',r_picd]];
            q_mask(bbmMask);   
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
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
            if (t_err.length > 0) {
				alert(t_err);
				return;
            }

			if(q_cur==1)
				$('#txtWorker').val(r_name);
			else
				$('#txtWorker2').val(r_name);
            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
			var t_date = trim($('#txtDatea').val());
            if (s1.length == 0 || s1 == "AUTO")   
				q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cuc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
            else
				wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
				return;
            //q_box('*.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   
        }

        function bbsAssign() {  
        	for(var j = 0; j < q_bbsCount; j++) {
	        	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
	            }
           }
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txtNoa').val('AUTO');
            $('#txtDatea').val(q_date()).focus();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
				return;
            _btnModi();
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['datea'] ) {  
				as[bbsKey[1]] = '';   
				return;
            }

            q_nowf();

            return true;
        }
        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
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
				/*overflow: hidden;*/
            }
            .dview {
				float: left;
				width: 28%;
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
				width: 70%;
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
				width: 75%;
				float: left;
            }
            .txt.c3 {
				width: 47%;
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
				width: 25%;
				
            }
            .txt.c7 {
				width: 95%;
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
            .dbbs {
				width: 1800px;
            }
            .tbbs a {
				font-size: medium;
            }

            .num {
				text-align: right;
            }
            .tbbs tr.error input[type="text"] {
				color: red;
            }
            input[type="text"], input[type="button"] {
				font-size: medium;
            }
        .tbbs
        {
            FONT-SIZE: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:98% ;  
        }  
      
       .tbbs .td1
        {
            width: 8%;
        }
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
    <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
				<td align="center" style="width:5%"><a id='vewChk'></a></td>
				<td align="center" style="width:20%"><a id='vewDatea'></a></td>
				<td align="center" style="width:25%"><a id='vewMech'></a></td>
            </tr>
             <tr>
				   <td><input id="chkBrow.*" type="checkbox" style=' '/></td>
				   <td align="center" id='datea'>~datea</td>
				   <td align="center" id='mech'>~mech</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
	        <tr>
	            <td class="td1"><span> </span><a id="lblNoa" class="lbl"></a></td>
	            <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
	            <td class='td3'><span> </span><a id="lblDatea" class="lbl"></a></td>
	            <td class="td4"><input id="txtDatea"  type="text" class="txt c1"/></td>
	            <td class='td5'><span> </span><a id="lblOrdeno" class="lbl"></a></td>
	            <td class="td6"><input id="txtOrdeno"  type="text" class="txt c1"/></td>
				<td class="td7"></td>
			</tr>
	        <tr>
	            <td class="td1"><span> </span><a id="lblMechno" class="lbl btn"></a></td>
	            <td class="td2" colspan="2">
	            	<input id="txtMechno"  type="text" class="txt" style="width:30%;"/>
	            	<input id="txtMech"  type="text" class="txt" style="width:65%;"/>
	            </td>
			</tr>
	        <tr>
	            <td class="td1"><span> </span><a id="lblWorker" class="lbl"></a></td>
	            <td class="td2"><input id="txtWorker" type="text" class="txt c1 num"/></td>
	            <td class='td3'><span> </span><a id="lblWorker2" class="lbl"></a></td>
	            <td class="td4"><input id="txtWorker2" type="text" class="txt c1 num"/></td>
			</tr>
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;'>
				<td align="center" style="width: 1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
				</td>
				<td align="center" style="width: 5%;"><a id='lblDatea_s'></a></td>
				<td align="center" style="width: 6%;"><a id='lblUno_s'></a></td>
				<td align="center" style="width: 5%;"><a id='lblUdate_s'></a></td>
				<td align="center" style="width: 5%;"><a id='lblDate2_s'></a></td>
				<td align="center" style="width: 9%;"><a id='lblOrdeno_s'></a></td>
				<td align="center" style="width: 9%;"><a id='lblMechno_s'></a></td>
				<td align="center" style="width: 9%;"><a id='lblCustno_s'></a></td>
				<td align="center" style="width: 9%;"><a id='lblProductno_s'></a></td>
				<td align="center" style="width: 6%;"><a id='lblRadius_s'></a></td>
				<td align="center" style="width: 6%;"><a id='lblWidth_s'></a></td>
				<td align="center" style="width: 6%;"><a id='lblDime_s'></a></td>
				<td align="center" style="width: 6%;"><a id='lblLengthb_s'></a></td>
				<td align="center" style="width: 6%;"><a id='lblHours_s'></a></td>
				<td align="center" style="width: 6%;"><a id='lblMount_s'></a></td>
				<td align="center" style="width: 6%;"><a id='lblWeight_s'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
				<td align="center">
					<input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
				</td>
				<td><input class="txt c1" id="txtDatea.*" type="text"/></td>					
 				<td><input class="txt c1" id="txtUno.*" type="text"/></td>					
				<td><input class="txt c1" id="txtUdate.*" type="text"/></td>					
				<td><input class="txt c1" id="txtDate2.*" type="text"/></td>					
				<td>
					<input class="txt" id="txtOrdeno.*" type="text" style="width:65%;" />
					<input class="txt" id="txtNo2.*" type="text" style="width:25%;"/>					
				</td>
				<td>
					<input class="txt" id="txtMechno.*" type="text" style="width:75%;" />
					<input class="btn" id="btnMechno.*" type="button" value="."/>
					<input class="txt c1" id="txtMech.*" type="text"/>					
				</td>
				<td>
					<input class="txt" id="txtCustno.*" type="text" style="width:75%;" />
					<input class="btn" id="btnCustno.*" type="button" value="."/>
					<input class="txt c1" id="txtCust.*" type="text"/>					
				</td>
				<td>
					<input class="txt" id="txtProductno.*" type="text" style="width:75%;" />
					<input class="btn" id="btnProductno.*" type="button" value="."/>
					<input class="txt c1" id="txtProduct.*" type="text"/>					
				</td>
				<td><input class="txt c1 num" id="txtRadius.*" type="text"/></td>					
				<td><input class="txt c1 num" id="txtWidth.*" type="text"/></td>					
				<td><input class="txt c1 num" id="txtDime.*" type="text"/></td>					
				<td><input class="txt c1 num" id="txtLengthb.*" type="text"/></td>					
				<td><input class="txt c1 num" id="txtHours.*" type="text"/></td>					
				<td><input class="txt c1 num" id="txtMount.*" type="text"/></td>					
				<td><input class="txt c1 num" id="txtWeight.*" type="text"/></td>					
           </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
