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
        var q_name = "work";
        var decbbs = ['weight', 'uweight', 'mount', 'gmount', 'emount', 'hours'];
        var decbbm = ['mount', 'inmount', 'errmount', 'rmount', 'price', 'hours'];
        var q_readonly = ['txtNoa','txtComp','txtProduct','txtStation']; 
        var q_readonlys = ['txtOrdeno', 'txtNo2', 'txtNoq','txtTproductno','txtTproduct']; 
        var bbmNum = [['txtPrice', 10, 2, 1],['txtWmount', 10, 0,1], ['txtWages_fee', 15, 2, 1], ['txtMakes_fee', 15, 2, 1]];  // 允許 key 小數
        var bbsNum = [['txtMount', 15, 2, 1], ['txtGmount', 15, 2, 1], ['txtEmount', 15, 2, 1], ['txtCost', 15, 0, 1], ['txtPrice', 15, 0, 1]];
        var bbmMask = [];
        var bbsMask = [['txtCuadate','999/99/99']];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'Datea'; q_desc = 1;
        //ajaxPath = ""; // 只在根目錄執行，才需設定
        
        aPop = new Array(
        	['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx'],
        	['txtProductno', 'lblProductno', 'ucaucc', 'noa,product', 'txtProductno,txtProduct', 'ucaucc_b.aspx'],
        	['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'],
        	['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
        	['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
        	['txtProcessno_', 'btnProcessno_', 'process', 'noa,process', 'txtProcessno_,txtProcess_', 'process_b.aspx']
        	);


        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];

            q_brwCount();  // 計算 合適  brwCount 
			//q_gt(q_name, q_content, q_sqlCount, 1)
			q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            /*if (!q_gt(q_name, q_content, q_sqlCount, 1))  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
                return;*/
        });

        //////////////////   end Ready
       function main() {
           if (dataErr)  /// 載入資料錯誤
           {
               dataErr = false;
               return;
           }

            q_mask(bbmMask);

            mainForm(1); // 1=最後一筆  0=第一筆

            $('#txtDatea').focus();
            
        }  ///  end Main()


        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd], ['txtWorkdate', r_picd], ['txtUindate', r_picd], ['txtCuadate',r_picd] , ['txtEnddate', r_picd]];
            q_mask(bbmMask);
          /*  bbsMask = [['txtCuadate',r_picd]];
            q_mask(bbsMask);*/
            
            $('#txtProductno').change(function () {
            	var t_where = "where=^^ noa ='"+$('#txtProductno').val()+"' ^^";
			    q_gt('uca', t_where , 0, 0, 0, "", r_accy);
			 });
            
        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
            var ret; 
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
            	case 'td':
            		ret = getb_ret();
	                if(ret[0]!=undefined){
	                	//1020629將替代品直接取代品名欄位不需要在寫入下面欄位
	                	$('#txtProductno_'+b_seq).val(ret[0].uccno)
	                	$('#txtProduct_'+b_seq).val(ret[0].product)
	                }
            		break;
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  /// 資料下載後 ...
            switch (t_name) {
            	case 'uca':
            		var as = _q_appendData("ucas", "", true);
            		if(as[0]!=undefined){
            			q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount'
            								, as.length, as, 'productno,product,unit,mount', '');
            		}
            		break;
                case q_name: 
               		if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        

        function btnOk() {
        	t_err = ''
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')] ]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();
			var t_date = $('#txtDatea').val();
            var s1 = $('#txt' + bbmKey[0][0].toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll(q_getPara('sys.key_work') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('work_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
        }
        

        function bbsAssign() {  /// 表身運算式
        	for(var j = 0; j < q_bbsCount; j++) {
           		if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           			$('#btnTproductno_' + j).click(function () {
           				t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
           				//t_where = "CHARINDEX(noa,(select td from uca a left join ucas b on a.noa=b.noa where a.noa='"+$('#txtProductno').val()+"' and b.productno='"+$('#txtProductno_'+b_seq).val()+"'))>0";
           				t_where = "noa='" + $('#txtProductno_'+b_seq).val() + "'";
           				q_box("ucctd_b2.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'td', "95%", "650px", q_getMsg('popTd'));
           			});
           			$('#chkIstd_' + j).click(function () {
           				t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
           				if($('#chkIstd_'+b_seq)[0].checked==true && (q_cur>0 &&q_cur<3)){
		            		$('#btnTproductno_'+b_seq).show();
		            	}else{
		            		$('#btnTproductno_'+b_seq).hide();
		            	}
           			});
           		}
           	}
            _bbsAssign();
            
            for(var j = 0; j < q_bbsCount; j++) {
            	if($('#chkIstd_'+j)[0].checked==true && (q_cur>0 &&q_cur<3)){
            		$('#btnTproductno_'+j).show();
            	}else{
            		$('#btnTproductno_'+j).hide();
            	}
            }
        }

        function btnIns() {
            _btnIns();
            $('#txtNoa').val('AUTO');
            $('#txtDatea').val(q_date()).focus();
            $('#txtCuano').attr('disabled', 'disabled');
         }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtProduct').focus();
        }
        function btnPrint() {
			q_box('z_workp.aspx'+ "?;;;;"+r_accy+";", '', "95%", "95%", q_getMsg("popPrint")); 
        }

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0][0].toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['productno'] && !as['product'] ) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
                return;
            }

            q_nowf();
			as['ordeno'] = abbm2['ordeno'];
			as['no2'] = abbm2['no2'];
			as['tggno'] = abbm2['tggno'];

            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j
        }
        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
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
                bbsAssign();  /// 表身運算式 
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
                <td align="center" style="width:20%"><a id='vewComp'></a></td>
                <td align="center" style="width:40%"><a id='vewProduct'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox"></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='comp,4'>~comp,4</td>
                   <td align="center" id='productno product'>~productno ~product</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 70%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
	        <tr class="tr1">
		        <td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
		        <td class="td2"><input id="txtNoa" type="text"  class="txt"/></td>
		        <td class="td3"><span> </span><a id="lblCuadate" class="lbl"> </a></td>
		        <td class="td4"><input id="txtCuadate" type="text"  class="txt"/></td>
				<td class="td5"><span> </span><a id="lblMount" class="lbl"> </a></td>
				<td class="td6"><input id="txtMount" type="text"  class="txt num"/></td> 
			</tr>
	        <tr class="tr2">
		        <td class="td1"><span> </span><a id="lblDatea" class="lbl"> </a></td>
		        <td class="td2">
		        	<input id="txtDatea" type="text"  class="txt" style="width: 50%"/>
		        	</br>
		            <input id="chkEnda" type="checkbox" style="float: left;" />
		            <span> </span><a id="lblEnda" class="lbl" style="float: left;"> </a>
		            <input id="chkIsrework" type="checkbox" style="float: left;" />
		            <span> </span><a id="lblIsrework" class="lbl" style="float: left;"> </a>
		        </td>
		        <td class="td3"><span> </span><a id="lblWorkdate" class="lbl"> </a></td>
		        <td class="td4"><input id="txtWorkdate" type="text"  class="txt"/></td>
				<td class="td5"><span> </span><a id="lblUnit" class="lbl"> </a></td>
		        <td class="td6"><input id="txtUnit" type="text"  class="txt"/></td>
	        </tr>
	        <tr class="tr3">
		        <td class="td1"><span> </span><a id="lblProductno" class="lbl btn"> </a></td>
		        <td class="td2"><input id="txtProductno" type="text"  class="txt"/></td>
		        <td class="td3"><span> </span><a id="lblUindate" class="lbl"> </a></td>
		        <td class="td4"><input id="txtUindate" type="text"  class="txt"/></td>
		        <td class="td5"><span> </span><a id="lblInmount" class="lbl"> </a></td>
		        <td class="td6"><input id="txtInmount" type="text"  class="txt num"/></td>
			</tr>
			<tr class="tr4">
		        <td class="td1"><span> </span><a id="lblProduct" class="lbl"> </a></td>
		        <td class="td2"><input id="txtProduct" type="text"  class="txt"/></td>
		        <td class="td3"><span> </span><a id="lblEnddate" class="lbl"> </a></td>
		        <td class="td4"><input id="txtEnddate" type="text"  class="txt"/></td>
				<td class="td5"><span> </span><a id="lblRmount" class="lbl"> </a></td>
				<td class="td6"><input id="txtRmount" type="text"  class="txt num"/></td> 
			</tr>
	        <tr class="tr5">
		        <td class="td1"><span> </span><a id="lblStation" class="lbl btn"> </a></td>
		        <td class="td2">
		        	<input id="txtStationno" type="text"  class="txt" style="width: 45%"/>
		        	<input id="txtStation" type="text"  class="txt" style="width: 45%"/>
		        </td>
		        <td class="td3"><span> </span><a id="lblRank" class="lbl"> </a></td>
		        <td class="td4"><input id="txtRank" type="text"  class="txt"/></td>
		        <td class="td5"><span> </span><a id="lblWmount" class="lbl"> </a></td>
				<td class="td6"><input id="txtWmount" type="text"  class="txt num"/></td>
				<!--<td class="td5"><span> </span><a id="lblErrmount" class="lbl"> </a></td>
				<td class="td6"><input id="txtErrmount" type="text"  class="txt num"/></td>--> 
			</tr>
			<tr class="tr6">
		        <td class="td1"><span> </span><a id="lblTggno" class="lbl btn"> </a></td>
		        <td class="td2">
		        	<input id="txtTggno" type="text"  class="txt" style="width: 45%"/>
		        	<input id="txtComp" type="text"  class="txt" style="width: 45%"/>
		        </td>
		        <td class="td3"><span> </span><a id="lblPrice" class="lbl"> </a></td>
		        <td class="td4"><input id="txtPrice" type="text"  class="txt num"/></td>
				<td class="td5"><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
				<td class="td6">
					<input id="txtOrdeno" type="text"  class="txt" style="width: 70%"/>
					<input id="txtNo2" type="text"  class="txt" style="width: 20%"/>
				</td> 
			</tr>
			<tr class="tr7">
		        <td class="td1"><span> </span><a id="lblProcess" class="lbl btn"> </a></td>
		        <td class="td2">
		        	<input id="txtProcessno" type="text"  class="txt" style="width: 45%"/>
		        	<input id="txtProcess" type="text"  class="txt" style="width: 45%"/>
		        </td>
		        <td class="td3"><span> </span><a id="lblModel" class="lbl"> </a></td>
		        <td class="td4">
		        	<input id="txtModelno" type="text"  class="txt" style="width: 45%"/>
		        	<input id="txtModel" type="text"  class="txt" style="width: 45%"/>
		        </td>
				<td class="td5"><span> </span><a id="lblCuano" class="lbl"> </a></td>
				<td class="td6">
					<input id="txtCuano" type="text"  class="txt" style="width: 70%"/>
					<input id="txtCuanoq" type="text"  class="txt" style="width: 20%"/>
				</td> 
			</tr>
	        <tr class="tr9">
		        <td class="td1"><span> </span><a id="lblWages" class="lbl"> </a></td>
		        <td class="td2"><input id="txtWages" type="text"  class="txt num"/></td>
		        <td class="td3"><span> </span><a id="lblMakes" class="lbl"> </a></td>
		        <td class="td4"><input id="txtMakes" type="text"  class="txt num"/></td>
		        <td class="td5"><span> </span><a id="lblHours" class="lbl"> </a></td>
		        <td class="td6"><input id="txtHours" type="text"  class="txt num"/></td> 
			</tr>
			<tr class="tr8">
		        <td class="td1"><span> </span><a id="lblWages_fee" class="lbl"> </a></td>
		        <td class="td2"><input id="txtWages_fee" type="text"  class="txt num"/></td>
		        <td class="td3"><span> </span><a id="lblMakes_fee" class="lbl"> </a></td>
		        <td class="td4"><input id="txtMakes_fee" type="text"  class="txt num"/></td>
			</tr>
			<tr class="tr10">
		        <td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
		        <td class="td2" colspan='5'>
		        	<input id="txtMemo" type="text"  class="txt c1 "/>
		        	<input id="txtUno" type="text"  class="txt" style="display: none;"/>
		        </td>
			</tr>
        </table>
        </div>

        <div class='dbbs'>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:10%;"><a id='lblProcesss'> </a></td>
                <td align="center" style="width:15%;"><a id='lblProduct_s'> </a></td>
                <td align="center" style="width:4%;"><a id='lblUnit_s'> </a></td>
                <td align="center" style="width:8%;"><a id='lblCuadates'> </a></td>
                <td align="center" style="width:8%;"><a id='lblMounts'> </a></td>
                <td align="center" style="width:8%;"><a id='lblGmount'> </a></td>
                <td align="center" style="width:8%;"><a id='lblEmount'> </a></td>
                <td align="center" style="width:3%;"><a id='lblTd'> </a></td>
                <!--<td align="center" style="width:17%;"><a id='lblTproduct_s'> </a></td>-->
                <td align="center" style="width:10%;"><a id='lblPrice_s'> </a></td>
                <td align="center" style="width:10%;"><a id='lblCosts'> </a></td>
                <td align="center"><a id='lblMemos'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td>	<input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td>
                	<input id="txtProcessno.*" type="text" class="txt c5"/>
                	<input class="btn"  id="btnProcessno.*" type="button" value='.' style=" font-weight: bold;" />
                	<input id="txtProcess.*" type="text" class="txt c1"/>
                </td>
                <td>
                	<input id="txtProductno.*" type="text" class="txt" style="width: 75%;"/>
                	<input class="btn"  id="btnProductno.*" type="button" value='...' style=" font-weight: bold;" />
                	<input id="txtProduct.*" type="text" class="txt c1"/>
                </td>
                <td><input id="txtUnit.*" type="text" class="txt c1"/></td>
                <td><input id="txtCuadate.*" type="text" class="txt c1"/></td>
                <td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
                <td><input id="txtGmount.*" type="text" class="txt c1 num"/></td>
                <td><input id="txtEmount.*" type="text" class="txt c1 num"/></td>
                <td align="center">
                	<!--<input id="txtTd.*" type="text" class="txt c1"/>-->
                	<input id="chkIstd.*" type="checkbox"/>
                    <input class="btn"  id="btnTproductno.*" type="button" value='...' style=" font-weight: bold;" />
                </td>
                <!--<td>//1020629將替代品直接取代品名欄位不需要在寫入下面欄位
                	<input id="txtTproductno.*" type="text" class="txt c1"/>
                	<input id="txtTproduct.*" type="text" class="txt c1"/>
                </td>-->
                <td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
                <td><input id="txtCost.*" type="text" class="txt c1 num"/></td>
                <td>
                	<input id="txtMemo.*" type="text" class="txt c1"/>
                	<input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" />
                </td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
