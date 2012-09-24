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
        var q_name = "vcca";
        var q_readonly = ['txtMoney','txtTotal','txtChkno','txtTax','txtAccno','txtWorker'];
        var q_readonlys = [];
        var bbmNum = [['txtMoney', 15, 0], ['txtTax', 15, 0], ['txtTotal', 15, 0]];  // 允許 key 小數
        var bbsNum = [['txtMount', 15, 3], ['txtGmount', 15, 4], ['txtEmount', 15, 4], ['txtPrice', 15, 3], ['txtTotal', 15, 0]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
		aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtComp2', 'acomp_b.aspx'],
		['txtCustno', 'lblCust', 'cust', 'noa,comp,serial,addr_invo', 'txtCustno,txtComp,txtSeria,txtAddress', 'cust_b.aspx'],
		['txtBuyerno', 'lblBuyer', 'cust', 'noa,comp', 'txtBuyerno,txtBuyer', 'cust_b.aspx'],
		['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  // 計算 合適  brwCount 
            q_gt(q_name, q_content, q_sqlCount, 1)  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
        });

        //////////////////   end Ready
        function main() {
            if (dataErr)  /// 載入資料錯誤
            {
                dataErr = false;
                return;
            }

            mainForm(1); // 1=最後一筆  0=第一筆
        }  

             function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd],['txtMon', r_picm]];
            q_mask(bbmMask);
             // 需在 main_form() 後執行，才會載入 系統參數
             q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));

             $('#ttxtTax').change(function () {
	              sum();
	         });
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
            var ret;
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }

		var ins = false;//判斷是否在新增狀態
		var noaerror =false; //判斷發票號碼是否有錯誤
		
        function q_gtPost(t_name) {  /// 資料下載後 ...
            switch (t_name) {
            	case 'vccar':
            		var as = _q_appendData("vccar", "", true);
            		if(as[0]==undefined)
            		{
            			 noaerror=true;
            			 alert("發票號碼不在範圍內或已輸入過");
                	}else {
                		noaerror=false;
                		ins=false;
						btnOk();
                	}
            		break;
            	case 'vcca1':
            			var as = _q_appendData("vcca", "", true);
                		if(!(as[0]==undefined))
            				$('#txtNoa').val((as[0].noa).substr(0,as[0].noa.length-2));
                		break;
                case q_name: 
                	if (q_cur == 4)   // 查詢
                   		q_Seek_gtPost();
                    	break;
            }  /// end switch
            
	            if(noaerror==true)
					return;
        	}

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtCno', q_getMsg('lblAcomp')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
	        /*if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
	        {
	              q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
	         }*/
			
			
			if(ins==true)
			{
				//判斷發票號碼是否存在或超過
				var t_where = "where=^^ cno = '"+ $('#txtCno').val()+"' and bdate<='"+$('#txtDatea').val()+"' and edate>='"+$('#txtDatea').val()		//判斷發票的日期
										+"' and binvono<='"+$('#txtNoa').val()+"' and einvono>='"+$('#txtNoa').val()			//判斷發票的範圍
										+"' and '"+$('#txtNoa').val()+"' not in (select noa from vcca ) and len(binvono)=len('"+$('#txtNoa').val()+"') ^^"; 	//判斷是否已存在與長度是否正確
	            q_gt('vccar', t_where , 0, 0, 0, "", r_accy);
			}
			else{
	            $('#txtWorker').val(r_name)
	            sum();
	            $('#txtNoa').attr('readonly', true);
	            wrServer(s1);
           }
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('vcca_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
        }

        function bbsAssign() {  /// 表身運算式
        	for (var j = 0; j < q_bbsCount; j++) {
        		//----------------數量和單價計算
            		$('#txtMount_'+j).change(function () {
		            		 t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                    q_bodyId($(this).attr('id'));
		                    b_seq = t_IdSeq;
		                	$('#txtTotal_'+b_seq).val(dec($('#txtMount_'+b_seq).val())*dec($('#txtPrice_'+b_seq).val()));
		                	
		                	sum();
		                });
		                
	            		$('#txtPrice_'+j).change(function () {
		            		 t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                    q_bodyId($(this).attr('id'));
		                    b_seq = t_IdSeq;
		                	$('#txtTotal_'+b_seq).val(dec($('#txtMount_'+b_seq).val())*dec($('#txtPrice_'+b_seq).val()));
		                	
		                	sum();
		                });
		                
        			$('#txtTotal_'+j).change(function () {
	                	sum();
	                });
        	}
        	
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            
            //$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            //取上個發票號碼並將後兩個數字拿掉
            //後面再寫判斷時間之間差12天
			var t_where = "where=^^ datea between '"+q_date().substr(0,6)+"' and '"+q_date()+"' and noa not like '%退貨%' ^^"; 
            ins=true;
            q_gt('vcca1', t_where , 0, 0, 0, "", r_accy);
            $('#cmbTaxtype').val(1);
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
            $('#txtNoa').attr('readonly', true); //讓發票號碼不可修改
            
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['productno'] && !as['product']) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];

            //            t_err ='';
            //            if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
            //                t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

            //            
            //            if (t_err) {
            //                alert(t_err)
            //                return false;
            //            }
            //            
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
             var t_money=0;
            for (var j = 0; j < q_bbsCount; j++) {
				t_money+=dec($('#txtTotal_'+j).val());//產品金額合計
				
            }  // j
            q_tr('txtMoney' ,t_money,0);
            //$('#txtTotal').val(t_money+t_tax);
            calTax();
        }
        function refresh(recno) {
            _refresh(recno);

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
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 61%;
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
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs{
            	float:left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select{
      			font-size: medium;
      		}
    </style>
    </head>
<body>
<!--#include file="../inc/toolbar.inc"-->
 <div id='dmain'>
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewNoa'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa<input id="txtnick"  type="hidden"/></td>
                   <td align="center" id='datea'>~datea</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
               <td class="td1"><span> </span><a id='lblDatea' class="lbl"></a></td>
               <td class="td2"><input id="txtDatea"  type="text"  class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblAcomp" class="lbl btn"></a></td>
            	<td class="td4" colspan="3"><input id="txtCno" type="text" class="txt c2"/>
            	<input id="txtComp2" type="text"  class="txt c3"/><input id="txtnick"  type="hidden"/></td> 
        </tr>
        <tr class="tr2">
            <td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
            <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class="td3"><span> </span><a id="lblCust" class="lbl btn" ></td>
            <td class="td4" colspan="3"><input id="txtCustno"  type="text"  class="txt c2"/>             
             <input id="txtComp" type="text"  class="txt c3"/></td>
        </tr>
        <tr class="tr3">
            <td class="td1"><span> </span><a id='lblSeria' class="lbl"></a></td>
            <td class="td2"><input id="txtSeria" type="text" class="txt c1"/></td>
            <td class="td3"><span> </span><a id='lblAddress' class="lbl"></a></td>
            <td class="td4" colspan="3"><input id="txtAddress"  type="text" style="width: 99%;float: left;"/></td>                                
        </tr>
        <tr class="tr4">
        	<td class="td1"><span> </span><a id='lblMon' class="lbl"></a></td>
            <td class="td2"><input id="txtMon"  type="text" class="txt c1"/></td>
        </tr>
        <tr class="tr5">
            <td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
            <td class="td2"><input id="txtMoney"  type="text"  class="txt num c1"/></td>            
            <td class="td3"><span> </span><a id='lblTax' class="lbl"></a></td>
            <td class="td4"><input id="txtTax"  type="text"  class="txt num c1"/></td>
            <td class="td5"><span> </span><a id='lblTotal' class="lbl"></a></td>
            <td class="td6"><input id="txtTotal"  type="text"  class="txt num c1"/></td>                                   
        </tr>
        <tr class="tr6">
            <td class="td1"><span> </span><a id='lblTaxtype' class="lbl"></a></td>
            <td class="td2"><select id="cmbTaxtype" style='width:100%'  onchange='calTax()' / ></select></td>
            <td class="td3"><span> </span><a id='lblChkno' class="lbl"></a></td>
            <td class="td4"><input id="txtChkno"  type="text" class="txt c1" /></td>     
            <td class="td5"><span> </span><a id='lblWorker' class="lbl"></a></td>
            <td class="td6"><input id="txtWorker"  type="text"  class="txt c1"/></td> 
        </tr>
        <tr class="tr7">
            <td class="td1"><span> </span><a id='lblAccno' class="lbl"></a></td>
            <td class="td2"><input id="txtAccno"  type="text" class="txt c1"/></td>
            <td class="td3"><span> </span><a id='lblBuyer' class="lbl btn"></a></td>
            <td class="td4" colspan="3">
            	<input id="txtBuyerno"  type="text"  class="txt c2"/>
            	<input id="txtBuyer" type="text"  class="txt c3"/>
            </td>
        </tr>
        <tr class="tr8">
            <td class="td1"><span> </span><a id="lblMemo" class="lbl" ></a></td>
            <td class="td2" colspan='5'><textarea id="txtMemo" rows="3" cols="10" style="width: 99%;"></textarea></td>
        </tr>
        </table>
        </div>
</div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" style="width: 15%;"><a id='lblProductno'></a></td>
                <td align="center" style="width: 20%;"><a id='lblProduct'></a></td>
                <td align="center" style="width: 5%;"><a id='lblUnit'></a></td>
                <td align="center" style="width: 10%;"><a id='lblMount'></a></td>
                <td align="center" style="width: 10%;"><a id='lblPrice'></a></td>
                <td align="center" style="width: 13%;"><a id='lblTotals'></a></td>
                <td align="center" ><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td ><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input style="width: 80%;" id="txtProductno.*" type="text" /><input id="btnProductno.*" type="button" value=".." style="width: 15%;" /></td>
                <td ><input class="txt c1" id="txtProduct.*" type="text" /></td>
                <td ><input class="txt c1" id="txtUnit.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtMount.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtPrice.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTotal.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtMemo.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
