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
            q_desc=1;
			q_tables = 's';
            var q_name = "accer";
            var q_readonly = ['txtNoa','txtTotal'];
			var q_readonlys = ['txtAcc2'];
            var bbmNum = [['txtTotal', 10, 0, 1]];
		    var bbsNum = [['txtMoney', 10, 0, 1],['txtMoney', 3, 1, 0]];
            var bbmMask = [];
		    var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 3;//15
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
            ['txtPartno_', 'btnPart_', 'part', 'noa,part', 'txtPartno_,txtPart_', "part_b.aspx"]);
            $(document).ready(function() {
                bbmKey = ['noa'];
		        bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
                // 1=Last  0=Top
            }

            function mainPost() {
            	q_getFormat();
                q_mask(bbmMask);
        		bbsMask = [['txtMon', r_picm]];
                q_mask(bbsMask);
                
                $('#btnImported').click(function() {
                	if(!emp($('#txtMon').val())){
                		//找出去年全部會計4大類的資料(dmoney-cmoney),取得%數的分母
                		var t_where = "where=^^ left(accc2,2)=right('"+$('#txtMon').val()+"',2) ^^";
				        q_gt('accc', t_where , 0, 1, 0, "", r_accy + '_' + r_cno);
                	}
                });
            }
			
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);                      
                        break;
                }  
            }
			
			var accc4total=0;
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'accc':
                		var as = _q_appendData("acccs", "", true);
                		accc4total=0;
                		for(var i = 0;i < as.length;i++){
                			if(as[i].accc5.substr(0,1)=='4')
                				accc4total+=dec(as[i].dmoney)-dec(as[i].cmoney);
		            	}
                		
                		var t_where = "where=^^ mon ='"+$('#txtMon').val()+"' ^^";
				        q_gt('accu', t_where , 0, 0, 0, "", r_accy);	
                		break;
                	case 'accu':
                		var as = _q_appendData("accus", "", true);
                		for(var i = 0;i < as.length;i++){
                			as[i].per=round(dec(as[i].money)/accc4total,0);
                		}
                		
                		q_gridAddRow(bbsHtm, 'tbbs', 'txtAcc1,txtAcc2,txtPer,txtMoney,txtPartno,txtPart,txtMemo'
		            	, as.length, as, 'acc1,acc2,per,money,partno,part,memo', 'txtAcc1');
                		
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('accer_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtMon').val(q_date().substr(0,6));
                $('#txtMon').focus();
            }
            
	        function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
           			if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           				$('#txtMoney_'+j).change(function () {sum();});
           			}
            	}
	            _bbsAssign();
	        }
	        
	        function sum() {
            	var t_total = 0;
            	for(var j = 0; j < q_bbsCount; j++) {
            		t_total+=q_float('txtMoney_'+j);
            	}
                	q_tr('txtTotal',t_total);//金額合計
            }
	       
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtMon').focus();
                cmbTypea_chg();
            }

            function btnPrint() {

            }

            function btnOk() {
            	var t_err = '';
            	t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
	            if (t_err.length > 0) {
	                alert(t_err);
	                return;
	            }

            	//$('#txtWorker').val(r_name)
            	
            	sum();
            	
                var t_noa = trim($('#txtNoa').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll($('#txtMon').val(), '/', ''));
                else
                    wrServer(t_noa);
            }
			
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }
            
	        function bbsSave(as) {
	            if (!as['acc1'] ) {  
	                as[bbsKey[1]] = '';   
	                return;
	            }
	            q_nowf();
	            return true;
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
                width: 25%; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
                width: 100%;

            }
            .tview tr {
                height: 32px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 75%;
                /*margin: -1px;        
                border: 1px black solid;*/
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 97%;
                float: left;
            }
            .txt.c2 {
                width: 86%;
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
            
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMon'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewTotal'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='mon' style="text-align: center;">~mon</td>
						<td id='total,0,1' style="text-align: center;">~total,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr1" style="display:none">
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td>	<input id="txtNoa" type="text" class="txt c1"/></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td><input class="btn"  id="btnImported" type="button" value='預估資料匯入'/></td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1"/></td>
						<td></td>
					</tr>
					<!--<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="2"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>-->
				</table>
			</div>
		</div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                <td align="center" style="width:10%"><a id='lblAcc1s'></a></td>
                <td align="center" style="width:12%"><a id='lblAcc2s'></a></td>
                <td align="center" style="width:10%"><a id='lblPers'></a></td>
                <td align="center" style="width:10%"><a id='lblMoneys'></a></td>
                <td align="center" style="width:10%"><a id='lblParts'></a></td>
                <td align="center" style="width:15%"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td >
                	<input id="txtAcc1.*" type="text" class="txt c2"/>
                	<input class="btn"  id="btnAcc.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
                </td>
                <td ><input id="txtAcc2.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtPer.*" type="text" class="txt num c1"/></td>
                <td ><input id="txtMoney.*" type="text" class="txt num c1"/></td>
                <td >
                	<input id="txtPartno.*" type="text" class="txt c2"/>
                	<input class="btn"  id="btnPart.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					<input id="txtPart.*" type="text" class="txt c1"/>
                </td>
                <td >
                	<input  id="txtMemo.*" type="text" class="txt c1"/>
                	<input id="txtNoq.*" type="hidden" />
                </td>
            </tr>
        </table>
        </div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
