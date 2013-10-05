<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title> </title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
	<script src='../script/qj2.js' type="text/javascript"></script>
	<script src='qset.js' type="text/javascript"></script>
	<script src='../script/qj_mess.js' type="text/javascript"></script>
	<script src='../script/mask.js' type="text/javascript"></script>
	<script src="../script/qbox.js" type="text/javascript"></script>
	<link href="../qbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        var q_name="lcv";
        var q_readonly = ['txtAccno','txtNoa','txtWorker','txtLcmoney','txtLcedate','txtUnaccept'];
        var bbmNum = [['txtMoney',10,0,1],['txtLcmoney',10,0,1],['txtUnaccept',10,0,1]]; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';brwCount2 = 11;
        //ajaxPath = ""; //  execute in Root
		aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx']
								,['txtAcc1', 'lblBankacc', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', 'acc_b.aspx']
								,['txtLcno', '', 'lcu', 'lcno,custno,comp,money,edate', 'txtLcno,txtCustno,txtComp,txtLcmoney,txtLcedate', '']
		);
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
           q_gt(q_name, q_content, q_sqlCount, 1);
        });
 
       function main() {
           if (dataErr)   
           {
               dataErr = false;
               return;
           }
            mainForm(0); // 1=Last  0=Top
        }  

        function mainPost() { 
            bbmMask = [['txtDatea', r_picd],['txtRdate', r_picd],['txtLcedate', r_picd]];
        	q_mask(bbmMask);
        	 $('#lblAccc').click(function () {
				q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('btnAccc'), true);
			});
			
			$('#txtLcno').change(function() {
				t_where="where=^^ lcno='"+$('#txtLcno').val()+"'^^";
                q_gt('lcu', t_where, 0, 0, 0, "", r_accy);
			});
			$('#txtMoney').change(function() {
				q_tr('txtUnaccept',t_unaccept-q_float('txtMoney'));
			});
			
			$('#btnZlcu').click(function() {
				q_box("z_lcu.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";", 'lcv', "95%", "95%", q_getMsg('popLcv'));
			});
        }

        function q_boxClose( s2) {
            var ret; 
            switch (b_pop) {                   
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }
		
		var t_lcmoney=0,t_unaccept=0;//lc金額,餘額
        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'lcu':
            		var as = _q_appendData("lcu", "", true);
                    if (as[0] != undefined){
						t_lcmoney=dec(as[0].money);
						t_unaccept=0;
						t_where="where=^^ lcno='"+$('#txtLcno').val()+"' and noa !='"+$('#txtNoa').val()+"' ^^";
                		q_gt('lcv', t_where, 0, 0, 0, "unaccept", r_accy);
                    }else{
                    	t_lcmoney=0;
                    	t_unaccept=0;
                    	q_tr('txtUnaccept',t_unaccept);
                    }
                    q_tr('txtLcmoney',t_lcmoney);
            		break;
            	case 'unaccept':
            		var as = _q_appendData("lcv", "", true);
            		var t_accept=0;//已兌現
                    for(var i=0;i<as.length;i++){
                    	t_accept+=dec(as[i].money);
            		}
            		t_unaccept=t_lcmoney-t_accept
            		q_tr('txtUnaccept',t_unaccept-q_float('txtMoney'));
            		break;
                case q_name: 
                	if (q_cur == 4)  
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('lcv_s.aspx', q_name + '_s', "500px", "330px", q_getMsg( "popSeek"));
        }

        function btnIns() {
            _btnIns();
            $('#txtNoa').val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtLcno').focus();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;

            _btnModi();
            $('#txtLcno').focus();
            //更新餘額
            t_where="where=^^ lcno='"+$('#txtLcno').val()+"'^^";
            q_gt('lcu', t_where, 0, 0, 0, "", r_accy);
        }

        function btnPrint() {
 
        }
        function btnOk() {
            var t_err = '';
            t_err = q_chkEmpField([['txtLcno', q_getMsg('lblLcno')],['txtDatea', q_getMsg('lblDatea')]]);
            
            if( t_err.length > 0) {
                alert(t_err);
                return;
            }
            
          	if(q_float('txtUnaccept')<0){
          		alert(q_getMsg('lblMoney')+'大於匯票餘額!!');
            	return;
          	}
            var t_noa = trim($('#txtNoa').val());
			var t_date = trim($('#txtDatea').val());
			if (t_noa.length == 0 || t_noa == "AUTO")
				q_gtnoa(q_name, replaceAll('LV'+$('#txtDatea').val(), '/', ''));
			else
				wrServer(t_noa);
        }

        function wrServer( key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   /// popSave
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '','',2);
        }
       
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
        
        function q_popPost(s1) {
			switch (s1) {
				case 'txtLcno':
					t_where="where=^^ lcno='"+$('#txtLcno').val()+"'^^";
                	q_gt('lcu', t_where, 0, 0, 0, "", r_accy);
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
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
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
                font-size:medium;
            }
            .tbbm textarea {
            	font-size: medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:38%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:25%"><a id='vewLcno'> </a></td>
                <td align="center" style="width:40%"><a id='vewComp'> </a></td>
                <td align="center" style="width:30%"><a id='vewDatea'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='lcno'>~lcno</td>
                   <td align="center" id='comp,4'>~comp,4</td>
                   <td align="center" id='datea'>~datea</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 60%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
            <tr class="tr1">
               <td class="td1"><span> </span><a id="lblLcno" class="lbl"> </a></td>
               <td class="td2" colspan="2">
               	<input id="txtLcno" type="text" class="txt c1"/>
               	<input id="txtNoa" type="hidden"/>
               </td>
            </tr>  
            <tr class="tr2">
               <td class="td1"><span> </span><a id="lblLcmoney" class="lbl"> </a></td>
               <td class="td2"><input id="txtLcmoney" type="text" class="txt num c1"/></td>
            </tr>
            <tr class="tr3">
               <td class="td1"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
               <td class="td2" colspan="2"><input id="txtCustno" type="text" class="txt c2"/>
               <input id="txtComp" type="text" class="txt c3"/></td>
            </tr>
            <tr class="tr4">
               <td class="td1"><span> </span><a id="lblBankacc" class="lbl btn"> </a></td>
               <td class="td2" colspan="2"><input id="txtAcc1" type="text" class="txt c2"/>
               <input id="txtAcc2" type="text" class="txt c3"/></td> 
            </tr>
            <tr class="tr5">
               <td class="td1"><span> </span><a id="lblDatea" class="lbl "> </a></td>
               <td class="td2"><input id="txtDatea" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr6">
               <td class="td1"><span> </span><a id="lblMoney" class="lbl"> </a></td>
               <td class="td2"><input id="txtMoney" type="text" class="txt num c1"/></td>
            </tr>
            <tr class="tr6">
               <td class="td1"><span> </span><a id="lblUnaccept" class="lbl"> </a></td>
               <td class="td2"><input id="txtUnaccept" type="text" class="txt num c1"/></td>
            </tr>
            <!--<tr class="tr8">
               <td class="td1"><span> </span><a id="lblDate1" class="lbl"></a></td>
               <td class="td2"><input id="txtDate1" type="text" class="txt c1"/></td>
               <td class="td3"></td>
               <td class="td4"></td> 
               <td class="td5"></td> 
            </tr>-->
            <tr class="tr7">
               <td class="td1"><span> </span><a id="lblRdate" class="lbl"> </a></td>
               <td class="td2"><input id="txtRdate" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr8">
               <td class="td1"><span> </span><a id="lblLcedate" class="lbl"> </a></td>
               <td class="td2"><input id="txtLcedate" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr9">
               <td class="td1"><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
               <td class="td2"><input id="txtAccno" type="text" class="txt c1"/></td>              
               <td class="td4"><span> </span><input id="btnZlcu" type="button" /></td>
            </tr>
        </table>
        </div>
        </div> 
        <input id="q_sys" type="hidden" />
	</body>
</html>
