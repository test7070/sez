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
        var q_name = "labase";
        var q_readonly = [];
        var q_readonlys = [];
        var bbmNum = [['txtBo_admin',15,0,1],['txtBo_traffic',15,0,1],['txtBo_full',15,0,1],['txtBo_special',15,0,1],['txtBo_oth',15,0,1],['txtMoney',15,0,1],['txtDiff',15,0,1]];  
        var bbsNum = [['txtMoney',15,0,1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        

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
            bbmMask = [['txtNoa', r_picd]];
            q_mask(bbmMask);
            
            
        }

        function q_boxClose(s2) { 
            var ret;
            switch (b_pop) {   
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  /// ???U??? ...
            switch (t_name) {
                case q_name: 
                	if (q_cur == 1){
                		var as = _q_appendData("salrank", "", true);
                		if(as[0]!=undefined){
                			alert('????????J!!');
                			$('#txtNoa').val('');
                			$('#txtNoa').focus();
                		}
                	}
                	if (q_cur == 4)   // ?d??
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // ??d??? 
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

        function bbsAssign() {  /// ???B??
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

        function bbsSave(as) {   /// ?? ?g?J???w?e?A?g?J??n???
            if (!as['class']) {  //???s????
                as[bbsKey[1]] = '';   /// no2 ????A???s??
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
        ///////////////////////////////////////////////////  ?H?U??????{???A????n????
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
<body ondragstart="return false" draggable="false"
        ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"  
        ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"  
        ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
     >
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewNoa'></a></td>
                <td align="center" style="width:20%"><a id='vewNamea'></a></td>
                
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='namea'>~namea</td>
                  
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
            <td class='td1'><span> </span><a id="lblNoa" class="lbl" > </a></td>
            <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblNamea" class="lbl" > </a></td>
            <td class="td4"><input id="txtNamea" type="text" class="txt c1" /></td> 
            <td class='td5'><input id="chkForeigns" type="checkbox" style=' '/><span> </span><a id="lblForeign"> </a></td>
            <td class="td6"> </td> 
            <td class="td7"> </td>
        </tr>
        <tr class="tr2">
            <td class='td1'><span> </span><a id="lblTypea" class="lbl" > </a></td>
            <td class="td2"><input id="txtTypea" type="text" class="txt  c1" /></td>
            <td class='td3'><span> </span><a id="lblDatea" class="lbl"> </a></td>
            <td class="td4"><input id="txtDatea" type="text" class="txt  c1" /></td>
            <td class='td5'><span> </span><a id="lblSalary" class="lbl"> </a></td>
            <td class="td6"><input id="txtSalary" type="text" class="txt num c1" /></td>
        </tr>
        <tr class="tr3">
            <td class='td1'><span> </span><a id="lblSa_retire" class="lbl" > </a></td>
            <td class="td2"><input id="txtSa_retire" type="text" class="txt num c1" /></td>
            <td class='td3'><span> </span><a id="lblRe_comp" class="lbl"> </a></td>
            <td class="td4"><input id="txtRe_comp" type="text" class="txt num c1" /></td>
            <td class='td5'><span> </span><a id="lblRe_person" class="lbl"> </a></td>
            <td class="td6"><input id="txtRe_person" type="text" class="txt num c1" /></td>
        </tr>
        <tr class="tr4">
            <td class='td1'><span> </span><a id="lblSa_labor" class="lbl" > </a></td>
            <td class="td2"><input id="txtSa_labor" type="text" class="txt num c1" /></td>
            <td class='td3'><span> </span><a id="lblAs_labor" class="lbl"> </a></td>
            <td class="td4"><input id="txtAs_labor" type="text" class="txt num c1" /></td>
            <td class='td5'><span> </span><a id="lblLa_person" class="lbl"> </a></td>
            <td class="td6"><input id="txtLa_person" type="text" class="txt num c1" /></td>
            <td class='td7'><span> </span><a id="lblLa_comp" class="lbl"> </a></td>
            <td class="td8"><input id="txtLa_comp" type="text" class="txt num c1" /></td>
        </tr>
        <tr class="tr5">
            <td class='td1'><span> </span><a id="lblSa_health" class="lbl" > </a></td>
            <td class="td2"><input id="txtSa_health" type="text" class="txt num c1" /></td>
            <td class='td3'><span> </span><a id="lblAs_health" class="lbl"> </a></td>
            <td class="td4"><input id="txtAs_health" type="text" class="txt num c1" /></td>
            <td class='td5'><span> </span><a id="lblHe_person" class="lbl"> </a></td>
            <td class="td6"><input id="txtHe_person" type="text" class="txt num c1" /></td>
            <td class='td7'><span> </span><a id="lblHe_comp" class="lbl"> </a></td>
            <td class="td8"><input id="txtHe_comp" type="text" class="txt num c1" /></td>
        </tr>                               
        <tr class="tr6">
            <td class='td1'><span> </span><a id="lblTax" class="lbl" > </a></td>
            <td class="td2"><input id="txtTax" type="text" class="txt num c1" /></td>
            <td class='td3'><span> </span><a id="lblMount" class="lbl"> </a></td>
            <td class="td4"><input id="txtMount" type="text" class="txt num c1" /></td>
            <td class='td5'> </td>
            <td class="td6"> </td>
            <td class='td7'><span> </span><a id="lblWorker" class="lbl"> </a></td>
            <td class="td8"><input id="txtWorker" type="text" class="txt c1" /></td>
        </tr>                                                           
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblPrefix_s'> </a></td>
                <td align="center"><a id='lblNamea_s'> </a></td>
                <td align="center"><a id='lblBirthday_s'> </a></td>
                <td align="center"><a id='lblId_s'> </a></td>
                <td align="center"><a id='lblCh_money_s'> </a></td>
                <td align="center"><a id='lblAs_health_s'> </a></td>
                <td align="center"><a id='lblIndate_s'> </a></td>
                <td align="center"><a id='lblOutdate_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtPrefix.*"type="text" /></td>
                <td ><input class="txt c1" id="txtNamea.*"type="text" /></td>
                <td ><input class="txt c1" id="txtBirthday.*"type="text" /></td>
                <td ><input class="txt c1" id="txtId.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtCh_money.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtAs_health.*"type="text" /></td>
                <td ><input class="txt c1" id="txtIdate.*"type="text" /></td>
                <td ><input class="txt c1" id="txtOutdate.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
