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
        var q_name = "chk2";
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [['txtMoney',12 , , 1]];  
        var bbsNum = [['txtMoney',12 , , 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtBankno', 'lblBank', 'bank', 'noa,bank,account,acc1', 'txtBankno,txtBank,txtAccount,txtAccl', 'bank_b.aspx']
        								,['txtTcompno_', 'btnTcomp_', 'tgg', 'noa,comp', 'txtTcompno_,txtTcomp_', 'Tgg_b.aspx']);        
		//aPop = new Array(['txtBankno', 'lblBank', 'bank', 'noa,bank', 'txtBankno,txtBank', 'bank_b.aspx'],['txtBank_', 'btnBank_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx']);
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

     /*   aPop = [['txtStoreno', 'btnStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
                ['txtStoreno2', 'btnStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx', "60%", "650px", q_getMsg('popStore')],
                ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']];*/

        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);

			//........................票據匯入
	        $('#btnGqb').click(function () {
	           chk2_gqb();
	        });
	        //.........................

        }

        function chk2_gqb() {
            t_where = "where=^^ (tbankno='' or  tbankno is null) and a.typea='1' and (b.sel = 0 or b.sel is null) ^^";

           /* var j = 0, s1 = '';
            for (var i = 0; i < q_bbsCount; i++) {
                if ($.trim($('#txtCheckno_' + i).val()).length > 0 && $('#txtCheckno_' + i)[0].checked ) {
                    s1 = s1 + (j == 0 ? "" : " or ") + " noa='" + $('#txtCheckno_' + i).val() + "'";
                    j++;
                }
            }//判斷BBS是否有資料且被選取

            t_where1 = t_where1 + (s1.length > 0 ? " or (" + s1 + ")" : '') + "^^";*/
            q_gt('chk2_gqb', t_where , 0, 0, 0, "", r_accy);
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
            	case 'chk2_gqb':
            		var as = _q_appendData("gqb", "", true);
            		//if(as.length>q_bbsCount)
            		q_gridAddRow(bbsHtm, 'tbbs', 'txtCheckno,txtBank,txtBankno,txtAccount,txtDatea,txtMoney,txtTcompno,txtTcomp', as.length, as, 'gqbno,bank,bankno,account,indate,money,tcompno,tcomp', '');
            		for (var i = 0; i < as.length; i++) {
            			$('#txtNoq_' + i).val(i+1);	//自動產生NO
		             }
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
			
			if(emp($('#txtBankno').val())){
             	alert("託收銀行未輸入");
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

            q_box('chk2_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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
            $('#txtMoney').val(0);
            
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
            var t1 = 0, t_unit, t_mount, t_weight = 0,chksum=0;
            for (var j = 0; j < q_bbsCount; j++) {
            	if($('#chkSel_' +j)[0].checked)
					chksum+=dec($('#txtMoney_'+j).val());
            }  // j
            q_tr('txtMoney',chksum , 2)
        }

        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
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
            if (q_tables == 's')
                bbsAssign();  /// 表身運算式 
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
                width: 80%;
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
           
           
           .tbbs tr.sel { background:yellow;} 
           .tbbs tr.chksel { background:bisque;} 
           
             .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width:100%;}
			 .dbbs .tbbs tr{height:35px;}
			 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
        	    
             input[type="text"],input[type="button"] {     
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
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='td1'><span> </span><a id="lblDatea" class="lbl"></a></td>
            <td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblNoa" class="lbl" ></a></td>
            <td class="td4"><input id="txtNoa"type="text" class="txt c1"/></td> </tr>
        <tr>            
            <td class='td1'><span> </span><a id="lblBank" class="lbl btn" ></a></td>
            <td class="td2"><input id="txtBankno" type="text"  class="txt c2"/><input  id="txtBank"  type="text"  class="txt c3"/></td>
            <td class='td3'><span> </span><a id="lblAccount" class="lbl" ></a></td>
            <td class="td4"><input id="txtAccount" type="text" class="txt c1" /></td></tr>        
        <tr>            
            <td class='td1'><span> </span><a id="lblMoney" class="lbl"></a></td>
            <td class="td2"><input id="txtMoney"  type="text" class="txt num c1" /></td>
            <td class='td3'><span> </span><a id="lblAccl"  class="lbl"></a></td>
            <td class="td4"><input id="txtAccl"  type="text" class="txt num c1" /></td></tr>        
        <tr>
            <td class='td1'><span> </span><a id="lblWorker" class="lbl" ></a></td>
            <td class="td2"><input id="txtWorker"  type="text" class="txt c1" /></td>
            <td class='td3'><input type="button" id="btnGqb" class="txt c1 " value="票據匯入"></td></tr> 
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" class="td0"><a id='vewChks'></a></td>
                <td align="center" style="width:5%"><a id='lblNoas'></a></td>
                <td align="center" class="td2"><a id='lblCheckno'></a></td>
                <td align="center" style="width:20%"><a id='lblBanks'></a></td>
                <td align="center" class="td3"><a id='lblBankno'></a></td>
                <td align="center" class="td2"><a id='lblAccounts'></a></td>
                <td align="center" class="td3"><a id='lblDateas'></a></td>
                <td align="center" class="td3"><a id='lblMoneys'></a></td>
                <td align="center" class="td3"><a id='lblTcomps'></a></td>
            </tr>
            <tr id="trSel.*">
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input id="chkSel.*" type="checkbox"/></td>
                <td ><input class="txt c1" id="txtNoq.*" type="text" /></td>
                <td ><input class="txt c1" id="txtCheckno.*" type="text" /></td>
                <td ><input id="txtBank.*" type="text" style="width: 100%;"/></td><!--<input id="btnBank.*" type="button" value="..." style="width: 16%;"/>-->
                <td ><input class="txt c1" id="txtBankno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtAccount.*" type="text" /></td>
                <td ><input class="txt c1" id="txtDatea.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtMoney.*" type="text" /></td>
                <td ><input id="btnTcomp.*" type="button" value="." style="float:left;width: 1%;"/><input id="txtTcompno.*" type="text" style="width: 30%;float: left;"/><input id="txtTcomp.*" type="text" style="width: 60%;float: left;"/></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
