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
        var q_name = "uca";
        var decbbs = ['weight', 'uweight', 'price'];
        var decbbm = ['weight', 'hours' , 'pretime', 'mount', 'wages', 'makes', 'mechs', 'trans', 'molds', 'packs', 'uweight', 'price'];
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [];  // 允許 key 小數
        var bbsNum = [['txtMount', 12, 3], ['txtWeight', 11, 2], ['txtHours', 9, 2]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
        
        aPop = new Array(
        	['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'],
        	['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
        	['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
        	['txtStationgno', 'lblStationg', 'stationg', 'noa,namea', 'txtStationgno,txtStationg', 'stationg_b.aspx'],
        	['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx'],
        	['txtProcessno_', 'btnProcessno_', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx']
        	);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];

            q_brwCount();  // 計算 合適  brwCount 
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

            mainForm(0); // 1=最後一筆  0=第一筆

            $('#txtNoa').focus();
            
        }  ///  end Main()
        
        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtKdate', r_picd],['txtWdate', r_picd]];  
			q_mask(bbmMask);
			q_cmbParse("cmbTypea", q_getPara('uca.typea')); // 需在 main_form() 後執行，才會載入 系統參數
			q_cmbParse("cmbMtype", q_getPara('uca.mtype'),'s');
			$('#btnUcctd').click(function() {
                    t_where = "noa='" + $('#txtNoa').val() + "'";
                    q_box("ucctd_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucctd', "680px", "650px", q_getMsg('btnUcctd'));
                });  
            $('#btnUcap').click(function() {
                    t_where = "noa='" + $('#txtNoa').val() + "'";
                    q_box("ucap_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucap', "980px", "650px", q_getMsg('btnUcap'));
                });  
        }
        
		var t_td='';
        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
            var ret; 
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
            	case 'td':
            		if(q_cur>0 &&q_cur<3){
	            		ret = getb_ret();
		                if(ret!=null){
		                	for (var i = 0; i < ret.length; i++) {
		                		t_td+=ret[i].noa+'.';
		                	}
		                	if(t_td.length>0){
		                		t_td=t_td.substr(0,t_td.length-1);
		                		$('#txtTd_'+b_seq).val(t_td);
		                		//判斷替代品是否會造成BOM無窮迴圈
		                		q_func('qtxt.query','bom.txt,bom,'+ encodeURI(t_td) + ';' + encodeURI($('#txtNoa').val()));
		                	}
		                }
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
        	t_err = '';
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtProduct', q_getMsg('lblProduct')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('Q' + $('#txtKdate').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('uca_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
        }


        function bbsAssign() {  /// 表身運算式
        	for(var j = 0; j < q_bbsCount; j++) {
           			if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtProductno_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if(emp($('#txtNoa').val())){
								alert('請先輸入【'+q_getMsg('lblNoa')+'】');
								$('#txtNoa').focus();
							}
							
							if(!emp($('#txtProductno_'+b_seq).val())&&!emp($('#txtNoa').val()))
		                    	q_func('qtxt.query','bom.txt,bom,'+ encodeURI($('#txtProductno_'+b_seq).val()) + ';' + encodeURI($('#txtNoa').val()));
                		});
						$('#btnTproductno_'+j).click(function() {
							if(emp($('#txtNoa').val())){
								alert('請先輸入【'+q_getMsg('lblNoa')+'】');
								$('#txtNoa').focus();
								return;
							}
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$('#text_Noq').val(b_seq);
							q_box("ucc_b2.aspx", 'td', "95%", "650px", q_getMsg('popTd'));
                		});
                		$('#txtTd_'+j).focusin(function() {
							if(emp($('#txtNoa').val())){
								alert('請先輸入【'+q_getMsg('lblNoa')+'】');
								$('#txtNoa').focus();
								return;
							}else{
								q_msg( $(this), '輸入格式為：品號.品號.品號........');
							}
                		}).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtTd_'+b_seq).val())){
								if($('#txtTd_'+b_seq).val().indexOf(';')>0||$('#txtTd_'+b_seq).val().indexOf(',')>0){
									$('#txtTd_'+b_seq).val(replaceAll($('#txtTd_'+b_seq).val(), ',', '.'))
									$('#txtTd_'+b_seq).val(replaceAll($('#txtTd_'+b_seq).val(), ';', '.'))
								}
								t_td=$('#txtTd_'+b_seq).val();
		                		//判斷替代品是否會造成BOM無窮迴圈
		                		q_func('qtxt.query','bom.txt,bom,'+ encodeURI(t_td) + ';' + encodeURI($('#txtNoa').val()));
	                		}
                		});
           			}
           		}
            _bbsAssign();
        }
        
        function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query':
                		var as = _q_appendData("tmp0", "", true, true);
                		if (as[0] == undefined) {
                			if(t_td.length>0){
                				alert('替代品會造成BOM錯誤!!請重新填入!!');
                				$('#txtTd_'+b_seq).val('');
                			}else{
                				alert('BOM錯誤!!該品號不能填入!!');
                				$('#btnMinus_'+b_seq).click();
                			}
                		}
                		t_td='';
                	break;
                }
              };

        function btnIns() {
            _btnIns();
            //$('#txtCno').val('1');
            //$('#txtAcomp').val(r_comp.substr(0, 2));
            $('#txtKdate').val(q_date());
            $('#txtKdate').focus();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtMdate').val(q_date());
            $('#txtMdate').focus();
        }
        function btnPrint() {
 			q_box('z_ucap.aspx', '', "95%", "95%", q_getMsg("popPrint"));
        }

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
        	t_err = '';
            if (!as['productno'] && !as['product'] ) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
                return;
            }

            q_nowf();
             as['noa'] = abbm2['noa'];
           if (t_err) {
                alert(t_err)
                return false;
            }
            
            return true;
        }
        function sum() {

        }
		
        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
            //format();
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
                font-size: medium;
            }
            .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
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
    <div class="dview" id="dview" style="float: left;  width:32%;"  >
		<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:25%"><a id='vewProduct'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='product spec'>~product ~spec</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        	<tr class="tr1">
		        <td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
		        <td class="td2"><input id="txtNoa" type="text"  class="txt"/></td>
		        <td class="td3"><span> </span><a id="lblKdate" class="lbl"> </a></td>
		        <td class="td4"><input id="txtKdate" type="text"  class="txt"/></td>
				<td class="td5"><span> </span><a id="lblWdate" class="lbl"> </a></td>
				<td class="td6"><input id="txtWdate" type="text"  class="txt"/></td> 
			</tr>
			<tr class="tr2">
		        <td class="td1"><span> </span><a id="lblType" class="lbl"> </a></td>
		        <td class="td2"><select id="cmbTypea" class="txt c1" style="font-size: medium;"></select></td>
		        <td class="td3"><span> </span><a id="lblProduct" class="lbl"> </a></td>
		        <td class="td4" colspan='2'><input id="txtProduct" type="text"  class="txt c1"/></td>
		        <td class="td5"><input id="btnUcctd" type="button"  /></td>
			</tr>
        	<tr class="tr3">
		        <td class="td1"><span> </span><a id="lblEngprono" class="lbl"> </a></td>
		        <td class="td2"><input id="txtEngprono" type="text"  class="txt"/></td>
		        <td class="td3"><span> </span><a id="lblEngpro" class="lbl"> </a></td>
		        <td class="td4" colspan='3'><input id="txtEngpro" type="text"  class="txt c1"/></td>
			</tr>
			<tr class="tr4">
		        <td class="td1"><span> </span><a id="lblProcess" class="lbl btn"> </a></td>
		        <td class="td2">
		        	<input id="txtProcessno" type="text"  class="txt" style="width: 45%;"/>
		        	<input id="txtProcess" type="text"  class="txt" style="width: 45%;"/>
		        </td>
		        <td class="td3"><span> </span><a id="lblSpec" class="lbl"> </a></td>
		        <td class="td4" colspan='3'><input id="txtSpec" type="text"  class="txt c1"/></td>
			</tr>
			<tr class="tr5">
		        <td class="td1"><span> </span><a id="lblModel" class="lbl"> </a></td>
		        <td class="td2">
		        	<input id="txtModelno" type="text"  class="txt" style="width: 45%;"/>
		        	<input id="txtModel" type="text"  class="txt" style="width: 45%;"/>
		        </td>
		        <td class="td3"><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
		        <td class="td4"><input id="txtTggno" type="text"  class="txt c1"/></td>
		        <td class="td5" colspan='2'><input id="txtComp" type="text"  class="txt c1"/></td>
			</tr>
        	<tr class="tr6">
		        <td class="td1"><span> </span><a id="lblStation" class="lbl btn"> </a></td>
		        <td class="td2">
		        	<input id="txtStationno" type="text"  class="txt" style="width: 45%;"/>
		        	<input id="txtStation" type="text"  class="txt" style="width: 45%;"/>
		        </td>
		        <td class="td1"><span> </span><a id="lblStationg" class="lbl btn" style="font-size: 14px;"> </a></td>
		        <td class="td2">
		        	<input id="txtStationgno" type="text"  class="txt" style="width: 45%;"/>
		        	<input id="txtStationg" type="text"  class="txt" style="width: 45%;"/>
		        </td>
		        <td class="td5"><input id="btnUcap" type="button"  /></td>
			</tr>
			<tr>
		        <td class="td3"><span> </span><a id="lblHours" class="lbl"> </a></td>
		        <td class="td4"><input id="txtHours" type="text"  class="txt num"/></td>
		        <td class="td5"><span> </span><a id="lblPretime" class="lbl"> </a></td>
		        <td class="td6"><input id="txtPretime" type="text"  class="txt num"/></td>
		        <td class="td1"><span> </span><a id="lblBadperc" class="lbl"> </a></td>
		        <td class="td2"><input id="txtBadperc" type="text"  class="txt num"/></td>
			</tr>
			<tr class="tr7">
		        <td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
		        <td class="td2" colspan='5'><input id="txtMemo" type="text"  class="txt c1"/></td>
			</tr>
			<tr class="tr8">
		        <td class="td1"><span> </span><a id="lblMechs" class="lbl" style="font-size: 14px;"> </a></td>
		        <td class="td2"><input id="txtMechs" type="text"  class="txt num"/></td>
		        <td class="td3"><span> </span><a id="lblMakes" class="lbl" style="font-size: 14px;"></a></td>
		        <td class="td4"><input id="txtMakes" type="text"  class="txt num"/></td>
				<td class="td5"><span> </span><a id="lblPacks" class="lbl"> </a></td>
				<td class="td6"><input id="txtPacks" type="text"  class="txt num"/></td> 
			</tr>
			<tr class="tr9">
		        <td class="td1"><span> </span><a id="lblMolds" class="lbl" style="font-size: 14px;"> </a></td>
		        <td class="td2"><input id="txtMolds" type="text"  class="txt num"/></td>
		        <td class="td3"><span> </span><a id="lblWages" class="lbl" style="font-size: 14px;"> </a></td>
		        <td class="td4"><input id="txtWages" type="text"  class="txt num"/></td>
				<td class="td5"><span> </span><a id="lblTrans" class="lbl"> </a></td>
				<td class="td6"><input id="txtTrans" type="text"  class="txt num"/></td> 
			</tr>
			<input id="text_Noq" type="hidden" />
        </table>
        </div>
        <div class='dbbs' >
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
           <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                
                <td align="center" style="width:11%;"><a id='lblProductno'></a></td>
                <td align="center" style="width:20%;"><a id='lblProducts'></a></td>
                <td align="center" style="width:4%;"><a id='lblUnit'></a></td>
                <td align="center" style="width:5%;"><a id='lblMount'></a></td>
                <td align="center" style="width:8%;"><a id='lblWeights'></a></td>
                <td align="center" style="width:8%;"><a id='lblMtype_s'></a></td>
                <td align="center" style="width:12%;"><a id='lblProcessno_s'></a></td>
                <td align="center" style="width:6%;"><a id='lblLoss_s'></a></td>
                <!--<td align="center" style="width:15%;"><a id='lblTd'></a></td>-->
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td>	<input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                
                <td>
                	<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;" />
                	<input id="txtProductno.*" type="text" style="width: 75%;"/>
                </td>
                <td>
                	<input id="txtProduct.*" type="text" class="txt c1"/>
                	<input id="txtSpec.*" type="text" class="txt c1"/>
                </td>
                <td><input id="txtUnit.*" type="text" class="txt c1"/></td>
                <td><input id="txtMount.*" type="text" class="txt num c1"/></td>
                <td><input id="txtWeight.*" type="text" class="txt num c1"/></td>
                <td><select id="cmbMtype.*" class="txt c1"> </select></td>
                <td>
                	<input class="btn"  id="btnProcessno.*" type="button" value='.' style=" font-weight: bold;" />
                	<input id="txtProcessno.*" type="text" style="width: 75%;"/>
                	<input id="txtProcess.*" type="text" class="txt c1"/>
                </td>
                <td><input id="txtLoss.*" type="text" class="txt num c1"/></td>
                <!--<td>
                	<input class="btn"  id="btnTproductno.*" type="button" value='.' style=" font-weight: bold;" />
                	<input id="txtTd.*" type="text" style="width: 80%;"/>
                </td>-->
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
