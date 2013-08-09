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
        var q_name="ordei";
        var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
        var bbmNum = [['txtFloata', 6, 2],['txtCommissionpercent', 6, 2]]; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
		
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
           q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy) 
            $('#txtNoa').focus();
            
            //一個訂單只有一個ordei
            $('#dview').hide();
            //不用新增、查詢、列印、翻頁
            $('#btnIns').hide();
            $('#btnSeek').hide();
            $('#btnPrint').hide();
            $('#btnPrevPage').hide();
            $('#btnPrev').hide();
            $('#btnNext').hide();
            $('#btnNextPage').hide();
            $('#q_menu').hide();
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
        	bbmMask = [];
            q_mask(bbmMask);
            //q_cmbParse("cmbTrantype", q_getPara('ordei.trantype'));
			q_cmbParse("cmbCoin", ('').concat(new Array('台幣', '美元', '日幣', '港幣', '人民幣', '歐元', '英鎊', '新加坡幣')));
			
			//讀取嘜頭選項
			 var wParent = window.parent.document;
			 var t_custno= wParent.getElementById("txtCustno").value
			var t_where="where=^^ custno='"+t_custno+"'^^";
            q_gt('ucam', t_where, 0, 0, 0, "", r_accy);
            
            
            $('#cmbMarkno').change(function() {
            	if($('#cmbMarkno').val()==''){
            		$('#txtMain').val('');
            		$('#txtSide').val('');
            		return;
            	}
            	for( i = 0; i < ucam_as.length; i++) {
            		if($('#cmbMarkno').val()==ucam_as[i].noa){
            			$('#txtMain').val(ucam_as[i].main);
            			$('#txtSide').val(ucam_as[i].side);
            			$('#txtMain').val(replaceAll($('#txtMain').val(),'chr(10)','\n'));
			            $('#txtSide').val(replaceAll($('#txtSide').val(),'chr(10)','\n')) ;
			            $('#txtMain').val($('#txtMain').val().replace(/　/g,' '));
			            $('#txtSide').val($('#txtSide').val().replace(/　/g,' '));
            			break;
            		}
            	}
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

		var ucam_as;
        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'ucam':
            		ucam_as = _q_appendData("ucam", "", true);
            		if(ucam_as[0] != undefined){
            			var t_markno='@';
            			for( i = 0; i < ucam_as.length; i++) {
                            t_markno = t_markno + (t_markno.length>0?',':'') + ucam_as[i].noa +'@' + ucam_as[i].namea;
                        }
            			q_cmbParse("cmbMarkno", t_markno);
            			$('#cmbMarkno').val(abbm[0].markno);
            		}
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

            q_box('ordei_s.aspx', q_name + '_s', "500px", "410px", q_getMsg( "popSeek"));
        }
        function btnIns() {
            _btnIns();
            $('#txtLcno').focus();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtLcno').focus();
        }

        function btnPrint() {
 
        }
        function btnOk() {
        	if(q_cur==1)
				$('#txtWorker').val(r_name);
			else
				$('#txtWorker2').val(r_name);
				
			$('#txtMain').val($('#txtMain').val().replace(/ /g,'　'))
			$('#txtSide').val($('#txtSide').val().replace(/ /g,'　'))
			if(q_cur==1){
				var t_key = q_getHref();
                if(t_key[1] != undefined)
                $('#txtNoa').val(t_key[1]);
                wrServer($('#txtNoa').val());
             }else{
             	wrServer($('#txtNoa').val());
             }
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
            
            $('#txtMain').val(replaceAll($('#txtMain').val(),'chr(10)','\n'));
            $('#txtSide').val(replaceAll($('#txtSide').val(),'chr(10)','\n')) ;
            $('#txtMain').val($('#txtMain').val().replace(/　/g,' '));
            $('#txtSide').val($('#txtSide').val().replace(/　/g,' '));
        }
		
        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            if(abbm[0]==undefined && t_para)
				btnIns();
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
    </script>
    <style type="text/css">
         #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 0px;
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
                width: 1100px;
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
                width: 1100px;
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
                width: 99%;
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
                font-size: medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
            .trX{
            	background: #FF88C2;
            }
            .trY{
            	background: #66FF66;
            }
            .trZ{
            	background: #FFAA33;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;" >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewLcno'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id=''>~noa</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='lcno'>~lcno</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
          <tr style="height:1px;">
				<td> <input id="txtNoa" type="hidden" class="txt c1"/></td>
				<td> </td>
				<td> </td>
				<td> </td>
				<td> </td>
				<td> </td>
		  </tr>
          	<tr class="tr2">
               <td class="td1"><span> </span><a id="lblLcno" class="lbl"></a></td>
               <td class="td2" colspan="2"><input id="txtLcno" type="text" class="txt c1"/></td>
               <!--//依訂單
               	<td class="td4"><span> </span><a id="lblTrantype" class="lbl"></a></td>
               <td class="td5"><select id="cmbTrantype" class="txt c1"> </select></td>--> 
            </tr>
            <tr class="tr3">
               <td class="td1"><span> </span><a id="lblBdock" class="lbl"></a></td>
               <td class="td2" colspan="2"><input id="txtBdock" type="text" class="txt c1"/></td>
               <td class="td4"><span> </span><a id="lblEdock" class="lbl"></a></td>
               <td class="td5" colspan="2"><input id="txtEdock" type="text" class="txt c1"/></td>
                
            </tr>
            <tr class="tr4">
               <td class="td1"><span> </span><a id="lblConn" class="lbl"></a></td>
               <td class="td2" colspan="2"><input id="txtConn" type="text" class="txt c1"/></td>
               <td class="td4"><span> </span><a id="lblGoal" class="lbl"></a></td>
               <td class="td5" colspan="2"><input id="txtGoal" type="text" class="txt c1"/></td> 
            </tr>
            <tr class="tr5">
               <td class="td1"><span> </span><a id="lblFactor" class="lbl"></a></td>
               <td class="td2" colspan="2"><input id="txtFactor" type="text" class="txt c1"/></td>
               <td class="td4"><span> </span><a id="lblBcomp" class="lbl"></a></td>
               <td class="td5" colspan="2"><input id="txtBcomp" type="text" class="txt c1"/></td> 
            </tr>
			<tr class="trX">
               <td class="td1"><span> </span><a id="lblInspection_comp" class="lbl"></a></td>
               <td class="td2" colspan="2"><input id="txtInspection_comp" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblTrancomp" class="lbl"></a></td>
               <td class="td4" colspan="2"><input id="txtTrancomp" type="text" class="txt c1"/></td>
            </tr>
            <tr class="trX">
               <td class="td1"><span> </span><a id="lblBank" class="lbl"></a></td>
               <td class="td2" colspan="2"><input id="txtBank" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblTbank" class="lbl"></a></td>
               <td class="td4" colspan="2"><input id="txtTbank" type="text" class="txt c1"/></td>
            </tr>
            <tr class="trX">
               <td class="td1"><span> </span><a id="lblCommissionpercent" class="lbl"></a></td>
               <td class="td2"><input id="txtCommissionpercent" type="text" class="txt num c1"/></td>
               <td>%</td>
               <td class="td3"><span> </span><a id="lblAccount" class="lbl"></a></td>
               <td class="td4" colspan="2"><input id="txtAccount" type="text" class="txt c1"/></td>
            </tr>
            <tr class="trX">
               <td class="td1"><span> </span><a id="lblConsignee" class="lbl"></a></td>
               <td class="td2" colspan="2"><input id="txtConsignee" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblNotify" class="lbl"></a></td>
               <td class="td4" colspan="2"><input id="txtNotify" type="text" class="txt c1"/></td>
            </tr>
            <tr class="trY">
               <td class="td1"><span> </span><a id="lblInvoicememo" class="lbl"></a></td>
               <td class="td2" colspan="5"><input id="txtInvoicememo" type="text" class="txt c1"/></td>
            </tr>
            <tr class="trY">
               <td class="td1"><span> </span><a id="lblPackinglistmemo" class="lbl"></a></td>
               <td class="td2" colspan="5"><input id="txtPackinglistmemo" type="text" class="txt c1"/></td> 
            </tr>
            <tr class="trZ">
               <td class="td1"><span> </span><a id="lblTggno" class="lbl"></a></td>
               <td class="td2" colspan="2"><input id="txtTgg" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblBusinesstype" class="lbl"></a></td>
               <td class="td4" colspan="2"><input id="txtBusinesstype" type="text" class="txt c1"/></td>
            </tr>
            <tr class="trZ">
               <td class="td1"><span> </span><a id="lblCointype" class="lbl"></a></td>
               <td class="td2" ><select id="cmbCoin"  class="txt c1"> </select></td>
               <td class="td3" ><input id="txtFloata" type="text" class="txt num c1"/></td>
               <td class="td4"><span> </span><a id="lblPaymentterms" class="lbl"></a></td>
               <td class="td5" colspan="2"><input id="txtPaymentterms" type="text" class="txt c1"/></td>
            </tr>
             <tr class="tr4">
				<td class="td1"><span> </span><a id="lblMarkno" class="lbl"></a></td>
				<td class="td2"><select id="cmbMarkno" class="txt c1"> </select></td> 
		  	</tr>
            <tr class="tr5">
               <td class="td1"><span> </span><a id="lblMain" class="lbl"> </a></td>
               <td class="td2" colspan="2">
					<textarea id="txtMain"  rows='5' cols='50' style="width:300px; height: 250px;"> </textarea>
				</td>
               <td class="td4"><span> </span><a id="lblSide" class="lbl"> </a></td>
               <td class="td5">
               		<textarea id="txtSide"  rows='15' cols='50' style="width:300px; height: 250px;"> </textarea>
               </td> 
            </tr>
            <tr class="tr6">
               <td class="td1"><span> </span><a id="lblWorker" class="lbl"></a></td>
               <td class="td2"><input id="txtWorker" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id="lblWorker2" class="lbl"></a></td>
               <td class="td4"><input id="txtWorker2" type="text" class="txt c1"/></td>
            </tr>
        </table>
        </div>
        </div> 
        <input id="q_sys" type="hidden" />
</body>
</html>
