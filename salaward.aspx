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
        q_tables = 's';
        var q_name = "salaward";
        var q_readonly = ['txtNoa','txtDatea'];
        var q_readonlys = [];
        var bbmNum = [];  // 允許 key 小數
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Noa';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
		aPop = new Array(['txtSssno_', 'lblSssno', 'sss', 'noa,namea', 'txtSssno_,txtNamea_', 'sss_b.aspx']
				,['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx']);
		q_desc=1;
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  // 計算 合適  brwCount 
            q_gt(q_name, q_content, q_sqlCount, 1)
        });

        //////////////////   end Ready
        function main() {
            if (dataErr)  /// 載入資料錯誤
            {
                dataErr = false;
                return;
            }

            mainForm(1); // 1=最後一筆  0=第一筆
        }
        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd],['txtYear', '999']];
            q_mask(bbmMask);

            $('#btnImport').click(function() {
            	var t_where = "where=^^ a.noa!='Z001' and a.noa!='010132' and a.partno<='09' order by a.partno,e.jobno^^";
            	var t_where1 = "where[1]=^^ datea between '"+$('#txtYear').val()+"/01/01' and '"+$('#txtYear').val()+"/12/31'^^";
            	var t_where2 = "where[2]=^^ year='"+$('#txtYear').val()+"'^^";
            	q_gt('salaward_import', t_where+t_where1+t_where2 , 0, 0, 0, "", r_accy);
            });
                  
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
            var ret;
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  /// 資料下載後 ...
            switch (t_name) {
            	case 'salaward_import':
            		var as = _q_appendData("sss", "", true);
            		for (var i = 0; i < as.length; i++) {
            			//出勤扣分計算=遲到+早退+事假+病假+曠工+婚假+喪假
            			as[i].total2=dec(as[i].late_sc)+dec(as[i].early_sc)+dec(as[i].person_sc)+dec(as[i].sick_sc)+dec(as[i].leave_sc)+dec(as[i].marriage_sc)+dec(as[i].bereavement_sc);
            			//獎懲分數=大功+小功+嘉獎+大過(負)+小過(負)+申誡(負)
            			as[i].total3=dec(as[i].great_sc)+dec(as[i].minor_sc)+dec(as[i].commend_sc)+dec(as[i].majorde_sc)+dec(as[i].peccadillo_sc)+dec(as[i].reprimand_sc);
            			//分數合計=考績分數-出勤扣分+獎懲分數
            			as[i].total4=dec(as[i].total)-dec(as[i].total2)+dec(as[i].total3)
            		}
            			q_gridAddRow(bbsHtm, 'tbbs', 'txtSssno,txtNamea,txtJob,txtIndate,txtTotal1,txtLate,txtLeaveearly,txtPerson,txtSick,txtLeave,txtMarriageleave,txtBereavementleave,txtTotal2,txtGreatmeriy,txtMinormerits,txtCommend,txtMajordemerits,txtPeccadillo,txtReprimand,txtTotal3,txtTotal4,txtMemo,txtSalary,txtBo_admin,txtBo_traffic,txtBo_special'
            			, as.length, as, 
            			'noa,namea,job,indate,total,late,early,person,sick,leave,marriage,bereavement,total2,great,minor,commend,majorde,peccadillo,reprimand,total3,total4,memo,salary,bo_admin,bo_traffic,bo_special', '');
            		break;
                case q_name: 
                	if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('salexam_s.aspx', q_name + '_s', "500px", "250px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
        }

        function bbsAssign() {  /// 表身運算式
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtYear').val(dec(q_date().substr(0,3))-1);
            $('#txtDatea').val(q_date());
            $('#txtYear').focus();
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

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['namea']) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
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
        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
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
                width: 97%;
                float: left;
            }
            .txt.c2 {
                width: 25%;
                float: right;
            }
            .txt.c3 {
                width: 73%;
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
            .dbbs {
                width: 2500px;
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
            font-size: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
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
                <td align="center" style="width:25%"><a id='vewYear'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='year'>~year</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='td1'><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
			<td class='td3'><span> </span><a id="lblDatea" class="lbl"></a></td>
            <td class="td4"><input id="txtDatea" type="text" class="txt c1"/></td> 
        </tr>
        <tr>
        	<td class='td1'><span> </span><a id="lblYear" class="lbl"> </a></td>
            <td class="td2"><input id="txtYear" type="text" class="txt c1"/></td>
            <td class='td3'><input id="btnImport" type="button" style="width: auto;font-size: medium;"/></td>
        </tr>
        <tr>
            <td class='td1'><span> </span><a id="lblTotal" class="lbl"> </a></td>
            <td class="td2"><input id="txtTotal"  type="text" class="txt num c1"/></td>
            <td class='td3'><span> </span><a id="lblWorker" class="lbl"> </a></td>
            <td class="td4"><input id="txtWorker" type="text" class="txt c1"/></td>
        </tr>
        </table>
        </div>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                <td align="center" style="width:80px;"><a id='lblSssno_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblNamea_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblJob_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblIndate_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblTotal1_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblLate_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblLeaveearly_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblPerson_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblSick_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblLeave_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblMarriageleave_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblBereavementleave_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal2_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblLeavewithoutpay_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblGreatmerits_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblMinormerits_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblCommend_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblMajordemerits_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblPeccadillo_s'> </a></td>
                <td align="center" style="width:75px;"><a id='lblReprimand_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal3_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal4_s'> </a></td>
                <td align="center" style="width:200px;"><a id='lblMemo_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblSalary_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblBo_admin_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblBo_traffic_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblBo_special_s'> </a></td>
                <td align="center" style="width:70px;"><a id='lblAwardmon_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal5_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input  id="txtSssno.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtNamea.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtJob.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtIndate.*" type="text" class="txt c1" /></td>
                <td ><input  id="txtTotal1.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtLate.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtLeaveearly.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtPerson.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtSick.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtLeave.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtMarriageleave.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtBereavementleave.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal2.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtLeavewithoutpay.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtGreatmeriy.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtMinormerits.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtCommend.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtMajordemerits.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtPeccadillo.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtReprimand.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal3.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal4.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtMemo.*" type="text" class="txt c1" /><input id="txtNoq.*" type="hidden" /></td>
                <td ><input  id="txtSalary.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtBo_admin.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtBo_traffic.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtBo_special.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtAwardmon.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal5.*" type="text" class="txt num c1" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
