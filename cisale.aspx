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
        var q_name="cisale";
        var q_readonly = [];
        var bbmNum = []; 
        var bbmMask = [["txtIndate", "999/99/99"], ["txtOutdate", "999/99/99"], ["txtBirthday", "999/99/99"]]; 
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
        aPop = new Array();
        $(document).ready(function () {
            bbmKey = ['noa'];
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
			q_getFormat();
        	bbmMask = [['txtIndate', r_picd], ['txtOutdate', r_picd], ['txtBirthday', r_picd]];
            q_mask(bbmMask);
            q_cmbParse("cmbSex", ('').concat(new Array('','男','女')));
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
                 	if (q_cur == 4)  
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
        q_box('cisale_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
        }

        function btnIns() {
            _btnIns();
            $('#txtNoa').focus();
            $('#txtDatea').val(q_date());
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtDatea').focus();
        }

        function btnPrint() {
        }
        function btnOk() {
            var t_noa = trim($('#txtNoa').val());
            if ( t_noa.length==0 )  
                q_gtnoa(q_name, t_noa);
            else
                wrServer( t_noa);
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
                width: 38%;
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
                width: 60%;
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
                font-size:medium;
                padding: 0px;
                margin: -1px;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
    </style>
</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewNamea'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='namea'>~namea</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 73%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
            <tr>
               <td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
               <td class="td2"><input id="txtNoa" type="text" class="txt c1"/> </td>
               <td class="td3"><span> </span><a id='lblNamea' class="lbl"> </a></td>
               <td class="td4"><input id="txtNamea" type="text" class="txt c1"/></td>
               <td class="td5"><span> </span><a id='lblSex' class="lbl"> </a></td>
               <td class="td6"><select id="cmbSex" class="txt c1"> </select></td>              
            </tr>
           <tr>
               <td class="td1"><span> </span><a id='lblId' class="lbl"> </a></td>
               <td class="td2"> <input id="txtId" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id='lblBirthday' class="lbl"> </a></td>
               <td class="td4"> <input id="txtBirthday" type="text" class="txt c1"/></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblIndate' class="lbl"></a></td>
               <td class="td2"><input id="txtIndate"  type="text" class="txt c1" /></td>
               <td class="td3"><span> </span><a id='lblOutdate' class="lbl"></a></td>
               <td class="td4"><input id="txtOutdate"  type="text" class="txt c1" /></td>
               <td class="td5"></td>
               <td class="td6"></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblMobile' class="lbl"> </a></td>
               <td class="td2" colspan="2"> <input id="txtMobile" type="text" class="txt c1"/></td>
               <td class="td3"><span> </span><a id='lblTel' class="lbl"></a></td>
               <td class="td4" colspan="2"><input id="txtTel"  type="text" class="txt c1"/></td>
            </tr>
            <tr>
               <td class="td4"><span> </span><a id='lblEmail' class="lbl"></a></td>
               <td class="td5" colspan="4"><input id="txtEmail"  type="text"  class="txt c1" /></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblAddr' class="lbl"></a></td>
               <td class="td2"colspan="4" ><input id="txtAddr"  type="text" class="txt c1" /></td>
 	       </tr>
            
            <tr>
               <td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
               <td class="td2" colspan="5"><input id="txtMemo"  type="text"  class="txt c1" /></td>
            </tr>     
        </table>
        </div>
        </div>
         <input id="q_sys" type="hidden" />    
</body>
</html>
            