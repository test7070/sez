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
			q_desc=1;
            q_tables = 's';
            var q_name = "costa";
            var q_readonly = ['txtNoa'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtMoney', 15, 0, 1],['txtTotal', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 3;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            aPop = new Array(
            	['txtAcc1_', 'btnAcc1_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy+ '_' + r_cno]
			);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }
            function mainPost() {
				q_getFormat();
				bbmMask = [['txtMon', r_picm]];
				bbsMask = [];
				q_mask(bbmMask);
            }
		
            function q_boxClose(s2) {///   q_boxClose 2/4
				var	ret;
				b_ret = getb_ret();
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'workb':
                			var as = _q_appendData("workb", "", true);
                		break;
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
            	t_err = '';
                t_err = q_chkEmpField([['txtMon', q_getMsg('lblMon')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_costa') + q_date(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('costa_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
            		  if (!$('#btnMinus_' + j).hasClass('isAssign')) {
            		  }
                }
                
                $('#tbbs .num').change(function() {sum();});
                
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtMon').val(q_date().substr(0,6));
                $('#txtMon').focus();
                
                var t_acc1= new Array('5100.','5110.','5120.','5130.','5140.','5150.','5160.','5170.',
													'5200.','5210.','5220.','5230.','5240.','5300.','5400.','5410.',
													'5500.','5510.','5520.','5530.','5540.','5550.','5560.','5570.',
													'5600.','5610.','5620.','5630.','5640.','5650.','5660.','5670.',
													'5680.','5690.','5700.','5800.','5810.','5900.'
				)
                var t_acc2= new Array('直接原料','　期初存料', '　加：本期進料',' 　　　加工轉入','　減：期末存料','　　　出售原料'
													,'　　　加工轉出','　　　商品盤盈','間接原料','　期初物料','　加：本期進料','　減：期末盤存'
													,'　　　轉作製造費用','直接人工','製造費用','減：委外加工費沖轉','製造成本','加：期初在製品'
													,'　　本期進貨','　　加工轉入','　　商品盤盈','減：期末在製品','　　轉自用'
													,'　　加工轉出','製造品成本','加：期初製成品','　　本期進貨','　　委外加工轉入','　　下腳存貨'
													,'　　商品盤盈','減：期末製成品','　　期末下腳存貨','　　加工轉出','　　轉自用'
													,'　　商品盤虧','銷貨成本','加：出售原料成本','營業成本'
				)
				
				for (var j = 0; j < t_acc1.length; j++) {
                	if($('#txtAcc1_'+j).length==0)
						$('#btnPlus').click();
					$('#txtAcc1_'+j).val(t_acc1[j]);
                }
                
                for (var j = 0; j < t_acc2.length; j++) {
                	if($('#txtAcc2_'+j).length==0)
						$('#btnPlus').click();
					$('#txtAcc2_'+j).val(t_acc2[j]);
                }
                
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                
            }

            function btnPrint() {
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['acc1']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['mon'] = abbm2['mon'];
                return true;
            }


            function refresh(recno) {
                _refresh(recno);
                
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
              
            }
            
            function sum() {
            	var t_total1=0,t_total2 = 0, t_total3 = 0, t_total4 = 0, t_total5 = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                	//直接原料
                	if($('#txtAcc1_'+j).val().substr(0,5)>='5110.' && $('#txtAcc1_'+j).val().substr(0,5)<='5130.')
                		t_total1+=q_float('txtMoney_'+j);
                	if($('#txtAcc1_'+j).val().substr(0,5)>='5140.' && $('#txtAcc1_'+j).val().substr(0,5)<='5170.')
                		t_total1-=q_float('txtMoney_'+j);
                	//製造成本
                	if($('#txtAcc1_'+j).val().substr(0,5)>='5300.' && $('#txtAcc1_'+j).val().substr(0,5)<='5400.')
                		t_total2+=q_float('txtMoney_'+j);
                	if($('#txtAcc1_'+j).val().substr(0,5)=='5410.')
                		t_total2-=q_float('txtMoney_'+j);
                	//製造品成本
                	if($('#txtAcc1_'+j).val().substr(0,5)>='5510.' && $('#txtAcc1_'+j).val().substr(0,5)<='5540.')
                		t_total3+=q_float('txtMoney_'+j);
                	if($('#txtAcc1_'+j).val().substr(0,5)>='5550.' && $('#txtAcc1_'+j).val().substr(0,5)<='5570.')
                		t_total3-=q_float('txtMoney_'+j);
					//銷貨成本
                	if($('#txtAcc1_'+j).val().substr(0,5)>='5610.' && $('#txtAcc1_'+j).val().substr(0,5)<='5650.')
                		t_total4+=q_float('txtMoney_'+j);
                	if($('#txtAcc1_'+j).val().substr(0,5)>='5660.' && $('#txtAcc1_'+j).val().substr(0,5)<='5700.')
                		t_total4-=q_float('txtMoney_'+j);
                	//營業成本
                	if($('#txtAcc1_'+j).val().substr(0,5)=='5810.')
                		t_total5+=q_float('txtMoney_'+j);
                }
                
                for (var j = 0; j < q_bbsCount; j++) {
                	if($('#txtAcc1_'+j).val().substr(0,5)=='5100.')
                		q_tr('txtTotal_'+j,t_total1);//直接原料
                	if($('#txtAcc1_'+j).val().substr(0,5)=='5500.')
                		q_tr('txtTotal_'+j,t_total2+t_total1);//製造成本
                	if($('#txtAcc1_'+j).val().substr(0,5)=='5600.')
                		q_tr('txtTotal_'+j,t_total3+t_total2+t_total1);//製造品成本
					if($('#txtAcc1_'+j).val().substr(0,5)=='5800.')
                		q_tr('txtTotal_'+j,t_total4+t_total3+t_total2+t_total1);//銷貨成本
                	if($('#txtAcc1_'+j).val().substr(0,5)=='5900.')
                		q_tr('txtTotal_'+j,t_total5+t_total4+t_total3+t_total2+t_total1);//營業成本
                }
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
                width: 350px;
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
                width: 400px;
                /*margin: -1px;
                border: 1px black solid;*/
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
            .txt.c7 {
            	float:left;
                width: 22%;
                
            }
            .txt.c8 {
            	float:left;
                width: 65px;
                
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
         .dbbs{
         	width: 600px;
         }
         .dbbs .tbbs{
         	margin:0;
         	padding:2px;
         	border:2px lightgrey double;
         	border-spacing:1px;
         	border-collapse:collapse;
         	font-size:medium;
         	color:blue;
         	background:#cad3ff;
         	width: 600px;
         }
		 .dbbs .tbbs tr{
		 	height:35px;
		 }
		 .dbbs .tbbs tr td{
		 	text-align:center;
		 	border:2px lightgrey double;
		 }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:20%"><a id='vewNoa'> </a></td>
                <td align="center" style="width:25%"><a id='vewMon'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='mon'>~mon</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
        	<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
            <td class="td3"><span> </span><a id="lblMon" class="lbl"> </a></td>
            <td class="td4"><input id="txtMon" type="text" class="txt c1"/></td>
        </tr>
        </table>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>

                <td align="center" style="width:14%;"><a id='lblAcc1_s'> </a></td>
                <td align="center" style="width:10%;"><a id='lblMoney_s'> </a> </td>
                <td align="center" style="width:10%;"><a id='lblTotal_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td ><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td >
                	<input  id="txtAcc1.*" type="text" style="width:80%;" />
                	<input class="btn"  id="btnAcc1.*" type="button" value='.' style=" font-weight: bold;width:1%;float:right;" />
                	<input  id="txtAcc2.*" type="text" style="width:80%;"/><input id="txtNoq.*" type="hidden" />
                </td>
                <td ><input  id="txtMoney.*" type="text" class="txt c1 num"/>
                </td>
                <td ><input  id="txtTotal.*" type="text" class="txt c1 num"/></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
