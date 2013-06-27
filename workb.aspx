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
        q_desc=1;
        q_tables = 's';
        var q_name = "workb";
        var decbbs = ['weight', 'mount', 'gmount', 'emount', 'errmount', 'born'];
        var decbbm = ['mount', 'inmount', 'errmount', 'rmount', 'price', 'hours'];
        var q_readonly = ['txtWorker','txtNoa'];
        var q_readonlys = ['txtOrdeno', 'txtNo2', 'txtNoq'];
        var bbmNum = [];  // 允許 key 小數
        var bbsNum = [['txtMount', 15, 0,1], ['txtBorn', 15, 0,1], ['txtBweight', 15, 2,1], ['txtWeight', 15, 2,1], ['txtLengthb', 15, 0,1], ['txtTheory', 15, 2,1]];
        var bbmMask = [];
        var bbsMask = [['txtTimea','99:99']];
        
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = '';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
        
        aPop = new Array(
					['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
					['txtStoreno','lblStore','store','noa,store','txtStoreno,txtStore','store_b.aspx'],
					['txtWorkno','lblWorknos','work','noa','txtWorkno','work_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy],
					['txtMechno', 'lblMechno', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx'],
					['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']
		);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];

            q_brwCount();  // 計算 合適  brwCount 

            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

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
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
            $('#btnImport').click(function(){
            	//20130513改為用inbs匯入
            	//q_box("workas_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";", 'workas', "95%", "95%", q_getMsg('popWorkas'));
            	q_box("inbs_b.aspx?;;;enda=0;" + r_accy, 'inbs', "95%", "95%", q_getMsg("popInbs"));
            });
			$('#btnCert').click(function(){
				t_where = '';
				t_bno = $('#txtBno').val();
				btnCert_Seq = -2
				if(t_bno.length > 0){
					t_where = "left(noa," +t_bno.length + ")='" + t_bno + "'";
					q_box("cert_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'cert', "95%", "95%", q_getMsg('popCert'));
				}
			});
			
			$('#txtWorkno').change(function(){
				var t_where = "where=^^ noa ='"+$('#txtWorkno').val()+"' ^^";
				q_gt('work', t_where , 0, 0, 0, "", r_accy);
			});
			
			$('#lblWorkno').click(function(){
				var t_where="enda!=1 "
				t_where += emp($('#txtWorkno').val())?'':"and charindex ('"+$('#txtWorkno').val()+"',noa)>0 ";
				q_box('work_b.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";"+t_where+";" + r_accy, 'work', "95%", "95%", q_getMsg('popWork'));
			});
        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
            var ret; 
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
            	case 'inbs':
                    if (q_cur > 0 && q_cur < 4) {
                        b_ret = getb_ret();
                        if (!b_ret || b_ret.length == 0)
                            return;
                        var i, j = 0;
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtOrdeno,txtNo2,txtBorn,txtBweight', b_ret.length, b_ret
                                                           , 'productno,product,unit,ordeno,no2,mount,weight'
                                                           , 'txtProductno');   /// 最後 aEmpField 不可以有【數字欄位】
						
                        bbsAssign();
                       }
					break;
                case 'workas':
                    if (q_cur > 0 && q_cur < 4) {
                        b_ret = getb_ret();
                        if (!b_ret || b_ret.length == 0)
                            return;
                        var i, j = 0;
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtBorn,txtBweight', b_ret.length, b_ret
                                                           , 'productno,product,unit,mount,weight'
                                                           , 'txtProductno');   /// 最後 aEmpField 不可以有【數字欄位】
                        bbsAssign();
                       }
					break;            	
                case 'ordes':
                    if (q_cur > 0 && q_cur < 4) {
                        b_ret = getb_ret();
                        if (!b_ret || b_ret.length == 0)
                            return;
                        var i, j = 0;
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2', b_ret.length, b_ret
                                                           , 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2'
                                                           , 'txtProductno,txtProduct,txtSpec');   /// 最後 aEmpField 不可以有【數字欄位】
                        bbsAssign();
                        for (i = 0; i < ret.length; i++) {
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
                    }
                    break;
               	case 'work':
                	b_ret = getb_ret();
                	if(b_ret){
                		$('#txtWorkno').val(b_ret[0].noa);
                		var t_where = "where=^^ noa ='"+$('#txtWorkno').val()+"' ^^";
						q_gt('work', t_where , 0, 0, 0, "", r_accy);
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
            	case 'work':
            		//清空表身資料
            		for(var i = 0; i < q_bbsCount; i++) {
            			$('#btnMinus_'+i).click();
            		}
            		
					var as = _q_appendData("work", "", true);
					for (i = 0; i < as.length; i++) {
							
							if(as[i].unit.toUpperCase()=='KG'){
								as[i].xmount=0;
								as[i].xweight=as[i].mount;
							}else{
								as[i].xmount=as[i].mount;
								as[i].xweight=0;
							}
						}
					q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtWeight,txtBorn,txtBweight,txtOrdeno,txtNo2,txtMemo', as.length, as
														   , 'productno,product,unit,xmount,xweight,xmount,xweight,ordeno,no2,memo'
														   , '');   /// 最後 aEmpField 不可以有【數字欄位】
				 break;
                case 'ucc': 
					var as = _q_appendData("ucc", "", true);
					if(as[0]!=undefined)
						$('#txtTheory_'+b_seq).val(round(dec($('#txtLengthb_'+b_seq).val())*dec(as[0].uweight),2));
					else
						$('#txtTheory_'+b_seq).val(0);
                    break;
                case q_name: 
                	if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
        	t_err = '';
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name);
            
            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            var t_date = $('#txtDatea').val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workb') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('workb_s.aspx', q_name + '_s', "510px", "350px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
        }

        function bbsAssign() {  /// 表身運算式
			for(var i = 0; i < q_bbsCount; i++) {
				if (!$('#btnMinus_' + i).hasClass('isAssign')) {
					$('#txtLengthb_'+i).change(function() {
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			            q_bodyId($(this).attr('id'));
			            b_seq = t_IdSeq;
						
						var t_where = "where=^^ noa='"+$('#txtProductno_'+b_seq).val()+"' ^^";
                		q_gt('ucc', t_where, 0, 0, 0, "", r_accy);
					});
				}
			}
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
			q_box('z_workb.aspx'+ "?;;;noa="+trim($('#txtNoa').val())+";"+r_accy, '', "95%", "95%", m_print);
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
            as['datea'] = abbm2['datea'];
            as['cuano'] = abbm2['cuano'];

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
        
        function q_popPost(s1) {
		    	switch (s1) {
			        case 'txtWorkno':
           				var t_where = "where=^^ noa ='"+$('#txtWorkno').val()+"' ^^";
					    q_gt('work', t_where , 0, 0, 0, "", r_accy);
			        break;
		    	}
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
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 90%;
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
         .dbbs .tbbs{
         	margin:0;
         	padding:2px;
         	border:2px lightgrey double;
         	border-spacing:1px;
         	border-collapse:collapse;
         	font-size:medium;
         	color:blue;
         	background:#cad3ff;
         	width: 100%;
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
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
<!--#include file="../inc/toolbar.inc"-->
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewDatea'></a></td>
                <td align="center" style="width:40%"><a id='vewNoa'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
			<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
			<td><input id="txtDatea" type="text" class="txt c1"/></td>
			<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
			<td><input id="txtNoa" type="text" class="txt c1"/></td>
		</tr>
        <tr>
			<td><span> </span><a id='lblStation' class="lbl btn"> </a></td>
			<td>
				<input id="txtStationno" type="text" class="txt c2"/>
				<input id="txtStation" type="text" class="txt c3"/>
			</td>
			<td><span> </span><a id='lblWorkno' class="lbl btn"> </a></td>
			<td><input id="txtWorkno" type="text" class="txt c1"/></td>
			<td><!--<input type="button" id="btnImport">--></td>

		</tr>
        <tr>
			<td><span> </span><a id='lblStore' class="lbl btn"> </a></td>
			<td>
				<input id="txtStoreno" type="text" class="txt c2"/>
				<input id="txtStore" type="text" class="txt c3"/>
			</td>
			<td><span> </span><a id='lblMechno' class="lbl btn"> </a></td>
			<td>
				<input id="txtMechno" type="text" class="txt c2"/>
				<input id="txtMech" type="text" class="txt c3"/>
			</td>
		</tr>
		 <tr>
			<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
			<td><input id="txtWorker" type="text" class="txt c1"/></td>
			<!--<td><span> </span><a id='lblCuano' class="lbl"> </a></td>
			<td><input id="txtCuano" type="text" class="txt c1"/></td>
			<td><input type="button" id="btnCert"></td>-->
			<!--<td><span> </span><a id='lblBno' class="lbl"> </a></td>
			<td><input id="txtBno" type="text" class="txt c1"/></td>-->
		</tr>
		<tr>
			<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
			<td colspan='3'><input id="txtMemo" type="text" class="txt c1"/></td>
		</tr>
        </table>
        </div>

        <div class='dbbs' >
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:6%;"><a id='lblTimea_st'></a></td>
                <td align="center" style="width:10%;"><a id='lblProductnos'></a></td>
                <td align="center" style="width:13%;"><a id='lblProducts'></a></td>
                <td align="center" style="width:4%;"><a id='lblUnit'></a></td>
                <!--<td align="center" style="width:8%;"><a id='lblLength'></a></td>-->
                <td align="center" style="width:10%;"><a id='lblMounts'></a></td>
                <td align="center" style="width:10%;"><a id='lblTheory'></a></td>
                <td align="center" style="width:10%;"><a id='lblBorn'></a></td>
                <td align="center" style="width:10%;"><a id='lblErrmount'></a></td>
                <td align="center" style="width:12%;"><a id='lblMemos'></a></td>
                <td align="center" style="width:4%;"><a id='lblEnda'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td><input id="txtTimea.*" type="text" class="txt c1"/></td>
                <td>
                	<input class="btn"  id="btnProductno.*" type="button" value='.' style="width:8%;"  />
                	<input id="txtProductno.*" type="text" style="width:76%;"/>
                </td>
                <td><input id="txtProduct.*" type="text" class="txt c1"/></td>
                <td><input id="txtUnit.*" type="text" class="txt c1"/></td>
                <td style="display: none;">
                	<input id="txtLengthb.*" type="text" class="txt c1 num"/>
                </td>
                <td>
                	<input id="txtMount.*" type="text" class="txt c1 num"/>
                	<input id="txtWeight.*" type="text" class="txt c1 num"/>
                </td>
                <td>
                	<input id="txtTheory.*" type="text" class="txt c1 num"/>
                </td>
                <td>
                	<input id="txtBorn.*" type="text" class="txt c1 num"/>
                	<input id="txtBweight.*" type="text" class="txt c1 num"/>
                </td>
                <td><input id="txtErrmount.*" type="text" class="txt c1 num"/></td>
                <td><input id="txtMemo.*" type="text" class="txt c1"/>
                	<input id="txtOrdeno.*" type="text" style="width:70%;"/>
                	<input id="txtNo2.*" type="text" style="width:20%;"/>
                	<input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" />
                </td>
                <td><input id="chkEnda.*" type="checkbox"/></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
