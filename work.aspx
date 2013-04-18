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
        var q_readonly = ['txtComp']; 
        var q_readonlys = ['txtOrdeno', 'txtNo2', 'txtNoq']; 
        var bbmNum = [['txtPrice', 10, 3]];  // 允許 key 小數
        var bbsNum = [['txtMount', 15, 4], ['txtGmount', 15, 4], ['txtEmount', 15, 4]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'Datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
        
        aPop = new Array(
        	['txtProductno', 'lblProductno', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx'],
        	['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
        	);


        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];

            q_brwCount();  // 計算 合適  brwCount 

            if (!q_gt(q_name, q_content, q_sqlCount, 1))  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
                return;

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
            bbmMask = [['txtDatea', r_picd], ['txtDatea', r_picd], ['txtWorkdate', r_picd], ['txtUindate', r_picd], ['txtEnddate', r_picd]];
            q_mask(bbmMask);
        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
            var ret; 
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
            	case 'td':
            		ret = getb_ret();
	                if(ret[0]!=undefined){
	                	$('#txtTproductno_'+b_seq).val(ret[0].noa)
	                	$('#txtTproduct_'+b_seq).val(ret[0].product)
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
                case q_name: if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')] ]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0][0].toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('K' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('work_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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
           				t_where = "CHARINDEX(noa,(select td from uca a left join ucas b on a.noa=b.noa where a.noa='"+$('#txtProductno').val()+"' and b.productno='"+$('#txtProductno_'+b_seq).val()+"'))>0";
           				q_box("ucc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'td', "95%", "650px", q_getMsg('popTd'));
           			});
           		}
           	}
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
         }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtProduct').focus();
        }
        function btnPrint() {
 
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
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j

            format();
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
        .tview
        {
            FONT-SIZE: 12pt;
            COLOR:  Blue ;
            background:#FFCC00;
            padding: 3px;
            TEXT-ALIGN:  center
        }    
        .tbbm
        {
            font-size: 15px;
            COLOR: blue;
            TEXT-ALIGN: left;
            border-color: white; 
            width:98%; border-collapse: collapse; background:#cad3ff;
        } 
        
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:98% ; height:98% ;  
        } 
        
       
        .column1
        {
            width: 8%;
        }
        .column2
        {
            width: 10%;
        }      
        .column3
        {
            width: 8%;
        }   
        .column4
        {
            width: 8%;
        }           
         .label1
        {
            width: 12%; text-align:right;
        }       
        .label2
        {
            width: 12%; text-align:right;
        }
        .label3
        {
            width: 12%; text-align:right;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="height: 98%">
<!--#include file="../inc/toolbar.inc"-->
        <div class="dview" id="dview" style="float: left;  width:30%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewOrdeno'></a></td>
                <td align="center" style="width:20%"><a id='vewComp'></a></td>
                <td align="center" style="width:40%"><a id='vewProduct'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox"></td>
                   <td align="center" id='ordeno'>~ordeno</td>
                   <td align="center" id='comp,4'>~comp,4</td>
                   <td align="center" id='productno product'>~productno ~product</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 70%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
	        <tr>
		        <td class='label1'><span> </span><a id="lblNoa" > </a></td>
		        <td><input id="txtNoa"   type="text"  maxlength='20' style='width:98%;'/></td>
		        <td class='label2'><span> </span><a id="lblCucdate" > </a></td>
		        <td><input id="txtCuadate" maxlength='30' type="text" style='width:98%;'/></td>
				<td class='label3'><span> </span><a id="lblMount" > </a></td>
				<td><input id="txtMount" maxlength='30' type="text"  style='width:98%;'/></td> 
			</tr>
	        <tr>
		        <td class='label1'><span> </span><a id="lblDatea" > </a></td>
		        <td>
		        	<input id="txtDatea" maxlength='10' type="text" style='width:45%;'/>
		            <span> </span><a id="lblEnda" > </a>
		            <input id="txtEnda" maxlength='30' type="text" style='width:10%;'/>
		        </td>
		        <td class='label2'><span> </span><a id="lblWorkdate" > </a></td>
		        <td><input id="txtWorkdate" maxlength='30' type="text"  style='width:98%;'/></td>
		        <td class='label3'><span> </span><a id="lblInmount" > </a></td>
		        <td><input id="txtInmount" maxlength='30' type="text"  style='width:98%;text-align:right;'/></td>
	        </tr>
	        <tr>
				<td class='label1'><span> </span><a id="lblProductno" > </a></td>
				<td><input id="txtProductno" maxlength='30' type="text"  style='width:98%;'/></td>
		        <td class='label2'><span> </span><a id="lblUindate" > </a></td>
		        <td><input id="txtUindate" maxlength='30' type="text"  style='width:98%;'/></td>
		        <td class='label3'><span> </span><a id="lblRmount" > </a></td>
		        <td><input id="txtRmount" maxlength='30' type="text"  style='width:98%;text-align:right;'/></td>
	        </tr>
	        <tr>
				<td class='label1'><span> </span><a id="lblProduct" > </a></td>
				<td><input id="txtProduct" maxlength='90' type="text"  style='width:98%;'/></td>
		        <td class='label2'><span> </span><a id="lblEnddate" > </a></td>
		        <td><input id="txtEnddate" maxlength='30' type="text"  style='width:98%;'/></td>
		        <td class='label3'><span> </span><a id="lblErrmount" > </a></td>
		        <td><input id="txtErrmount" maxlength='30' type="text"  style='width:98%;text-align:right;'/></td>
	        </tr>
	        <tr>
				<td class='label1'><span> </span><a id="lblStation" > </a></td>
				<td>
					<input id="txtStationno" maxlength='30' type="text"  style='width:45%;'/>
					<input id="txtStation" maxlength='90' type="text"  style='width:45%;'/>
				</td>
				<td class='label2'><span> </span><a id="lblRank" > </a></td>
				<td><input id="txtRank" maxlength='30' type="text"  style='width:98%;'/></td>
		        <td class='label3'><span> </span><a id="lblOrdeno" > </a></td>
		        <td>
		        	<input id="txtOrdeno" maxlength='30' type="text"  style='width:80%;'/>
					<input id="txtNo2" maxlength='10' type="text"  style='width:10%;'/>
				</td>
			</tr>
	        <tr>
		        <td class='label1'><span> </span><a id="lblComp" > </a></td>
		        <td>
		        	<input id="txtTggno" maxlength='90' type="text"  style='width:45%;'/>
		        	<input id="txtComp" maxlength='90' type="text"  style='width:45%;'/>
		        </td>
				<td class='label2'><span> </span><a id="lblPrice" > </a></td>
				<td><input id="txtPrice" maxlength='30' type="text"  style='width:98%;text-align:right;'/></td>
		        <td class='label3'><span> </span><a id="lblCucno" > </a></td>
		        <td><input id="txtCucno" maxlength='30' type="text"  style='width:98%;'/></td>
	        </tr>
	
	        <tr>
		        <td class='label1'><span> </span><a id="lblProcess" > </a></td>
		        <td>
		        	<input id="txtProcessNo" maxlength='30' type="text"  style='width:45%;'/>
		        	<input id="txtProcess" maxlength='30' type="text"  style='width:45%;'/>
		        </td>
				<td class='label2'><span> </span><a id="lblHours" > </a></td>
				<td><input id="txtHours" maxlength='30' type="text"  style='width:98%;text-align:right;'/></td>
		        <td class='label3'><span> </span><a id="lblUno" > </a></td>
		        <td><input id="txtUno" maxlength='30' type="text"  style='width:98%;'/></td>
	        </tr>
	        <tr>
		        <td class='label1'><span> </span><a id="lblMold" > </a></td>
		        <td>
		        	<input id="txtMoldno" maxlength='30' type="text"  style='width:45%;'/>
		        	<input  type="text" id="txtMold" style="width:45%" />
		        </td>
		        <td class='label2'><span> </span><a id="lblMemo" > </a></td>
		        <td colspan='3'><input id="txtMemo" maxlength='90' type="text"  style='width:98%;'/></td>
	        </tr>
        </table>
        </div>

        <div class='dbbs'>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblProcesss'></a></td>
                <td align="center"><a id='lblProducts'></a></td>
                <td align="center"><a id='lblUnit'></a></td>
                <td align="center"><a id='lblCucdates'></a></td>
                <td align="center"><a id='lblMounts'></a></td>
                <td align="center"><a id='lblGmount'></a></td>
                <td align="center"><a id='lblEmount'></a></td>
                <td align="center"><a id='lblTd'></a></td>
                <td align="center"><a id='lblTproduct'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;">
                	<input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
                </td>
                <td style="width:10%; text-align:center">
                	<input class="txt"  id="txtProcess.*" maxlength='30'type="text" style="width:98%;" />
                </td>
                <td style="width:20%;">
                	<input class="txt"  id="txtProductno.*" maxlength='30'type="text" style="width:98%;" />
                	<input class="txt" id="txtProduct.*" type="text" maxlength='90' style="width:98%;" />
                	<input class="btn"  id="btnProductno.*" type="button" value='...' style=" font-weight: bold;" />
                </td>
                <td style="width:4%;">
                	<input class="txt" id="txtUnit.*" type="text" maxlength='10' style="width:94%;"/>
                </td>
                <td style="width:8%;">
                	<input class="txt" id="txtCucdate.*" type="text" maxlength='10' style="width:94%;"/>
                </td>
                <td style="width:8%;">
                	<input class="txt" id="txtMount.*" type="text" maxlength='20' style="width:94%; text-align:right;text-align:right;"/>
                </td>
                <td style="width:8%;">
                	<input class="txt" id="txtGmount.*" type="text" maxlength='20' style="width:96%; text-align:right;text-align:right;"/>
                </td>
                <td style="width:8%;">
                	<input class="txt" id="txtEmount.*" type="text"  maxlength='20' style="width:96%; text-align:right;text-align:right;"/>
                </td>
                <td style="width:3%;">
                	<!--<input class="txt" id="txtTd.*" type="text" maxlength='20' style="width:96%; text-align:right;"/>-->
                	<input id="chkIstd" type="checkbox" style="float: left;"/>
                    <input class="btn"  id="btnTproductno.*" type="button" value='...' style=" font-weight: bold;" />
                </td>
                <td style="width:20%;">
                	<input class="txt"  id="txtTproductno.*" maxlength='30'type="text" style="width:98%;" />
                    <input class="txt" id="txtTproduct.*" type="text" maxlength='90' style="width:98%;" />
                </td>
                <td style="width:12%;">
                	<input class="txt" id="txtMemo.*" type="text" maxlength='90' style="width:98%;"/>
                	<input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" />
                </td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
    
    </form>
</body>
</html>
