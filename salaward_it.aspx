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
        q_tables = 's';
        var q_name = "salaward";
        var q_readonly = ['txtNoa','txtDatea','txtWorker','txtTotal'];
        var q_readonlys = ['txtMoney','txtTotal7','txtTotal8'];
        var bbmNum = [['txtTotal',10,0,1]];  // 允許 key 小數
        var bbsNum = [['txtTotal1',10,0,1],['txtTotal2',10,0,1],['txtTotal3',10,0,1],['txtTotal4',10,0,1],['txtTotal5',10,0,1],['txtMoney',15,0,1],['txtTaxrate',5,2,1],['txtTax',10,0,1],['txtTotal6',10,0,1],['txtTotal7',10,0,1],['txtTotal8',14,0,1],['txtFirstmoney',14,0,1],['txtSecondmoney',14,0,1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Noa';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
		aPop = new Array(['txtSssno_', 'lblSssno', 'sss', 'noa,namea,partno,part,jobno,job', 'txtSssno_,txtNamea_,txtPartno_,txtPart_,txtJobno_,txtJob_', 'sss_b.aspx']
				,['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx']);
		q_desc=1;
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  // 計算 合適  brwCount 
            q_gt(q_name, q_content, q_sqlCount, 1)
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
            bbmMask = [['txtDatea', r_picd],['txtYear', r_picm]];
            q_mask(bbmMask);
            q_mask(bbsMask);
            
            $('#btnImport').click(function() {
            	var t_where = "where=^^ noa!='Z001' and isnull(outdate,'')='' ^^";
	            q_gt('sss', t_where, 0, 0, 0, "", r_accy);
            });
            
        }
        
        function q_funcPost(t_func, result) {	
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
		
        function q_gtPost(t_name) {  /// 資料下載後 ...
            switch (t_name) {
            	case 'sss':
            		for (var i = 0; i < q_bbsCount; i++) {$('#btnMinus_' + i).click();}
            		var as = _q_appendData("sss", "", true);
            		for (var i = 0; i < as.length; i++) {
            			as[i].taxrate=5;
            		}
            		q_gridAddRow(bbsHtm, 'tbbs', 'txtSssno,txtNamea,txtPartno,txtPart,txtJob,txtTaxrate'
						, as.length, as, 'noa,namea,partno,part,job,taxrate', '');
            		break;
                case q_name: 
                	if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name);
            //sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('SW' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('salexam_s.aspx', q_name + '_s', "500px", "250px", q_getMsg("popSeek"));
        }

        function bbsAssign() {  /// 表身運算式
        	for(var j = 0; j < q_bbsCount; j++) {
           		if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           			$('#txtTotal1_'+j).change(function() {sum();});
           			$('#txtTotal2_'+j).change(function() {sum();});
           			$('#txtTotal3_'+j).change(function() {sum();});
           			$('#txtTotal4_'+j).change(function() {sum();});
           			$('#txtTotal5_'+j).change(function() {sum();});
           			$('#txtTotal6_'+j).change(function() {sum();});
           			$('#txtTax_'+j).change(function() {sum();});
           			$('#txtTaxrate_'+j).change(function() {sum();});
           			
           			$('#txtFirstmoney_'+j).change(function() {
           				t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						q_tr('txtSecondmoney_'+b_seq,q_float('txtTotal8_'+b_seq)-q_float('txtFirstmoney_'+b_seq));
           			});
           			$('#txtSecondmoney_'+j).change(function() {
           				t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
           				q_tr('txtFirstmoney_'+b_seq,q_float('txtTotal8_'+b_seq)-q_float('txtSecondmoney_'+b_seq));
           			});
           			
           			$('#checkSel_' + j).click(function () {
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if($('#checkSel_' +b_seq)[0].checked){	//判斷是否被選取
							$('#trSel_'+ b_seq).addClass('chksel');//變色
						}else{
							$('#trSel_'+b_seq).removeClass('chksel');//取消變色
						}
					});
        		}
           	}
            _bbsAssign();
            table_change();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtYear').val(q_date().substr(0,6));
            $('#txtDatea').val(q_date());
            $('#txtYear').focus();
            table_change();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtYear').focus();
            table_change();
        }
        function btnPrint() {
			q_box('z_salaward_it.aspx' + "?;;;;" + r_accy, '','95%', '650px', q_getMsg("popPrint"));
        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['sssno']) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
                return;
            }

            q_nowf();
            as['datea'] = abbm2['datea'];
            return true;
        }
 
        function sum() {//只計算每個獎金金額合計(人工調整獎金用)
            var t_total= 0;
            for (var j = 0; j < q_bbsCount; j++) {
            	q_tr('txtMoney_'+j,q_float('txtTotal1_'+j)+q_float('txtTotal2_'+j)+q_float('txtTotal3_'+j)+q_float('txtTotal4_'+j)+q_float('txtTotal5_'+j));
            	q_tr('txtTax_'+j,round(q_div(q_mul(q_float('txtMoney_'+j),q_float('txtTaxrate_'+j)),100),0));
            	q_tr('txtTotal7_'+j,q_float('txtTax_'+j)+q_float('txtTotal6_'+j));
            	q_tr('txtTotal8_'+j,q_float('txtMoney_'+j)-q_float('txtTotal7_'+j));
            	
            	//發放金額
            	q_tr('txtFirstmoney_'+j,q_float('txtTotal8_'+j));
				t_total+=dec($('#txtTotal8_'+j).val());
            }  // j
            q_tr('txtTotal',t_total);
        }
   
        function table_change() {
            scroll("tbbs","box",1);
        }
        
        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
			table_change();
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            if (t_para) 
				$('#btnImport').attr('disabled', 'disabled');
			else 
				$('#btnImport').removeAttr('disabled');
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
        
        var scrollcount=1;
        function scroll(viewid,scrollid,size){
        	if(scrollcount>1)
        	$('#box_'+(scrollcount-1)).remove();
			var scroll = document.getElementById(scrollid);
			var tb2 = document.getElementById(viewid).cloneNode(true);
			var len = tb2.rows.length;
			for(var i=tb2.rows.length;i>size;i--){
		                tb2.deleteRow(size);
			}
			//tb2.rows[0].deleteCell(0);
			tb2.rows[0].cells[0].children[0].id="scrollplus"
			var bak = document.createElement("div");
			bak.id="box_"+scrollcount
			scrollcount++;
			scroll.appendChild(bak);
			bak.appendChild(tb2);
			bak.style.position = "absolute";
			bak.style.backgroundColor = "#fff";
		    bak.style.display = "block";
			bak.style.left = 0;
			bak.style.top = "0px";
			scroll.onscroll = function(){
				bak.style.top = this.scrollTop+"px";
			}
			$('#scrollplus').click(function () {
	            	$('#btnPlus').click();
	       		});
		}
    </script>
    <style type="text/css">
       #dmain {
                overflow: hidden;
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
                width: 97%;
                float: left;
            }
            .txt.c2 {
                width: 25%;
                float: right;
            }
            .txt.c3 {
                width: 73%;
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
                font-size: medium;
            }
            .dbbs {
                width: 100%;
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
        .tbbs tr.chksel { background:#FA0300;} 
        #box{
		height:500px;
		width: 100%;
		overflow-y:auto;
		position:relative;
		}
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;">
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewNoa'></a></td>
                <td align="center" style="width:25%"><a id='vewYear'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='year'>~year</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
			<td class="td3"><span> </span><a id="lblDatea" class="lbl"></a></td>
            <td class="td4"><input id="txtDatea" type="text" class="txt c1"/></td> 
        </tr>
        <tr>
        	<td class="td1"><span> </span><a id="lblYear" class="lbl"> </a></td>
            <td class="td2"><input id="txtYear" type="text" class="txt c1"/></td>
            <td class="td3"><span> </span><a id="lblTotal" class="lbl"> </a></td>
            <td class="td4"><input id="txtTotal"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
        	<td class='td1'> </td>
        	<td class='td2'><input id="btnImport" type="button" style="width: auto;font-size: medium;"/></td>
            <td class='td3'><span> </span><a id="lblWorker" class="lbl"> </a></td>
            <td class="td4"><input id="txtWorker" type="text" class="txt c1"/></td>
        </tr>
        </table>
        </div>
        </div>
        <div id="box">
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' style="width: 1886px;background:#cad3ff;" >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                <td align="center" style="width:26px;"><a id='vewChks'> </a></td>
                <td align="center" style="width:80px;"><a id='lblSssno_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblNamea_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblPart_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblJob_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal1_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal2_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal3_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal4_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal5_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblMoney_s'> </a></td>
                <td align="center" style="width:50px;"><a id='lblTaxrate_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTax_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal6_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal7_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal8_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblFirstmoney_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblSecondmoney_s'> </a></td>
                <td align="center" style="width:200px;"><a id='lblMemo2_s'> </a></td>
            </tr>
            <tr id="trSel.*">
                <td ><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input id="checkSel.*" type="checkbox"/></td>
                <td ><input  id="txtSssno.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtNamea.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtPart.*" type="text" class="txt c1"/><input  id="txtPartno.*" type="hidden"/></td>
                <td ><input  id="txtJob.*" type="text" class="txt c1"/><input  id="txtJobno.*" type="hidden"/></td>
                <td ><input  id="txtTotal1.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal2.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal3.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal4.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal5.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtMoney.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTaxrate.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTax.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal6.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal7.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal8.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtFirstmoney.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtSecondmoney.*" type="text" class="txt num c1" /></td>
                <td >
                	<input  id="txtMemo2.*" type="text" class="txt c1" />
                	<input  id="txtNoq.*" type="hidden"  />
                </td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
