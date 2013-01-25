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
        var bbsNum = [['txtTotal1',4,1,1],['txtLate',4,0,1],['txtLeaveearly',4,0,1],['txtPerson',4,0,1],['txtSick',4,0,1],['txtLeave',4,0,1],['txtMarriageleave',4,0,1],['txtBereavementleave',4,0,1],['txtTotal2',4,1,1],['txtGreatmeriy',2,0,1],['txtMinormerits',2,0,1],['txtCommend',2,0,1],['txtMajordemerits',2,0,1],['txtPeccadillo',2,0,1],['txtReprimand',2,0,1],['txtTotal3',4,1,1],['txtTotal4',10,5,1],['txtSalary',10,0,1],['txtBo_admin',10,0,1],['txtBo_traffic',10,0,1],['txtBo_special',10,0,1],['txtAwardmon_',4,2,1],['txtTotal5',10,0,1],['txtTotal6',10,0,1],['txtTotal7',10,0,1],['txtTotal8',14,0,1],['txtFirstmoney',14,0,1],['txtSecondmoney',14,0,1]];
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
            	var t_where = "where=^^ a.noa!='Z001' and a.noa!='010132' and a.partno<='09' order by a.partno,a.jobno^^";
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

		var salexrank,salhtype,salexpo;
		var late_point=0,early_point=0,person_point=0,sick_point=0,leave_point=0,marriage_point=0,bereavement_point=0;
		var great_point=0,minor_point=0,commend_point=0,majorde_point=0,peccadillo_point=0,reprimand_point=0;
        function q_gtPost(t_name) {  /// 資料下載後 ...
            switch (t_name) {
            	case 'salaward_import':
            		var as = _q_appendData("sss", "", true);
            		q_gridAddRow(bbsHtm, 'tbbs', 'txtSssno,txtNamea,txtJob,txtIndate,txtTotal1,txtLate,txtLeaveearly,txtPerson,txtSick,txtLeave,txtMarriageleave,txtBereavementleave,txtGreatmeriy,txtMinormerits,txtCommend,txtMajordemerits,txtPeccadillo,txtReprimand,txtMemo,txtSalary,txtBo_admin,txtBo_traffic,txtBo_special'
            		, as.length, as, 
            		'noa,namea,job,indate,total,late,early,person,sick,leave,marriage,bereavement,great,minor,commend,majorde,peccadillo,reprimand,memo,salary,bo_admin,bo_traffic,bo_special', '');
            			
            		sum();
            		break;
            	case 'salhtype':
            		salhtype=_q_appendData("salhtype", "", true);
            		for (var i = 0; i < salhtype.length; i++) {
            			if(salhtype[i].namea=='遲到')
            				late_point=dec(salhtype[i].point);
            			if(salhtype[i].namea=='早退')
            				early_point=dec(salhtype[i].point);
            			if(salhtype[i].namea=='事假')
            				person_point=dec(salhtype[i].point);
            			if(salhtype[i].namea=='病假')
            				sick_point=dec(salhtype[i].point);
            			if(salhtype[i].namea=='曠工')
            				leave_point=dec(salhtype[i].point);
            			if(salhtype[i].namea=='婚假')
            				marriage_point=dec(salhtype[i].point);
            			if(salhtype[i].namea=='喪假')
            				bereavement_point=dec(salhtype[i].point);
            		}
            		break;
            	case 'salexpo':
            		salexpo=_q_appendData("salexpo", "", true);
            		for (var i = 0; i < salexpo.length; i++) {
            			if(salexpo[i].namea=='大功')
            				great_point=dec(salexpo[i].point);
            			if(salexpo[i].namea=='小功')
            				minor_point=dec(salexpo[i].point);
            			if(salexpo[i].namea=='嘉獎')
            				commend_point=dec(salexpo[i].point);
            			if(salexpo[i].namea=='大過')
            				majorde_point=dec(salexpo[i].point);
            			if(salexpo[i].namea=='小過')
            				peccadillo_point=dec(salexpo[i].point);
            			if(salexpo[i].namea=='申誡')
            				reprimand_point=dec(salexpo[i].point);
            		}
            		break;
            	case 'salexrank':
            		salexrank=_q_appendData("salexrank", "", true);
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
        	for(var j = 0; j < q_bbsCount; j++) {
           		if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           			$('#txtTotal1_'+j).change(function() {sum();});
           			$('#txtLate_'+j).change(function() {sum();});
           			$('#txtLeaveearly_'+j).change(function() {sum();});
           			$('#txtPerson_'+j).change(function() {sum();});
           			$('#txtSick_'+j).change(function() {sum();});
           			$('#txtLeave_'+j).change(function() {sum();});
           			$('#txtMarriageleave_'+j).change(function() {sum();});
           			$('#txtBereavementleave_'+j).change(function() {sum();});
           			$('#txtGreatmeriy_'+j).change(function() {sum();});
           			$('#txtMinormerits_'+j).change(function() {sum();});
           			$('#txtCommend_'+j).change(function() {sum();});
           			$('#txtMajordemerits_'+j).change(function() {sum();});
           			$('#txtPeccadillo_'+j).change(function() {sum();});
           			$('#txtReprimand_'+j).change(function() {sum();});
           			$('#txtSalary_'+j).change(function() {sum();});
           			$('#txtBo_admin_'+j).change(function() {sum();});
           			$('#txtBo_traffic_'+j).change(function() {sum();});
           			$('#txtBo_special_'+j).change(function() {sum();});
           			$('#txtAwardmon_'+j).change(function() {monsum();});
           			$('#txtTotal5_'+j).change(function() {totalsum();});
           			$('#txtTotal6_'+j).change(function() {totalsum();});
           			$('#txtTotal7_'+j).change(function() {totalsum();});
           			$('#txtTotal8_'+j).change(function() {totalssum();});
           			$('#txtFirstmoney_'+j).change(function() {
           				t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						q_tr('txtSecondmoney_'+b_seq,q_float('txtTotal8_'+b_seq)-q_float('txtFirstmoney_'+b_seq));
           			});
           			$('#txtSecondmoney_'+j).change(function() {
           				t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
           				q_tr('txtFirstmoney_'+b_seq,q_float('txtTotal8_'+b_seq)-q_float('txtSecondmoney_'+b_seq));
           			});
        		}
           	}
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            q_gt('salexrank', '', 0, 0, 0, "", r_accy);
            q_gt('salhtype', '', 0, 0, 0, "", r_accy);
            q_gt('salexpo', '', 0, 0, 0, "", r_accy);
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtYear').val(dec(q_date().substr(0,3))-1);
            $('#txtDatea').val(q_date());
            $('#txtYear').focus();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            q_gt('salexrank', '', 0, 0, 0, "", r_accy);
            q_gt('salhtype', '', 0, 0, 0, "", r_accy);
            q_gt('salexpo', '', 0, 0, 0, "", r_accy);
            $('#txtYear').focus();
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['sssno']) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];
            return true;
        }

        function sum() {
            var t_total= 0;
            for (var j = 0; j < q_bbsCount; j++) {
            	//出勤扣分數
            	var total2_floor=0;
            	//計算整數部分
            	total2_floor=(Math.floor(q_float('txtLate_'+j)/8)*late_point)
            	+(Math.floor(q_float('txtLeaveearly_'+j)/8)*early_point)
            	+(Math.floor(q_float('txtPerson_'+j)/8)*person_point)
            	+(Math.floor(q_float('txtSick_'+j)/8)*sick_point)
            	+(Math.floor(q_float('txtLeave_'+j)/8)*leave_point)
            	+(Math.floor(q_float('txtMarriageleave_'+j)/8)*marriage_point)
            	+(Math.floor(q_float('txtBereavementleave_'+j)/8)*bereavement_point);
            	//小數部分
            	if(q_float('txtLate_'+j)%8>0)
            		total2_floor+=late_point/2;
            	if(q_float('txtLeaveearly_'+j)%8>0)
            		total2_floor+=early_point/2;
            	if(q_float('txtPerson_'+j)%8>0)
            		total2_floor+=person_point/2;
            	if(q_float('txtSick_'+j)%8>0)
            		total2_floor+=sick_point/2;
            	if(q_float('txtLeave_'+j)%8>0)
            		total2_floor+=leave_point/2;
            	if(q_float('txtMarriageleave_'+j)%8>0)
            		total2_floor+=marriage_point/2;
            	if(q_float('txtBereavementleave_'+j)%8>0)
            		total2_floor+=bereavement_point/2;
            	q_tr('txtTotal2_'+j,total2_floor)
            	
            	//獎懲分數
            	q_tr('txtTotal3_'+j,(q_float('txtGreatmeriy_'+j)*great_point)+(q_float('txtMinormerits_'+j)*minor_point)+(q_float('txtCommend_'+j)*commend_point)+(q_float('txtMajordemerits_'+j)*majorde_point)+(q_float('txtPeccadillo_'+j)*peccadillo_point)+(q_float('txtReprimand_'+j)*reprimand_point));
            	//分數合計
            	q_tr('txtTotal4_'+j,q_float('txtTotal1_'+j)-q_float('txtTotal2_'+j)+q_float('txtTotal3_'+j));
            	//獎金月份數
            	for (var k = 0; k < salexrank.length; k++) {
            		if(dec(salexrank[k].point1)<=q_float('txtTotal4_'+j) &&dec (salexrank[k].point2) > q_float('txtTotal4_'+j) ){
            			$('#txtAwardmon_'+j).val(salexrank[k].awardmon);
            			break;
            		}
            	}
            	//考績獎金
            	q_tr('txtTotal5_'+j,(q_float('txtSalary_'+j)+q_float('txtBo_admin_'+j)+q_float('txtBo_traffic_'+j)+q_float('txtBo_special_'+j))*q_float('txtAwardmon_'+j));
            	//年終獎金(大昌預設1個月)
            	q_tr('txtTotal6_'+j,q_float('txtSalary_'+j)+q_float('txtBo_admin_'+j)+q_float('txtBo_traffic_'+j)+q_float('txtBo_special_'+j));
            	//績效獎金(預設0)
            	q_tr('txtTotal7_'+j,0);
            	//獎金合計=考績獎金+年終獎金+績效獎金
            	q_tr('txtTotal8_'+j,q_float('txtTotal5_'+j)+q_float('txtTotal6_'+j)+q_float('txtTotal7_'+j));
            	//發放金額
            	q_tr('txtFirstmoney_'+j,q_float('txtTotal8_'+j)/2);
            	q_tr('txtSecondmoney_'+j,q_float('txtTotal8_'+j)/2);
            	
				t_total+=dec($('#txtTotal8_'+j).val());
            }  // j
            q_tr('txtTotal',t_total);
        }
        function monsum() {//計算考績獎金月份金額合計(人工調整獎金用)
            var t_total= 0;
            for (var j = 0; j < q_bbsCount; j++) {
            	//獎金金額
            	q_tr('txtTotal5_'+j,(q_float('txtSalary_'+j)+q_float('txtBo_admin_'+j)+q_float('txtBo_traffic_'+j)+q_float('txtBo_special_'+j))*q_float('txtAwardmon_'+j));
            }  // j
            totalsum();
        }
        function totalsum() {//只計算每個獎金金額合計(人工調整獎金用)
            var t_total= 0;
            for (var j = 0; j < q_bbsCount; j++) {
            	q_tr('txtTotal8_'+j,q_float('txtTotal5_'+j)+q_float('txtTotal6_'+j)+q_float('txtTotal7_'+j));
            	//發放金額
            	q_tr('txtFirstmoney_'+j,q_float('txtTotal8_'+j)/2);
            	q_tr('txtSecondmoney_'+j,q_float('txtTotal8_'+j)/2);
				t_total+=dec($('#txtTotal8_'+j).val());
            }  // j
            q_tr('txtTotal',t_total);
        }
        function totalssum() {//只計算獎金合計(人工調整獎金用)
            var t_total= 0;
            for (var j = 0; j < q_bbsCount; j++) {
            	//發放金額
            	q_tr('txtFirstmoney_'+j,q_float('txtTotal8_'+j)/2);
            	q_tr('txtSecondmoney_'+j,q_float('txtTotal8_'+j)/2);
				t_total+=dec($('#txtTotal8_'+j).val());
            }  // j
            q_tr('txtTotal',t_total);
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
                width: 2900px;
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
                <!--<td align="center" style="width:75px;"><a id='lblLeavewithoutpay_s'> </a></td>-->
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
                <td align="center" style="width:100px;"><a id='lblTotal6_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal7_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblTotal8_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblFirstmoney_s'> </a></td>
                <td align="center" style="width:100px;"><a id='lblSecondmoney_s'> </a></td>
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
                <!--<td ><input  id="txtLeavewithoutpay.*" type="text" class="txt num c1" /></td>-->
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
                <td ><input  id="txtTotal6.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal7.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal8.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtFirstmoney.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtSecondmoney.*" type="text" class="txt num c1" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
