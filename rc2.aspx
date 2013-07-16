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
        var q_name = "rc2";
        var decbbs = [ 'money','total',  'mount', 'price', 'sprice', 'dime', 'width', 'lengthb', 'weight2'];
        var decbbm = ['payed', 'unpay', 'usunpay', 'uspayed', 'ustotal', 'discount', 'money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'tranmoney','totalus'];
        var q_readonly = ['txtNoa','txtWorker']; 
        var q_readonlys= [];
        var bbmNum = [];  // 允許 key 小數
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
		 aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp,tel,zip_invo,addr_invo,paytype', 'txtTggno,txtTgg,txtTel,txtPost,txtAddr,txtPaytype', 'tgg_b.aspx'],
		 ['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx'],
		 ['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
		 ['txtUno_', 'btnUno_', 'uccc', 'noa', 'txtUno_', 'uccc_seek_b.aspx','95%','60%'],
		 ['txtCarno', 'lblCar', 'cardeal', 'noa,comp', 'txtCarno,txtCar', 'cardeal_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

        });

        //////////////////   end Ready
       function main() {
           if (dataErr)  /// 載入資料錯誤
           {
               dataErr = false;
               return;
           }

            mainForm(1); // 1=最後一筆  0=第一筆

        }  ///  end Main()

        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd ],['txtMon', r_picm ]];
            q_mask(bbmMask);
            q_cmbParse("cmbTypea", q_getPara('rc2.typea'));   // 需在 main_form() 後執行，才會載入 系統參數
            q_cmbParse("cmbStype", q_getPara('rc2.stype'));   
            q_cmbParse("cmbCoin", q_getPara('sys.coin'));      /// q_cmbParse 會加入 fbbm
            q_cmbParse("combPaytype", q_getPara('rc2.paytype'));  // comb 未連結資料庫
            q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
            q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));  
            /* 若非本會計年度則無法存檔 */
			$('#txtDatea').focusout(function () {
				if($(this).val().substr( 0,3)!= r_accy){
			        	$('#btnOk').attr('disabled','disabled');
			        	alert(q_getMsg('lblDatea') + '非本會計年度。');
				}else{
			       		$('#btnOk').removeAttr('disabled');
				}
			});
             $('#lblAccc').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('lblAccc'), true);
		        });
			$('#lblOrdc').click(function () {
		            lblOrdc();
		        });
            $('#lblInvono').click(function(){
				t_where = '';
				t_invo = $('#txtInvono').val();
                if(t_invo.length > 0){
                	t_where = "noa='" + t_invo + "'";
                	q_box("invoice.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invo', "95%", "95%", q_getMsg('popInvo'));
                }
            });
            $('#lblLcno').click(function(){
				t_where = '';
				t_lcno = $('#txtLcno').val();
                if(t_lcno.length > 0){
                	t_where = "lcno='" + t_lcno + "'";
                	q_box("lcs.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'lcs', "95%", "95%", q_getMsg('popLcs'));
                }
            });
			$('#txtFloata').change(function () {sum();});
			$('#txtTotal').change(function () {sum();});
        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、廠商視窗、訂單視窗  關閉時執行
            var ret; 
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
                case 'ordcs':
                    if (q_cur > 0 && q_cur < 4) {
                        b_ret = getb_ret();
                        if (!b_ret || b_ret.length == 0)
                            return;
                        var i, j = 0;
                        $('#txtOrdeno').val(b_ret[0].noa);
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtProductno,txtProduct,txtUnit,txtMount,txtOrdeno,txtNo2,txtPrice,txtTotal,txtMemo', b_ret.length, b_ret
                                                           , 'uno,productno,product,unit,mount,noa,no2,price,total,memo'
                                                           , 'txtProductno,txtProduct');   /// 最後 aEmpField 不可以有【數字欄位】
                        bbsAssign();

                       /* for (i = 0; i < ret.length; i++) {
                            k = ret[i];  ///ret[i]  儲存 tbbs 指標
                            if (!b_ret[i]['unit'] || b_ret[i]['unit'].toUpperCase() == 'KG') {
                                $('#txtMount_' + k).val(b_ret[i]['notv']);
                                $('#txtWeight_' + k).val(divide0(b_ret[i]['weight'] * b_ret[i]['notv'], b_ret[i]['mount']));
                            }
                            else {
                                $('#txtWeight_' + k).val(b_ret[i]['notv2']);
                                $('#txtMount_' + k).val(divide0(b_ret[i]['mount'] * b_ret[i]['notv2'], b_ret[i]['weight']));
                            }
                       }  /// for i
                        sum();*/
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
        
        function lblOrdc() {
            var t_tggno = trim($('#txtTggno').val());
            var t_ordeno = trim($('#txtOrdeno').val());
            var t_where='';
            if (t_tggno.length > 0) {
            	if (t_ordeno.length > 0) 
            		t_where = "enda=0 && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "")+"&& " + (t_ordeno.length > 0 ? q_sqlPara("noa", t_ordeno) : "");  ////  sql AND 語法，請用 &&
            	else
                	t_where = "enda=0 && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "");  ////  sql AND 語法，請用 &&
                t_where = t_where;
            }
            else {
                alert(q_getMsg('msgTggEmp'));
                return;
            }
            q_box("ordcs_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+r_accy, 'ordcs', "95%", "95%", q_getMsg('popOrdcs'));
        }
		
		function q_stPost() {
			//t_accno + ";" + t_payed + ";" + (t_total - t_payed);
		        if (!(q_cur == 1 || q_cur == 2))
		            return false;
				var s1 = xmlString.split(';');
		        abbm[q_recno]['accno'] = s1[0];
		        $('#txtAccno').val(s1[0]);
		    }
		
        function btnOk() {
			$('#txtMon').val($.trim($('#txtMon').val()));
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
					alert(q_getMsg('lblMon')+'錯誤。');   
					return;
			} 
            t_err = q_chkEmpField([
	            	['txtNoa', q_getMsg('lblNoa')],
	            	['txtTggno', q_getMsg('lblTgg')],
	            	['txtCno', q_getMsg('lblAcomp')]
            	]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            $('#txtWorker' ).val(  r_name)
            //sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('I' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('rc2_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function cmbPaytype_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
            var cmb = document.getElementById("combPaytype")
            if (!q_cur) 
                cmb.value = '';
            else
                $('#txtPaytype').val(cmb.value);
            cmb.value = '';
        }

        function bbsAssign() {  /// 表身運算式
            _bbsAssign();
            for (var j = 0; j < ( q_bbsCount==0 ? 1 : q_bbsCount); j++) {
                $('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });
                $('#txtUnit_' + j).change(function () { 
                	t_IdSeq = -1;
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					
                	var t_unit = $('#txtUnit_' + b_seq).val();
	                //var t_mount = (!t_unit || emp(t_unit) || trim( t_unit).toLowerCase() != 'kg' ? $('#txtMount_' + b_seq).val() : $('#txtWeight_' +b_seq).val());  // 計價量
	                var t_mount = $('#txtMount_' + b_seq).val();
	               $('#txtTotal_' +b_seq).val(round( $('#txtPrice_' + b_seq).val() * dec( t_mount), 0));
                });
                $('#txtGweight_' + j).change(function () {
                	t_IdSeq = -1;
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					
                	var t_unit = $('#txtUnit_' + b_seq).val();
	                //var t_mount = (!t_unit || emp(t_unit) || trim( t_unit).toLowerCase() != 'kg' ? $('#txtMount_' + b_seq).val() : $('#txtWeight_' +b_seq).val());  // 計價量
	               var t_mount = $('#txtMount_' + b_seq).val();
	               $('#txtTotal_' +b_seq).val(round( $('#txtPrice_' + b_seq).val() * dec( t_mount), 0));
               	});
                $('#txtPrice_' + j).change(function () {
                	t_IdSeq = -1;
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					
                	var t_unit = $('#txtUnit_' + b_seq).val();
	                //var t_mount = (!t_unit || emp(t_unit) || trim( t_unit).toLowerCase() != 'kg' ? $('#txtMount_' + b_seq).val() : $('#txtWeight_' +b_seq).val());  // 計價量
	               var t_mount = $('#txtMount_' + b_seq).val();
	               $('#txtTotal_' +b_seq).val(round( $('#txtPrice_' + b_seq).val() * dec( t_mount), 0));
                });
                $('#txtTotal_' + j).focusout(function () { sum(); });

            } //j
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtCno').val('1');
            $('#txtAcomp').val( r_comp.substr( 0,2));
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
        }

        function btnModi() {
            if( emp( $('#txtNoa').val()))
                return;

            _btnModi();
            $('#txtDatea').focus();
        }


        function btnPrint() {
 			q_box("z_rc2p.aspx?;;;;" + r_accy, '', "95%", "650px", q_getMsg("popPrint"));
        }

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk( key_value, bbmKey[0], bbsKey[1], '', 2);  // key_value
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['productno'] && !as['product'] && !as['spec'] && !dec( as['total'])) {  //不存檔條件
                as[bbsKey[1]] = '';   /// noq 為空，不存檔
                return;
            }

            q_nowf();
            as['type'] = abbm2['type'];
            as['mon'] = abbm2['mon'];
            as['noa'] = abbm2['noa'];
            as['datea'] = abbm2['datea'];
            as['tggno'] = abbm2['tggno'];
            as['kind'] = abbm2['kind'];
            if (abbm2['storeno'])
                as['storeno'] = abbm2['storeno'];

            t_err = '';
            if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
                t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';

            if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
                t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

            if (t_err) {
                alert(t_err)
                return false;
            }
            
            return true;
        }

        function sum() {
           	var t1 = 0, t_unit, t_mount, t_weight = 0;
            var t_float = dec($('#txtFloata').val());
            t_float = (emp(t_float) ? 1 : t_float);
            for (var j = 0; j < q_bbsCount; j++) {
                t1 = t1 + dec($('#txtTotal_' + j).val());
            }
            // j
           var t1 = 0, t_unit, t_mount, t_weight = 0;
                var t_money=0;
                for(var j = 0; j < q_bbsCount; j++) {
                	//q_tr('txtNotv_'+j ,q_float('txtMount_'+j)-q_float('txtC1'+j));
					t_money+=q_float('txtTotal_'+j);
                }  // j
				q_tr('txtMoney' ,t_money);
				q_tr('txtTotal' ,q_float('txtMoney')+q_float('txtTax'));
            if( !emp( $('#txtPrice' ).val()))
                $('#txtTranmoney').val(round(t_weight * dec($('#txtPrice').val()), 0));

            //$('#txtWeight').val(round(t_weight, 0));
            calTax();
			q_tr('txtTotalus' ,q_float('txtTotal')*q_float('txtFloata'));
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
                width: 15%;
                float: left;
            }
            .txt.c5 {
                width: 85%;
                float: left;
            }
            .txt.c6 {
                width: 100%;
                float: left;
            }
            .txt.c7 {
            	float:left;
                width: 22%;
                
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
         .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width: 100%;}
		 .dbbs .tbbs tr{height:35px;}
		 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:5%"><a id='vewTypea'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewTgg'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='typea=rc2.typea'>~typea=rc2.typea</td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='tggno tgg,4'>~tggno ~tgg,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr class="tr1">
               <td class="td1" ><span> </span><a id='lblType' class="lbl"></a></td>
               <td class="td2" >
               		<input id="txtType" type="text"  style='width:0%; visibility:collapse;'/>
               		<select id="cmbTypea" class="txt c3"></select></td>
               <td class="td3" ><span> </span><a id='lblStype' class="lbl"></a></td>
               <td class="td4" ><select id="cmbStype" class="txt c1"></select></td>
               <td class="td5" ><span> </span><a id='lblDatea' class="lbl"></a></td>
               <td class="td6" ><input id="txtDatea" type="text"  class="txt c1"/></td>
               <td class="td7" ><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td8" ><input id="txtNoa" type="text" class="txt c1"/></td> 
            </tr>
            <tr class="tr2">
               <td class="td1"><span> </span><a id='lblAcomp' class="lbl btn"></a></td>
               <td class="td2" ><input id="txtCno"  type="text" class="txt c1"/></td>
               <td class="td3" ><input id="txtAcomp" type="text" class="txt c1"/></td>
               <td class="td4"><span> </span><a id='lblFloata' class="lbl"></a></td>
               <td class="td5" ><select id="cmbCoin" class="txt c1" ></select></td>                 
               <td class="td6" ><input id="txtFloata"   type="text" class="txt num c1" /></td>                 
               <td class="td7"><span> </span><a id='lblInvono' class="lbl btn"></a></td>
               <td class="td8"><input id="txtInvono"  type="text" class="txt c1"/></td> 
            </tr>

           <tr class="tr3">
                <td class="td1"><span> </span><a id='lblTgg' class="lbl btn"></a></td>
                <td class="td2"><input id="txtTggno" type="text" class="txt c1" /></td>
                <td class="td3"><input id="txtTgg"  type="text" class="txt c1"/></td>
                <td class="td4"><span> </span><a id='lblPaytype' class="lbl"></a></td>
                <td class="td5" colspan='2'><input id="txtPaytype" type="text" class="txt c3"/><select id="combPaytype" class="txt c2" onchange='combPaytype_chg()'></select></td> 
                <td class="td7"><span> </span><a id='lblOrdc' class="lbl btn"></a></td>
                <td class="td8"><input id="txtOrdeno"  type="text"  class="txt c1"/></td> 
            </tr>
            <tr class="tr4">
                <td class="td1"><span> </span><a id='lblTel' class="lbl"></a></td>
                <td class="td2" colspan='2' ><input id="txtTel" type="text" class="txt c1"/></td>
                <td class="td4"><span> </span><a id='lblTrantype' class="lbl"></a></td>
                <td class="td5" colspan='2' ><select id="cmbTrantype" class="txt c1"></select></td> 
                <td class="td7" ><span> </span><a id='lblMon' class="lbl"></a></td>
                <td class="td8"><input id="txtMon" type="text"  class="txt c1"/></td> 
            </tr>
            <tr class="tr5">
                <td class="td1"><span> </span><a id='lblAddr' class="lbl"></a></td>
                <td class="td2"><input id="txtPost"  type="text"  class="txt c1"/> </td>
                <td class="td3" colspan='4' ><input id="txtAddr"  type="text" class="txt c1"/></td>
                <td class="td7"><span> </span><a id='lblPrice' class="lbl"></a></td>
                <td class="td8"><input id="txtPrice"  type="text" class="txt num c1" /></td> 
            </tr>
            <tr class="tr6">
                <td class="td1"><span> </span><a id='lblCar' class="lbl btn"></a></td>
                <td class="td2"><input id="txtCarno" type="text"  class="txt c1"/></td>
                <td class="td3"><input id="txtCar"  type="text" class="txt c1"/></td>
                <td class="td4"><span> </span><a id='lblCarno2' class="lbl"></a></td>
                <td class="td5" colspan='2'><input id="txtCarno2"    type="text" class="txt c1"/></td> 
                <td class="td7"><span> </span><a id='lblTranmoney' class="lbl"></a></td>
                <td class="td8"><input id="txtTranmoney" type="text" class="txt num c1" /></td> 
            </tr>
            <tr class="tr7">
                <td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
                <td class="td2"colspan='2'><input id="txtMoney" type="text" class="txt num c1" /></td> 
                <td class="td4" ><span> </span><a id='lblTax' class="lbl"></a></td>
                <td class="td5"><input id="txtTax" type="text" class="txt num c1" /></td>
                <td class="td6"><select id="cmbTaxtype" class="txt c1"></select></td>
                <td class="td7"><span> </span><a id='lblTotal' class="lbl"></a></td>
                <td class="td8"><input id="txtTotal" type="text" class="txt num c1" /></td> 
            </tr>
            <tr class="tr8">
                <td class="td1"><span> </span><a id='lblTotalus' class="lbl"></a></td>
                <td class="td2" colspan='2'><input id="txtTotalus" type="text" class="txt num c1" /></td> 
                <!--<td class="td4"><span> </span><a id='lblWeight' class="lbl"></a></td>
                <td class="td5" colspan='2' ><input id="txtWeight" type="text" class="txt num c1" /></td>-->
                <td class="td7"><span> </span><a id='lblAccc' class="lbl btn"></a></td>
                <td class="td8"><input id="txtAccno" type="text" class="txt c1"/></td> 
            </tr>
            <tr  class="tr9">
                <td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
                <td class="td2" colspan='7' ><input id="txtMemo"  type="text" class="txt c1"/></td> 
            </tr>
            <tr class="tr10">
                <td class="td1"><span> </span><a id='lblLcno' class="lbl btn"></a></td>
                <td class="td2"><input id="txtLcno"  type="text" class="txt c1"/></td> 
                <td class="td3"><span> </span><a id='lblWorker' class="lbl"></a></td>
                <td class="td4"><input id="txtWorker"  type="text" class="txt c1"/></td> 
            </tr>
        </table>
        </div>
        </div>
        <div class='dbbs' >
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
           <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:8%;"><a id='lblProductno'></a></td>
                <td align="center" style="width:12%;"><a id='lblUno'></a></td>
                <td align="center" style="width:4%;"><a id='lblUnit'></a></td>
                <td align="center" style="width:7%;"><a id='lblMount'></a></td>                
                <td align="center" style="width:7%;"><a id='lblPrices'></a></td>
                <td align="center" style="width:9%;"><a id='lblTotals'></a></td>
                <td align="center" style="width:12%;"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td><input class="btn"  id="btnProductno.*" type="button" value='...' style=" font-weight: bold; width: 16%;" />
                	<input  id="txtProductno.*" type="text" style="width: 75%;"/></td>
                                       
                <td>
                	<input class="btn"  id="btnUno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <input type="text" id="txtProduct.*"  style="width:85%; float:left;"/>
                        <span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtUno.*"  style="width:85%; float:left;"/>
					</td>
                <td><input id="txtUnit.*" type="text" class="txt c1"/></td>
                <td><input id="txtMount.*" type="text" class="txt num c1" />
                	<!--<input id="txtWeight.*" type="text" class="txt num c1" />-->
                </td>
                <td><input id="txtPrice.*" type="text"  class="txt num c1" /></td>
                <td><input id="txtTotal.*" type="text" class="txt num c1" />
                                      <input id="txtGweight.*" type="text" class="txt num c1" /></td>
                <td><input id="txtMemo.*" type="text" class="txt c1"/>
                <input id="txtOrdeno.*" type="text" style="width:72%;" />
                <input id="txtNo2.*" type="text" style="width:22%;" />
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
