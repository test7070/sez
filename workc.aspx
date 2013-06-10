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
        var q_name = "workc";
        var decbbs = ['weight', 'mount'];
        var decbbm = ['mount', 'price'];
        var q_readonly = ['txtNoa','txtWorker'];
        var q_readonlys = [];
        var bbmNum = [['txtPrice', 10, 3]];  // 允許 key 小數
        var bbsNum = [['txtMount', 15, 4]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'Datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
        aPop = new Array(
        	['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],
        	['txtStoreno','lblStore','store','noa,store','txtStoreno,txtStore','store_b.aspx'],
        	['txtProcessno','lblProcess','process','noa,process','txtProcessno,txtProcess','process_b.aspx'],
        	['txtProcessno_','btnProcessno_','process','noa,process','txtProcessno_,txtProcess_','process_b.aspx'],
        	['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']
        );
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_mask(bbmMask);
            q_brwCount();  // 計算 合適  brwCount
			q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
            
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
            bbmMask = [['txtDatea', r_picd], ['txtCucdate', r_picd]];
            q_mask(bbmMask);
            $('#btnImportWorka').click(function(){
            	var t_workno = $.trim($('#txtWorkno').val());
            	if(!emp(t_workno)){
                	t_where = "workno='" + t_workno + "'";
                	q_box("workas_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workas', "95%", "95%", q_getMsg('popWorkas'));
            	}else{
            		alert('請輸入【' + q_getMsg('lblWorkno')+'】');
            	}
            });
		}

        function q_boxClose( s2) {
            var ret; 
            switch (b_pop ) {
				case 'workas':
					if (q_cur > 0 && q_cur < 4) {
						b_ret = getb_ret();
						if (!b_ret || b_ret.length == 0)
							return;
						var i, j = 0;
						ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMonunt,txtTypea', b_ret.length, b_ret
														   , 'productno,product,unit,mount,typea'
														   , 'txtProductno');   /// 最後 aEmpField 不可以有【數字欄位】
						bbsAssign();
					}
					break;
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
            }
        }

        function btnOk() {
        	t_err = '';
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtTggno', q_getMsg('lblTgg')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('WC' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
            q_box('workc_s.aspx', q_name + '_s', "510px", "330px", q_getMsg("popSeek"));
        }

        function bbsAssign() {  /// 表身運算式
            _bbsAssign();
            for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
                $('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });
            }
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

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['productno'] && !as['product'] ) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];
            as['custno'] = abbm2['custno'];
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
        .tview
        {
            FONT-SIZE: 12pt;
            COLOR:  Blue ;
            background:#FFCC00;
            padding: 3px;
            TEXT-ALIGN:  center;
        }    
        .tbbm
        {
            FONT-SIZE: 12pt;
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
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
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
			.txt {
				float: left;
			}
            .txt.c1 {
                width: 95%;
            }
            .txt.c2 {
                width: 46%;
            }
			.num{
				text-align: right;
			}      
			input[type="text"],input[type="button"] {     
				font-size: medium;
			}
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewOrdeno'></a></td>
                <td align="center" style="width:40%"><a id='vewProduct'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/>.</td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='ordeno'>~ordeno</td>
                   <td align="center" id='productno product'>~productno ~product</td>
            </tr>
        	</table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>

        <tr>
        	<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
            <td><input id="txtDatea" type="text" class="txt c1"/></td>
        	<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
            <td><input id="txtNoa"   type="text"  class="txt c1"/></td> 
        	<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
            <td><input id="txtWorker" type="text"  class="txt c1"/></td>
		</tr>
        <tr>
        	<td><span> </span><a id='lblStore' class="lbl btn"> </a></td>
            <td>
            	<input id="txtStoreno" type="text" class="txt c2"/>
            	<input id="txtStore" type="text" class="txt c2"/>
            </td> 
        	<td><span> </span><a id='lblProcess' class="lbl btn"> </a></td>
            <td>
            	<input id="txtProcessno" type="text"  class="txt c2"/>
            	<input id="txtProcess" type="text"  class="txt c2"/>
            </td>
        	<td><span> </span><a id='lblOrdeno' class="lbl"> </a></td>
            <td>
            	<input id="txtOrdeno" type="text" class="txt" style='width:70%;'/>
            	<input id="txtNo2" type="text" class="txt" style='width:20%;'/>
            </td>
		</tr>
        <tr>
        	<td><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
            <td>
            	<input id="txtTggno" type="text" class="txt c2"/>
            	<input id="txtTgg" type="text"  class="txt c2"/>
            </td>
        	<td><span> </span><a id='lblCucdate' class="lbl"> </a></td>
            <td><input id="txtCucdate" type="text" class="txt c1"/></td>
        	<td><span> </span><a id='lblWorkno' class="lbl"> </a></td>
            <td><input id="txtWorkno" type="text"  class="txt c1"/></td></tr>
		<tr>
        	<td><span> </span><a id='lblProductno' class="lbl"> </a></td>
			<td><input id="txtProductno" type="text" class="txt c1"/></td>
        	<td><span> </span><a id='lblMold' class="lbl"> </a></td>
        	<td>
        		<input id="txtMoldno" type="text" class="txt c2"/>
        		<input id="txtMold" type="text" class="txt c2"/>
        	</td>
        	<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
        	<td><input id="txtPrice" type="text" class="txt c1 num"/></td>
        </tr>
		<tr>
        	<td><span> </span><a id='lblProduct' class="lbl"> </a></td>
			<td colspan='4'><input id="txtProduct" type="text" style="width: 98%;"/></td>
			<td><input class="btn"  id="btnImportWorka" type="button"/></td>
		</tr>
        <tr>
        	<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
	        <td colspan='5'><input id="txtMemo" type="text" style="width: 98%;"/></td>
		</tr>
        </table>
        </div>

        <div class='dbbs'>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td style="width:1%;" align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td style="width:15%;" align="center"><a id='lblProductnos'></a></td>
                <td style="width:20%;" align="center"><a id='lblProducts'></a></td>
                <td style="width:4%;" align="center"><a id='lblUnit'></a></td>
                <td style="width:12%;" align="center"><a id='lblMounts'></a></td>
                <td style="width:15%;" align="center"><a id='lblProcesss'></a></td>
                <td style="width:10%;" align="center"><a id='lblTypes'></a></td>
                <td style="width:12%;" align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td>
                	<input class="txt" id="txtProductno.*" type="text" style="width:80%;" />
                	<input class="btn" id="btnProductno.*" type="button" value='...' style="width:12%;"  />
                </td>
                <td><input id="txtProduct.*" type="text" class="txt c1"/></td>
                <td><input id="txtUnit.*" type="text" class="txt c1"/></td>
                <td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
                <td>
                	<input class="txt" id="txtProcessno.*" type="text" style="width:25%;" />
                	<input class="txt" id="txtProcess.*" type="text" style="width:60%;" />
                	<input class="btn" id="btnProcessno.*" type="button" value='.' style="width:1%;"  />
                </td>
                <td><input id="txtTypea.*" type="text" class="txt c1"/></td>
                <td><input id="txtMemo.*" type="text" class="txt c1"/>
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
