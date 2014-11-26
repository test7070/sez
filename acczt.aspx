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
        var q_name="acczt";
        var q_readonly = ['txtNoa','txtMoney','txtYear'];
        var bbmNum = [['txtDepl',14,0,1]]; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        
        aPop = new Array(
			['txtNamea', '', 'accz', 'namea,acc1,money,year', 'txtNamea,txtAcc1,txtMoney,txtYear', "accz_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
		);
			
        //ajaxPath = ""; //  execute in Root
        $(document).ready(function () {
            bbmKey = ['noa'];
            q_brwCount();
			q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy + "_" + r_cno );
			$('#txtNoa').focus();
        });

       //////////////////   end Ready
       function main() {
           if (dataErr)   
           {
               dataErr = false;
               return;
           }
            mainForm(0); // 1=Last  0=Top 
        }  ///  end Main()


        function mainPost() { 
        	bbmMask = [['txtMon', r_picm]];
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
            	case 'accz':
            		var as = _q_appendData("accz", "", true);
            		if(as[0]!=undefined){
						$('#txtNamea').val(as[0].namea);
						q_tr('txtMoney',as[0].money);
						//$('#txtMoney').val(as[0].money);
						$('#txtYear').val(as[0].year);
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

            q_box('acczt_s.aspx', q_name + '_s', "500px", "380px", q_getMsg( "popSeek"));
        }

        function btnIns() {
        	//return ;
            _btnIns();
            
            if(window.parent.q_name=='accz'){
				var wParent = window.parent.document;
				$('#txtAcc1').val(wParent.getElementById("txtAcc1").value);
				$('#txtNamea').val(wParent.getElementById("txtNamea").value);
				$('#txtMoney').val(wParent.getElementById("txtMoney").value);
				$('#txtYear').val(wParent.getElementById("txtYear").value);
			}
        }

        function btnModi() {
        	//return;
            if (emp($('#txtNoa').val()))
                return;

            _btnModi();
            $('#txtMon').focus();
        }

        function btnPrint() {
 
        }
        function btnOk() {
                        
            var t_acc1 = trim($('#txtAcc1').val());
            var t_mon = trim($('#txtMon').val());
 			$('#txtMon').val($.trim($('#txtMon').val()));
			if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
				alert(q_getMsg('lblMon')+'錯誤。');
				return;
			}
			var t_noa = t_acc1 + t_mon;
			wrServer(  t_noa);
        }

        function wrServer( key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '','',2);
        }
        
        function refresh(recno) {
            _refresh(recno);
            
            t_where = "where=^^acc1 ='"+$('#txtAcc1').val()+"'^^"
			q_gt('accz', t_where , 0, 0, 0, "", r_accy+'_'+r_cno);
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
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 40%;
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
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewAcc1'></a></td>
                <td align="center" style="width:10%"><a id='vewMon'></a></td>
                <td align="center" style="width:30%"><a id='vewDepl'></a></td>
                <td align="center" style="width:30%"><a id='vewAccno'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='acc1'>~acc1</td>
                   <td align="center" id='mon'>~mon</td>
                   <td align="right" id='depl,0,1'>~depl,0,1</td>
                   <td align="center" id='accno'>~accno</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 73%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
            <tr>
               <td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
               <td class="td3"></td>            
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblNamea' class="lbl"></a></td>
               <td class="td2"><input id="txtNamea"  type="text"  class="txt c1"/></td>
               <td class="td3"></td>            
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblAcc1' class="lbl"></a></td>
               <td class="td2"><input id="txtAcc1"  type="text"  class="txt c1"/></td>
               <td class="td3"></td>            
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
               <td class="td2"><input id="txtMoney"  type="text"  class="txt c1 num"/></td>
               <td class="td3"><span> </span><a id='lblYear' class="lbl"></a></td>
               <td class="td4"><input id="txtYear"  type="text"  class="txt c1 num"/></td>    
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblMon' class="lbl"></a></td>
               <td class="td2"><input id="txtMon"  type="text"  class="txt c1"/></td>
               <td class="td3"></td>              
            </tr>
           <tr>
               <td class="td1"><span> </span><a id="lblDepl" class="lbl"></a></td>
               <td class="td2"><input id="txtDepl"  type="text" class="txt num c1" /></td>
               <td class="td3"></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id="lblAccno" class="lbl"></a></td>
               <td class="td2"><input id="txtAccno" type="text" class="txt c1" /></td>
               <td class="td3"></td>
            </tr>                                             
        </table>
        </div>
        </div>
         <input id="q_sys" type="hidden" />    
</body>
</html>
            