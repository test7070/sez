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
        var q_name = "telfeedc";
        var q_readonly = ['txtNoa','txtDatea','txtTalktotal','txtTotal'];
        var q_readonlys = [];
        var bbmNum = [['txtTotal',14 , 0, 1],['txtComptotal',14 , 0, 1]]; 
        var bbsNum = [['txtTalkfee',12 , 0, 1],['txtTelfee',12 , 0, 1],['txtPhonefee',12 , 0, 1],['txtTotal',12 , 0, 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        //ajaxPath = ""; 
		aPop = new Array(['txtPartno_', 'btnPart_', 'part', 'noa,part', 'txtPartno_,txtPart_', 'part_b.aspx'],
			['txtSssno_', 'btnSss_', 'sss', 'noa,namea', 'txtSssno_,txtNamea_', 'sss_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            brwCount2=2;
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
            bbmMask = [['txtDatea', r_picd],['txtMon', r_picm]];
            q_mask(bbmMask);

            $('#txtComptotal').change(function () {
	           	//分配室內金額
	           	if(dec($('#txtComptotal').val())>0&&dec($('#txtTalktotal').val())>0){
		           	for(var j = 0; j < q_bbsCount; j++) {
		           		if(!emp($('#txtTalkfee_'+j).val()))
		           			q_tr('txtTelfee_'+j,round((q_float('txtTalkfee_'+j)/q_float('txtTalktotal'))*q_float('txtComptotal'),0));
		           			q_tr('txtTotal_'+j,q_float('txtTelfee_'+j)+q_float('txtPhonefee_'+j));
		           	}
		           	sum();
	           	}
	        });
	        $('#btnOld').click(function () {
	        	/*t_where = "where=^^ mon='"+$('#txtMon').val().substr(0,3)+"/"+$('#txtMon').val().substr(0,3)+"') ^^"
	           	q_gt('tel', t_where , 0, 0, 0, "", r_accy);*/
	        });
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
                case q_name: 
                	if (q_cur == 4)  
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

            //$('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('T' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

           	q_box('telfeedc_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
        }

        function combPay_chg() {  
        }
		
		
        function bbsAssign() {
        	for(var j = 0; j < q_bbsCount; j++) {
            	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
					$('#txtTelfee_' + j).change(function () {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						q_tr('txtTotal_'+b_seq,q_float('txtTelfee_'+b_seq)+q_float('txtPhonefee_'+b_seq));
						sum();
				    });
				    $('#txtPhonefee_' + j).change(function () {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						q_tr('txtTotal_'+b_seq,q_float('txtTelfee_'+b_seq)+q_float('txtPhonefee_'+b_seq));
						sum();
				    });
				    $('#txtTalkfee_' + j).change(function () {
						var talk_total=0;
						for (var j = 0; j < q_bbsCount; j++) {//計算調節器加總
	           				if(!emp($('#txtTalkfee_'+j).val()))
	           					talk_total+=dec($('#txtTalkfee_'+j).val());
						}
						q_tr('txtTalktotal',talk_total);
						
						//重新分配室內金額
			           	if(dec($('#txtComptotal').val())>0&&dec($('#txtTalktotal').val())>0){
				           	for(var j = 0; j < q_bbsCount; j++) {
				           		if(!emp($('#txtTalkfee_'+j).val()))
				           			q_tr('txtTelfee_'+j,round((q_float('txtTalkfee_'+j)/q_float('txtTalktotal'))*q_float('txtComptotal'),0));
				           			q_tr('txtTotal_'+j,q_float('txtTelfee_'+j)+q_float('txtPhonefee_'+j));
				           	}
			           	}
			           	sum();
				    });
				}
			}
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtMon').val(q_date().substring(0,6));
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
        }
        var t_mobile=[];//暫存BBS
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            
        }
        function btnPrint() {
			q_box('z_telfeep.aspx', '', "95%", "650px", q_getMsg("popPrint"));
        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {  
            if (!as['namea'] ) { 
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['mon'] = abbm2['mon'];

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
            var t1 = 0, t_unit, t_mount, t_total=0;
            for (var j = 0; j < q_bbsCount; j++) {
				t_total+=dec($('#txtTotal_'+j).val());
            }  // j
			q_tr('txtTotal',t_total);
        }
        
        function refresh(recno) {
            _refresh(recno);

        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            if (t_para) {
		            $('#btnTel').attr('disabled', 'disabled');	          
		        }
		        else {
		        	$('#btnTel').removeAttr('disabled');	 
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
                width: 10%;
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
                width: 35%;
                float: left;
            }
            .txt.c3 {
                width: 63%;
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
                <td align="center" style="width:25%"><a id='vewMon'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='mon'>~mon</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
        		<td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
               	<td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
               	<td class="td3"><span> </span><a id='lblMon' class="lbl"></a></td>
               	<td class="td4"><input id="txtMon"  type="text"  class="txt c1"/></td>
               	<td class="td5"><span> </span><a id='lblDatea' class="lbl"></a></td>
               	<td class="td6"><input id="txtDatea"  type="text"  class="txt c1"/></td>
        </tr>
        <tr class="tr2">
               <td class="td1"><span> </span><a id='lblComptotal' class="lbl"></a></td>
               <td class="td2"><input id="txtComptotal"  type="text"  class="txt num c1"/></td>
               <td class="td3"><span> </span><a id='lblTalktotal' class="lbl"></a></td>
               <td class="td4"><input id="txtTalktotal"  type="text"  class="txt num c1"/></td>
               <td class="td5"><span> </span><a id='lblTotal' class="lbl"></a></td>
               <td class="td6"><input id="txtTotal"  type="text"  class="txt num c1"/></td>
        </tr>
        <tr class="tr2">
               <td class="td1"><input type="button" id="btnOld" class="txt c1 "></td>
        </tr>
        </table>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  style="width:100%;">
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" style="width: 10%;"><a id='lblPart'></a></td>
                <td align="center" style="width: 10%;"><a id='lblSss'></a></td>
                <td align="center" style="width: 8%;"><a id='lblTalkfee'></a></td>
                <td align="center" style="width: 8%;"><a id='lblTelfee'></a></td>
                <td align="center" style="width: 8%;"><a id='lblPhonefee'></a></td>
                <td align="center" style="width: 10%;"><a id='lblTotals'></a></td>
                <td align="center"><a id='lblMemo'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td >
                	<input id="txtPartno.*" type="text" class="txt c5"/>
                	<input class="btn"  id="btnPart.*" type="button" value='.' style=" float: left;font-weight: bold;width:1%;" />
                    <input id="txtPart.*" type="text" class="txt c1"/></td>
				</td>
                <td >
                	<input id="txtSssno.*" type="text" class="txt c5"/>
                	<input class="btn"  id="btnSss.*" type="button" value='.' style=" float: left;font-weight: bold;width:1%;" />
                    <input id="txtNamea.*" type="text" class="txt c1"/></td>
				</td>
                <td ><input class="txt num c1" id="txtTalkfee.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTelfee.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtPhonefee.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTotal.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" />
                		<input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
