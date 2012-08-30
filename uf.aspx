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
        var q_name = "uf";
        var q_readonly = ['txtAccno'];
        var q_readonlys = [];
        var bbmNum = [['txtMoney',12 , , 1]];  
        var bbsNum = [['txtMoney',12 , , 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtBankno_', 'btnBankno_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx'],
        							['txtBankno', 'lblBankno', 'bank', 'noa,acc1,account', 'txtBankno,txtAccno,txtAccount', 'bank_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();   
           q_gt(q_name, q_content, q_sqlCount, 1)  
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
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
             q_cmbParse("cmbTypea", q_getPara('uf.typea')); 
             $("#cmbTypea").focus(function(){
            	var len = $("#cmbTypea").children().length>0?$("#cmbTypea").children().length:1;
            	$("#cmbTypea").attr('size',len+"");
            }).blur(function(){
            	$("#cmbTypea").attr('size','1');
            });           

             $('#lblAccno').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
		            //q_gt('sss',  " field=noa,namea,rank where=^^LEFT(noa,1)='A'^^"); 
		        });
		       //........................託收匯入
	        $('#btnGqb').click(function () {
	        	var t_where="";
	        	var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
	        	//判斷不是新增的狀態
	        	if(s1.length>0 && s1!="AUTO"){	
	        		//清除單據內的資料
	        		 for (var j = 0; j < q_bbsCount; j++) {
	        		 	btnMinus('chkSel_'+j);
	        		 }
	        		t_where="where=^^ b.noa ='"+s1+"' or (tbankno!='' and a.datea <='"+$('#txtDatea').val()+"' and (enda!='Y' or enda is null)) ^^";
	        		q_gt('uf_gqb', t_where, 0, 0);
	        	}
	        	else//新增的狀態
	        	{
	        		if(emp($('#txtBankno').val())){
	        			t_where="where=^^ tbankno !='' and datea <='"+$('#txtDatea').val()+"' and (enda!='Y' or enda is null) ^^";
		        	}else{
		        		t_where="where=^^ tbankno='"+$('#txtBankno').val()+"' and datea <='"+$('#txtDatea').val()+"' and (enda!='Y' or enda is null) ^^";
		        	}
		        	q_gt('gqb', t_where, 0, 0);
	        	}
	        	//tbankno把已託收的票據匯入或根據託收銀行將票據匯入
	        	//datea到期日之前的票據匯入
	        	//enda!='Y' or is null表示未兌現 ='Y'表示已兌現
	        });
	        //......................... 
	        
	        
	        
	        
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
            switch (t_name) {
            	case 'uf_gqb':
            		var as = _q_appendData("gqb", "", true);
            		//if(as.length>q_bbsCount)
            		q_gridAddRow(bbsHtm, 'tbbs', 'txtBankno,txtBank,txtCheckno,txtDatea,txtMoney,txtTaccl', as.length, as, 'bankno,bank,noa,indate,money,accl', '');
            		
			        for (var j = 0; j < q_bbsCount; j++) {
			            	$('#ufseq_'+j).text(j+1);//自動產生序號
			            	$('#trSel_'+j).removeClass('chksel');//取消變色
			            	$('#chkSel_'+j).removeAttr("checked");//將單據內的票據取消
			        }  // j

		             sum();
            		break;
            	case 'gqb':
            		var as = _q_appendData("gqb", "", true);
            		//if(as.length>q_bbsCount)
            		q_gridAddRow(bbsHtm, 'tbbs', 'txtBankno,txtBank,txtCheckno,txtDatea,txtMoney,txtTaccl', as.length, as, 'bankno,bank,noa,indate,money,accl', '');
            		//自動產生序號
			        for (var j = 0; j <= q_bbsCount; j++) {
			            	$('#ufseq_'+j).text(j+1);
			        }  // j
		             sum();
            		break;
                case q_name: if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('uf_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   
        }

        function bbsAssign() {  
        	for (var i = 0; i < q_bbsCount; i++) {
        		$('#chkSel_'+i).click(function() {
        			sum();
        		})
                $('#chkSel_' + i).hover(function () {
                    t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
                    $('#trSel_'+b_seq).addClass('sel');
                },
                function () {
                    t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
                    $('#trSel_' + b_seq).removeClass('sel');
				 if($('#chkSel_' +b_seq)[0].checked){	//判斷是否被選取
                	$('#trSel_'+ b_seq).addClass('chksel');//變色
                }else{
                	$('#trSel_'+b_seq).removeClass('chksel');//取消變色
                }
                });
            }//end for
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
            $('#cmbTypea').val(2);
            
           //自動產生序號
			for (var j = 0; j <= q_bbsCount; j++) {
			      $('#ufseq_'+j).text(j+1);
			 }  // j
			 
			 //取消變色
            for (var i = 0; i < q_bbsCount; i++) {
            	$('#trSel_'+i).removeClass('chksel');
            }
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtProduct').focus();
            
           
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['checkno'] ) {  
                as[bbsKey[1]] = '';   
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
            var t1 = 0, t_unit, t_mount, t_weight = 0,money_total=0;
            for (var j = 0; j < q_bbsCount; j++) {
            	if($('#chkSel_' +j)[0].checked)
				money_total+=dec($('#txtMoney_' + j).val());//兌現金額總計
            }  // j
			q_tr('txtMoney',money_total , 2)
        }
        
        function q_stPost() {
            if (q_cur == 1 || q_cur == 2) {
                abbm[q_recno]['noa'] = xmlString;   /// 存檔後， server 傳回 xmlString 
                $('#txtNoa').val(xmlString);   /// 顯示 server 端，產生之傳票號碼
            }
        }

        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
            
           //自動產生序號
			for (var j = 0; j <= q_bbsCount; j++) {
			       $('#ufseq_'+j).text(j+1);
			}  // j
			
			for (var j = 0; j < q_bbsCount; j++) {
			 if($('#chkSel_' + j )[0].checked){	//判斷是否被選取
                	$('#trSel_'+  j ).addClass('chksel');//變色
                }else{
                	$('#trSel_'+ j ).removeClass('chksel');//取消變色
                }
			} 
			
       }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            if (t_para) {
		            $('#btnGqb').attr('disabled', 'disabled');	          
		        }
		        else {
		        	$('#btnGqb').removeAttr('disabled');	 
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
                float: left;
            }
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
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
                width: 95%;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs tr.sel { background:yellow;} 
           .tbbs tr.chksel { background:bisque;} 
            .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width:100%;}
			 .dbbs .tbbs tr{height:35px;}
			 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
            .num {
                text-align: right;
            }
            .bbs{
            	float:left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
    <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
               
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 74%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='td1'><span> </span><a id="lblNoa" class="lbl"></a></td>
            <td class="td2"><input id="txtNoa"  type="text" class="txt c1" /></td>
            <td class='td3'><span> </span><a id="lblType" class="lbl"></a></td>
            <td class="td4" ><select id="cmbTypea" class="txt c1" style="font-size: medium;"></select></td>
            <td class='td5'><span> </span><a id="lblDatea" class="lbl"></a></td>
            <td class="td6"><input id="txtDatea" type="text" class="txt c1"/></td>
            </tr>
        <tr>
        	<td class='td1' ><span> </span><a id="lblBankno" class="lbl btn"></a></td>
            <td class="td2"><input id="txtBankno" type="text" class="txt c2"/><input  id="txtBank"  type="text"  class="txt c3" /></td>            
            <td class='td3'><span> </span><a id="lblAccount" class="lbl" ></a></td>
            <td class="td4"><input id="txtAccount"  type="text" class="txt c1"/></td>
            <td class='td5'><span> </span><a id="lblMoney" class="lbl"></a></td>
            <td class="td6"><input id="txtMoney"  type="text" class="txt num c1" /></td>
            </tr>        
        <tr>
            <td class='td1'><span> </span><a id="lblAccno" class="lbl btn"></a></td>
            <td class="td2"><input id="txtAccno"  type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblWorker" class="lbl"></a></td>
            <td class="td4"><input id="txtWorker"  type="text"  class="txt c1"/></td>
            <td class="td5"><span> </span><input type="button" id="btnGqb" class="txt c1 " value="託收匯入" style="width:80%;"></tr>        
        </table>
        </div>
		</div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                <td align="center" class="td0"><a id='vewChks'></a></td>
                <td align="center" class="td1"></td>
                <td align="center" class="td1"><a id='lblCheckno'></a></td>
                <td align="center" class="td1" style="width:20%"><a id='lblBanknos'></a></td>
                <td align="center" style="width:15%"><a id='lblBank'></a></td>
                <td align="center" class="td1" style="width:10%"><a id='lblDateas'></a></td>
                <td align="center" class="td1"><a id='lblMoneys'></a></td>
                <td align="center" class="td1" style="width:15%"><a id='lblTaccl'></a></td>
            </tr>
            <tr  id="trSel.*" >
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input id="chkSel.*" type="checkbox"/></td>
                <td id="ufseq.*" style="width:1%;"></td ><!--序號欄位-->
                <td ><input class="txt c1" id="txtCheckno.*" type="text" /></td>
                <td ><input id="txtBankno.*" type="text" style="width: 80%;"/></td>
                <td ><input class="txt c1" id="txtBank.*" type="text" /></td>
                <td ><input class="txt c1" id="txtDatea.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtMoney.*" type="text" /></td>
                <td ><input class="txt c1" id="txtTaccl.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
