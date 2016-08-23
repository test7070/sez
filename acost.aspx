<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            q_tables = 't';
            var q_name = "acost";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtMoney1',10,0,1],['txtMoney2',10,0,1],['txtMoney3',10,0,1]];
            var bbtNum = [];
            var bbmMask = [['txtDatea','999/99/99']];
            var bbsMask = [];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'accy';
            q_desc = 1;
            brwCount2 = 4;
            aPop = new Array();
			
			function sum(){       

            }
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });        
            
                                  
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }
            
            function mainPost() {
                q_getFormat();
                q_mask(bbmMask);      
                
                q_cmbParse("cmbTypea", "@,1@查帳,2@書審,3@工程業,4@建設業");       
                $('#cmbTypea').change(function(e){
                	var tmp = new Array();
                	switch($(this).val()){
                		case '1':
                			
                		/*	tmp.plus({}'54})
                		
                		
                			直接人工     54
        					製造費用	  55    		
                			勞務成本     5701','5799
                			修理成本     5801','5899
                			其他營業成本  '5901','5999' 
                			
                			進銷成本減項  5205','5206*/
                			break;
                		case '2':
                			break;
                		case '3':
                			break;
                		case '4':
                			break;
                		default:
                			break;
                	}
                });               
            }
            
            function q_gtPost(t_name) {
                switch (t_name) { 
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;          
                }
            }
            
            function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
			}
			
				
			
            function btnOk() {
            	Lock(1,{opacity:0});
            	sum();
            	if(q_cur ==1){
	            	$('#txtWorker').val(r_name);
	            }else if(q_cur ==2){
	            	$('#txtWorker2').val(r_name);
	            }else{
	            	alert("error: btnok!");
	            }
	            //---------------------------------------------------
	            if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
					Unlock(1);
            		return;
				}
	            var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('acost_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function q_popPost(id) {
				switch(id) {
					default:
						break;
				}
			}
			function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if ($('#btnMinus_' + i).hasClass('isAssign'))
                    	continue;
                }
                _bbsAssign();
            }
			
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
            }
            
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
                sum();
            }

            function btnPrint() {
                q_box("z_acost.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy, 'accashf', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['item']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            function bbtSave(as) {
                if (!as['item']) {
                    as[bbtKey[1]] = '';
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
            function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 150px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
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
                width: 650px;
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
                height: 42px;
            }
            .tbbm tr td {
                width: 10%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                width: 100%;
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
            .dbbs {
            	float:left;
                width: 550px;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            #dbbt {
            	float:left;
                width: 650px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px white double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: black;
                background: #FFDDAA;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px white double;
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
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
					</tr>
					<tr style="display:none;">
						<td><span> </span><a id="lblAccy" class="lbl"> </a></td>
						<td><input id="txtAccy" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTypea" class="lbl">類別</a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="float:left; width:880px;">
			<table id="tbbs" class='tbbs' >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:30px;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;display: none;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:400px;"><a id='lblItem_s'> </a></td>
					<td align="center" style="width:350px;"><a id='lblAcc1_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMoney1_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMoney2_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMoney3_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;display: none;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>		
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>	
					<td><input type="text" id="txtItem.*" style="width:98%;" /></td>
					<td><input type="text" id="txtAcc1.*" style="width:98%;" /></td>
					<td><input type="text" id="txtMoney1.*" style="width:96%; text-align: right;" /></td>
					<td><input type="text" id="txtMoney2.*" style="width:96%; text-align: right;" /></td>
					<td><input type="text" id="txtMoney3.*" style="width:96%; text-align: right;" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" style="float:left; display: none;">
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td align="center" style="width:30px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;display: none;" value="＋"/>
						<input id="btnLoad" value="匯入" type="button" onclick="btnLoad_click()" style="font-size: medium; font-weight: bold;"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:200px; text-align: center;">項目</td>
						<td style="width:200px; text-align: center;">會計科目</td>
						<td style="width:120px; text-align: center;">金額</td>
					</tr>
					<tr>
						<td align="center">
						<input class="btn"  id="btnMinut..*" type="button" value='-' style=" font-weight: bold;display: none;" />
						<input class="btn"  id="btnPlutX..*" type="button" value='+' style="font-weight: bold;"  />
						<input id="txtNoq..*" type="text" style="display: none;" />
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input id="txtItem..*"  type="text" style="width:95%;"/></td>
						<td>
							<input id="txtAcc1..*"  type="text" style="float:left;width:97%;"/>
							<input id="txtBacc1..*"  type="text" style="float:left;width:45%;"/>
							<a style="float:left;width:5%;">~</a>
							<input id="txtEacc1..*"  type="text" style="float:left;width:45%;"/>						
						</td>
						<td><input id="txtMoney..*" type="text" style="width:95%; text-align: right;"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
