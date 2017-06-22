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
        var q_name="salexrank";
        var q_readonly = ['txtNoa'];
        var bbmNum = [['txtPoint1',10,1],['txtPoint2',10,1]]; 
        var bbmMask = []; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        //ajaxPath = ""; //  execute in Root

        $(document).ready(function () {
            bbmKey = ['noa'];
            brwCount2=10
            q_brwCount();
           q_gt(q_name, q_content, q_sqlCount, 1)
            $('#txtNoa').focus
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
            q_mask(bbmMask);
            
            $('#txtClass').change(function () {
		           	if(!emp($('#txtClass').val())){
		           		var t_where = "where=^^ class ='"+$('#txtClass').val()+"' ^^";
		           		q_gt('salexrank', t_where , 0, 0, 0, "", r_accy);
		           	}
		    });
		    
		    $('#txtPoint1').change(function () {
		           	if(q_float('txtPoint1')>=q_float('txtPoint2')&&q_float('txtPoint2')!=0){
		           		alert('分數區間錯誤!!');
		           		$('#txtPoint1').focus();
		           	}
		    });
		    
		    $('#txtPoint2').change(function () {
		           	if(q_float('txtPoint1')>=q_float('txtPoint2')&&q_float('txtPoint2')!=0){
		           		alert('分數區間錯誤!!');
		           		$('#txtPoint2').focus();
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


        function q_gtPost(t_name) {  
            switch (t_name) {
                case q_name: 
                	if (q_cur == 1 || q_cur == 2) {
                		var as = _q_appendData("salexrank", "", true);
                		if(as[0]!=undefined)
                		{
                			alert('等級重複輸入!!');
                			$('#txtClass').val('');
                		}
                	}
                	
                	if (q_cur == 4)  
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('salexrank_s.aspx', q_name + '_s', "500px", "310px", q_getMsg( "popSeek"));
        }

        function btnIns() {
            _btnIns();
            $('#txtPoint1').focus();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;

            _btnModi();
            $('#txtPoint1').focus();
        }

        function btnPrint() {
 
        }
        function btnOk() {
            var t_err = '';

            t_err = q_chkEmpField([['txtClass', q_getMsg('lblClass')]]);

            if( t_err.length > 0) {
                alert(t_err);
                return;
            }
            
           	if(q_float('txtPoint1')>=q_float('txtPoint2')&&q_float('txtPoint2')!=0){
		    	alert('分數區間錯誤!!');
		        $('#txtPoint1').focus();
		        return;
		    }
            
            var t_noa = trim($('#txtNoa').val());

            if ( t_noa.length==0 )  
                q_gtnoa(q_name, replaceAll(q_date(), '/', ''));
            else
                wrServer(  t_noa);
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
    </script>
  <style type="text/css">
         #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 28%;
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
                width: 70%;
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
                width: 90%;
                float: left;
            }
            .txt.c2 {
                width: 70%;
                float: right;
            }
            .txt.c3 {
                width: 50%;
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
                width: 25%;
                
            }
            .txt.c7 {
                width: 95%;
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
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewClass'></a></td>
                <td align="center" style="width:40%"><a id='vewPoint1'></a></td>
                <td align="center" style="width:40%"><a id='vewPoint2'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                   <td align="center" id='class'>~class</td>
                   <td align="center" id='point1'>~point1</td>
                   <td align="center" id='point2'>~point2</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 73%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
            <tr>
               <td class="td1" ><input id="txtNoa"  type="hidden" class="txt c1" /></td>
               <td class="td2"><a id="lblPoint1"></a></td>
               <td class="td3" ></td>
               <td class="td4"><a id="lblClass"></a></td>
               <td class="td5" ></td>
               <td class="td6"><a id="lblPoint2"></a></td>
            </tr>
            <tr>
               <td class="td1" ></td>
               <td class="td2"><input id="txtPoint1"  type="text"  class="txt num c1" /></td>
               <td class="td3"><a id="lblDpoint" style="font-size: 24px;"></a></td>
               <td class="td4"><input id="txtClass" type="text" class="txt c1" /></td>
               <td class="td5" ><a id="lblCpoint" style="font-size: 20px;"></a></td>
               <td class="td6"><input id="txtPoint2"  type="text" class="txt num c1" /></td>
            </tr>
            <tr>
               <td class="td1" ><span> </span><a id="lblAwardmon" style="float: right;"></a></td>
               <td class="td2"><input id="txtAwardmon"  type="text"  class="txt num c1" /></td>
            </tr>
        </table>
        </div>
        </div>
         <input id="q_sys" type="hidden" />    
</body>
</html>
            