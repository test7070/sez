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
        var q_name = "chgcashacc";
        var q_readonly = ['txtNoa','txtPlusmoney','txtMinusmoney'];
        var q_readonlys = ['txtChgcashno','txtDatea','combDc','txtMoney','txtChgitemno','txtChgitem','txtAcc1','txtAcc2','txtCustno','txtComp','txtPartno','txtPart','txtMemo'];
        var bbmNum = [['txtPlusmoney', 10, 0, 1],['txtMinusmoney', 10, 0, 1]];  
        var bbsNum = [['txtMoney', 10, 0, 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtPartno', 'lblPartno', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx']);
		
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
            if (r_rank < 7)
		            q_readonly[q_readonly.length] = 'txtAccno';
            
            $("#btnChgcashacc").click(function(e) {
					t_where = "partno='"+$('#txtPartno').val()+"' And (chgaccno='' OR chgaccno is null)";
					q_box("chgcash_acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where , 'chgcash_acc', "95%", "650px", q_getMsg('popChgcash_acc'));
			});
			$('#lblAccno').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "97%", "1054px", q_getMsg('btnAccc'), true);
		     });
			
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 
            var ret;
            switch (b_pop) {   
            	case 'chgcash_acc':
            		b_ret = getb_ret();         ///  q_box() 執行後，選取的資料
            		if (!b_ret || b_ret.length == 0)
                        return;
                    
		            q_gridAddRow(bbsHtm, 'tbbs', 'txtChgcashno,txtDatea,txtDc,txtMoney,txtChgitemno,txtChgitem,txtAcc1,txtAcc2,txtCustno,txtComp,txtPartno,txtPart,txtMemo', b_ret.length, b_ret, 'noa,datea,dc,money,chgitemno,chgitem,acc1,acc2,custno,comp,partno,part,memo', '');
		            for (var j = 0; j < q_bbsCount; j++) {
				        if(!emp($('#txtDc_'+j).val()))
				        	$('#combDc_'+j).val($('#txtDc_'+j).val());
		            }//end for
		            sum(); 
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
            }  /// end switch
        }

        function btnOk() {        	
            $('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
            }
        	
        	
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
        }

        function combPay_chg() {   
        }

        function bbsAssign() {  
            _bbsAssign();
            for (var j = 0; j < q_bbsCount; j++) {
        		q_cmbParse("combDc_"+j, q_getPara('chgcash.typea'));
		       if(!emp($('#txtDc_'+j).val()))
		        	$('#combDc_'+j).val($('#txtDc_'+j).val());
            
            	$('#txtDc_'+j).change(function () {
            		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
                    var i = $('#txtDc_'+b_seq).val();
                    $('#combDc_'+b_seq).val(i);
                    if (i < '0' || i > '4') {
                        $('#txtDc_'+b_seq).val('4');
                        $('#combDc_'+b_seq).val('4');
                    }
            	});
            	$('#combDc_'+j).change(function () {
            		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
                    var i = parseInt($('#combDc_'+b_seq).val(), 0);
                    $('#txtDc_'+b_seq).val(i);
                });
         	}//end for
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
            for (var j = 0; j < q_bbsCount; j++) {
            	$('#combDc_'+j).val('1');
            }
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['chgcashno'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0,money_total=0;
            var plusmoney=0,minusmoney=0;
            for (var j = 0; j < q_bbsCount; j++) {
            	if(!emp($('#txtDc_'+j).val())){
	            	if($('#txtDc_'+j).val()=='1')
	            		minusmoney+=dec($('#txtMoney_'+j).val());
	            	else
	            		plusmoney+=dec($('#txtMoney_'+j).val());
            	}
            }  // j
            q_tr('txtPlusmoney',plusmoney);
            q_tr('txtMinusmoney',minusmoney);
        }
        
        function q_stPost() {
            if (q_cur == 1 || q_cur == 2) {
                //abbm[q_recno]['noa'] = xmlString;   /// 存檔後， server 傳回 xmlString 
                //$('#txtNoa').val(xmlString);   /// 顯示 server 端，產生之傳票號碼
                abbm[q_recno]['accno'] = xmlString;
		        $('#txtAccno').val(xmlString);
            }
        }

        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
            if(q_cur!=1&&q_cur!=2)
            {
            	for (var j = 0; j < q_bbsCount; j++) {
			            $('#combDc_'+j).attr('disabled', 'disabled');
	        			$('#combDc_'+j).css('background', t_background2);
        			}
            }
       }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            if (t_para) {
		            $('#btnChgcashacc').attr('disabled', 'disabled');
		        }
		        else {
		        	$('#btnChgcashacc').removeAttr('disabled');
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
        function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//錯誤
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
            	width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 25%;
                float: left;
            }
            .txt.c3 {
                width: 68%;
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
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:20%"><a id='vewDatea'></a></td>
               
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='datea'>~datea</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 74%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='td1'><span> </span><a id="lblNoa" class="lbl"></a></td>
            <td class="td2"><input id="txtNoa"  type="text" class="txt c1" /></td>
            <td class='td3'><span> </span><a id="lblDatea" class="lbl"></a></td>
            <td class="td4"><input id="txtDatea" type="text" class="txt c1"/></td>
            <td class="td5"></td>
            <td class='td6'></td>
       </tr>
       <tr>
            <td class='td1'><span> </span><a id="lblPartno" class="lbl btn"></a></td>
            <td class="td2" colspan='2'>
            	<input id="txtPartno"  type="text" class="txt c2" />
            	<input id="txtPart" type="text" class="txt c3"/>
            </td>
            <td class="td4"><input type="button" id="btnChgcashacc" class="txt c1"/></td>
            <td class="td5"></td>
            <td class='td6'></td>
       </tr>
        <tr>
        	<td class='td1' ><span> </span><a id="lblPlusmoney" class="lbl"></a></td>
            <td class="td2"><input id="txtPlusmoney" type="text" class="txt num c1"/></td>            
            <td class='td3'><span> </span><a id="lblMinusmoney" class="lbl" ></a></td>
            <td class="td4"><input id="txtMinusmoney"  type="text" class="txt num c1"/></td>
            <td class='td5'><span> </span><a id="lblAccno" class="lbl btn"></a></td>
            <td class="td6"><input id="txtAccno"  type="text" class="txt c1" /></td>
        </tr>
        <tr>
        	<td class='td1' ><span> </span><a id="lblWorker" class="lbl"></a></td>
            <td class="td2"><input id="txtWorker" type="text" class="txt num c1"/></td>        
        	<td class="td3"><span> </span><a id='lblMemo' class="lbl"></a></td>
            <td class="td4" colspan='3' ><input id="txtMemo"  type="text" class="txt c1"/></td> 
        </tr>
        </table>
        </div>
		</div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                <td align="center" style="width:10%"><a id='lblChgcashnos'></a></td>
                <td align="center"style="width:7%"><a id='lblDateas'></a></td>
                <td align="center" style="width:8%"><a id='lblDcs'></a></td>
                <td align="center" style="width:8%"><a id='lblMoneys'></a></td>
                <td align="center" style="width:10%"><a id='lblChgitems'></a></td>
                <td align="center" style="width:10%"><a id='lblAccs'></a></td>
                <td align="center" style="width:15%"><a id='lblCusts'></a></td>
                <td align="center" style="width:8%"><a id='lblParts'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtChgcashno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtDatea.*" type="text" /></td>
                <td ><input class="txt"  id="txtDc.*" type="hidden" /><select id="combDc.*" class="txt c1" style="font-size: medium;"></select></td>
                <td ><input class="txt num c1" id="txtMoney.*" type="text" /></td>
                <td ><input class="txt c2" id="txtChgitemno.*" type="text" /><input class="txt c3" id="txtChgitem.*" type="text" /></td>
                <td ><input class="txt c2" id="txtAcc1.*" type="text" /><input class="txt c3" id="txtAcc2.*" type="text" /></td>
                <td ><input class="txt c2" id="txtCustno.*" type="text" /><input class="txt c3" id="txtComp.*" type="text" /></td>
                <td ><input class="txt c2" id="txtPartno.*" type="text" /><input class="txt c3" id="txtPart.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
