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
        var q_name = "labsal";
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [['txtBo_admin',15,0,1],['txtBo_traffic',15,0,1],['txtBo_full',15,0,1],['txtBo_special',15,0,1],['txtBo_oth',15,0,1],['txtMoney',15,0,1],['txtDiff',15,0,1]];  
        var bbsNum = [['txtMoney',15,0,1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        //ajaxPath = ""; // �u�b�ڥؿ����A�~�ݳ]�w

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            
            q_brwCount();  // �p�� �X�A  brwCount 

            q_gt(q_name, q_content, q_sqlCount, 1)  /// q_sqlCount=�̫e�� top=���ơA q_init ����J q_sys.xml �P q_LIST

        });

        //////////////////   end Ready
        function main() {
            if (dataErr)  /// ��J��ƿ�~
            {
                dataErr = false;
                return;
            }

            mainForm(1); // 1=�̫�@��  0=�Ĥ@��
        }  

       
        function mainPost() { // ��J��Ƨ��A�� refresh �e
            q_getFormat();
            bbmMask = [['txtNoa', r_picd]];
            q_mask(bbmMask);
            
            
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 /// �d�ߵ�B�Ȥ��B����  �����ɰ���
            var ret;
            switch (b_pop) {   /// ���n�G���i�H���� return �A�̫�ݰ��� originalClose();
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  /// ��ƤU��� ...
            switch (t_name) {
                case q_name: 
                	if (q_cur == 1){
                		var as = _q_appendData("salrank", "", true);
                		if(as[0]!=undefined){
                			alert('¾�����ƿ�J!!');
                			$('#txtNoa').val('');
                			$('#txtNoa').focus();
                		}
                	}
                	if (q_cur == 4)   // �d��
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // �ˬd�ť� 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('salrank_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function bbsAssign() {  /// �?�B�⦡
            _bbsAssign();
        }

        function btnIns() {
        	var t_noa= dec($('#txtNoa').val());
            _btnIns();
            $('#txtNoa').val(t_noa+1);
            $('#txtNoa').focus();
            $('#txtLevel1').val('1');
            $('#txtLevel2').val('31');
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtNoa').attr('readonly', true);
            $('#txtBo_admin').focus();
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {   /// �? �g�J��Ʈw�e�A�g�J�ݭn���
            if (!as['class']) {  //���s�ɱ��
                as[bbsKey[1]] = '';   /// no2 ���šA���s��
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
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j
        }
        ///////////////////////////////////////////////////  �H�U���Ѩƥ�{���A���ݭn�ɭק�
        function refresh(recno) {
            _refresh(recno);

        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 70%;
                float: right;
            }
            .txt.c3 {
                width: 47%;
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
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
        .tbbs
        {
            FONT-SIZE: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:98% ;  
        }  
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewNoa'></a></td>
                
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                  
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='td1'><span> </span><a id="lblNoa" class="lbl" > </a></td>
            <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblInsur_accident" class="lbl" > </a></td>
            <td class="td4"><input id="txtInsur_accident" type="text" class="txt num c1" /></td> 
            <td class='td5'><span> </span><a id="lblInsur_job" class="lbl" > </a></td>
            <td class="td6"><input id="txtInsur_job" type="text"class="txt num c1" /></td> 
            <td class="td7"> </td>
        </tr>
        <tr>            
            <td class='td1'> </td>
            <td class="td2"> </td>
            <td class='td3'><span> </span><a id="lblInsur_person" class="lbl" > </a></td>
            <td class="td4"><input id="txtInsur_person" type="text" class="txt num c1" /></td>
            <td class='td5'><span> </span><a id="lblInsur_comp" class="lbl"> </a></td>
            <td class="td6"><input id="txtInsur_comp" type="text" class="txt num c1" /></td>
        </tr>              
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblClass_s'> </a></td>
                <td align="center"><a id='lblSalary1_s'> </a></td>
                <td align="center"><a id='lblSalary2_s'> </a></td>
                <td align="center"><a id='lblLmoney_s'> </a></td>
                <td align="center"><a id='lblLself_s'> </a></td>
                <td align="center"><a id='lblLcomp_s'> </a></td>
                <td align="center"><a id='lblFlself_s'> </a></td>
                <td align="center"><a id='lblFlcomp_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtClass.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtSalary1.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtSalary2.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtLmoney.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtLself.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtLcomp.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtFlself.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtFlcomp.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
