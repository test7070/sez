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
        var q_name="ucam";
        var q_readonly = ['txtNoa'];
        var bbmNum = []; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root
		
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
           q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy) 
            $('#txtMarkno').focus();
            
            //不用新增、查詢、列印、翻頁
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
            q_mask(bbmMask);
        }

        function q_boxClose( s2) {
            var ret; 
            switch (b_pop) { 
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'check_btnOk':
                		var as = _q_appendData("ucam", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].markno);
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
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
        }
        function btnIns() {
            _btnIns();
            refreshBbm();
            $('#txtMarkno').focus();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            refreshBbm();
            $('#txtDaeta').focus();
        }

        function btnPrint() {
 
        }
        function btnOk() {
        	 if (emp($('#txtMarkno').val())){
        	 	alert('請輸入'+q_getMsg('lblMarkno')+'!!');
        	 	return;
        	}
        	if(q_cur==1)
				$('#txtWorker').val(r_name);
			else
				$('#txtWorker2').val(r_name);
				
			$('#txtMain').val($('#txtMain').val().replace(/ /g,'　'))
			$('#txtSide').val($('#txtSide').val().replace(/ /g,'　'))
			
			if(q_cur==1){
				var t_key = q_getHref();
                if(t_key[1] != undefined)
                	$('#txtCustno').val(t_key[1]);
                	$('#txtNoa').val(t_key[1]+'-'+$('#txtMarkno').val());
				t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                q_gt('ucam', t_where, 0, 0, 0, "check_btnOk", r_accy);
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
            _btnOk(key_value, bbmKey[0], bbmKey[1],'',2);
        }
       
        function refresh(recno) {
            _refresh(recno);
            $('#txtMain').val(replaceAll($('#txtMain').val(),'chr(10)','\n'));
            $('#txtSide').val(replaceAll($('#txtSide').val(),'chr(10)','\n')) ;
            $('#txtMain').val($('#txtMain').val().replace(/　/g,' '));
            $('#txtSide').val($('#txtSide').val().replace(/　/g,' '));
            refreshBbm();
        }
		
        function readonly(t_para, empty) {
            _readonly(t_para, empty);
        }
        
		function refreshBbm(){
			if(q_cur==1){
            	$('#txtMarkno').css('color','black').css('background','white').removeAttr('readonly');
            }else{
            	$('#txtMarkno').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            }
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
                width: 300px;
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
                width: 800px;
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
                width: 800px;
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
                <td align="center" style="width:30%"><a id='vewMarkno'></a></td>
                <td align="center" style="width:65%"><a id='vewNamea'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='markno'>~markno</td>
                   <td align="center" id='namea'>~namea</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
		  <tr class="tr1">
               <td class="td1" ><span> </span><a id="lblMarkno" class="lbl"> </a></td>
               <td class="td2">
               		<input id="txtMarkno" type="text" class="txt c1"/>
               		<input id="txtNoa" type="hidden" class="txt c1"/><input id="txtCustno" type="hidden" class="txt c1"/>
               </td>
               <td class="td3"> </td>
               <td class="td4"><span> </span><a id="lblNamea" class="lbl"> </a></td>
               <td class="td5" colspan="2">
               		<input id="txtNamea" type="text" class="txt c1"/>
               </td> 
            </tr>
          	<tr class="tr2">
               <td class="td1"><span> </span><a id="lblMain" class="lbl"> </a></td>
               <td class="td2" colspan="2">
					<textarea id="txtMain"  rows='5' cols='50' style="width:300px; height: 250px;"> </textarea>
				</td>
               <td class="td4"><span> </span><a id="lblSide" class="lbl"> </a></td>
               <td class="td5">
               		<textarea id="txtSide"  rows='15' cols='50' style="width:300px; height: 250px;"> </textarea>
               </td> 
            </tr>
            <tr class="tr2">
               <td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
               <td class="td2" colspan="5"><input id="txtMemo" type="text" class="txt c1"/></td>
            </tr>
        </table>
        </div>
        </div> 
        <input id="q_sys" type="hidden" />
</body>
</html>
