<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
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
            q_tables = 's';
            var q_name = "accu";
            var q_readonly = ['txtNoa', 'txtTotal'];
            var q_readonlys = ['txtAcc2'];
            var bbmNum = [['txtTotal', 14, 0, 1]];
            var bbsNum = [['txtMoney', 12, 0, 1], ['txtWeight', 12, 3, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            q_desc = 1;
			brwCount2 = 4;
			
            aPop = new Array(['txtAcc1_', 'btnAcc1_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_,,txtMoney_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtPartno_', 'btnPart_', 'acpart', 'noa,part', 'txtPartno_,txtPart_', "acpart_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtProj_', 'btnProj_', 'proj', 'noa,proj', 'txtProjno_,txtProj_', "proj_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtPartno', 'lblPart', 'acpart', 'noa,part', 'txtPartno,txtPart', "acpart_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtProj', 'lblProj', 'proj', 'noa,proj', 'txtProjno,txtProj', "proj_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtMon', r_picm]];
                q_mask(bbmMask);
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
            	var t_partno = $.trim($('#txtPartno').val());
            	var t_part = $.trim($('#txtPart').val());
            	var t_projno = $.trim($('#txtProjno').val());
            	var t_proj = $.trim($('#txtProj').val());
            	
            	for(var i=0;i<q_bbsCount;i++){
            		if(t_partno.length>0){
            			if($('#txtPartno_'+i).val().length==0){
            				$('#txtPartno_'+i).val(t_partno);
            				$('#txtPart_'+i).val(t_part);
            			}
            		}
            		if(t_projno.length>0){
            			if($('#txtProjno_'+i).val().length==0){
            				$('#txtProjno_'+i).val(t_projno);
            				$('#txtProj_'+i).val(t_proj);
            			}
            		}
            	}
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtMon').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_accu') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('accu_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtAcc1_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtAcc1_', '');
                            $('#btnAcc1_'+n).click();
                        });
                        $('#txtPartno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtPartno_', '');
                            $('#btnPart_'+n).click();
                        });
                        $('#txtPorjno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace('txtPorjno_', '');
                            $('#btnPorj_'+n).click();
                        });
                        $('#txtMoney_' + i).change(function() {
                            sum();
                        });
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtMon').val(q_date().substring(0, 6));

                $('#txtMon').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;

                _btnModi();

            }

            function btnPrint() {
                q_box('z_accu.aspx', '', "95%", "650px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['acc1']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_total = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    t_total += dec($('#txtMoney_' + j).val());
                }// j
                q_tr('txtTotal', t_total);
            }

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
                overflow: visible;
                width: 1200px;
            }
            .dview {
                float: left;
                width: 400px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30%;
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
                width: 600px;
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
                width: 1%;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 1200px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 1200px;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 1500px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
            #InterestWindows {
                display: none;
                width: 20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewMon'> </a></td>
						<td style="width:100px; color:black;"><a id='vewPart'> </a></td>
						<td style="width:100px; color:black;"><a id='vewProj'> </a></td>
						<td style="width:100px; color:black;"><a id='vewTotal'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td id='mon' style="text-align: center;">~mon</td>
						<td id='part' style="text-align: center;">~part</td>
						<td id='proj' style="text-align: center;">~proj</td>
						<td id='total,0,1' style="text-align: center;">~total,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPart' class="lbl"> </a></td>
						<td><input id="txtPartno"  type="text"  class="txt c1"/></td>
						<td><input id="txtPart"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProj' class="lbl"> </a></td>
						<td><input id="txtProjno"  type="text"  class="txt c1"/></td>
						<td><input id="txtProj"  type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;">
					<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"></td>
					<td style="width:150px;"><a id='lblAcc1_s'></a></td>
					<td style="width:200px;"><a id='lblAcc2_s'></a></td>
					<td style="width:80px;"><a id='lblMoney_s'></a></td>
					<td style="width:120px;"><a id='lblPartno_s'></a></td>
					<td style="width:120px;"><a id='lblProj_s'></a></td>
					<td style="width:80px;"><a id='lblWeight_s'></a></td>
					<td style="width:200px;"><a id='lblMemo_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
					<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="txt" id="txtAcc1.*" type="text" style="width:95%; float:left;"/>
						<input id="btnAcc1.*" type="button" style="display:none;">
					</td>
					<td>
						<input class="txt" id="txtAcc2.*" type="text" style="width:95%; float:left;"/>
					</td>
					<td>
						<input class="txt" id="txtMoney.*" type="text num" style="width:95%; float:left;"/>
					</td>
					<td>
						<input class="txt" id="txtPartno.*" type="text" style="width:45%; float:left;"/>
						<input class="txt" id="txtPart.*" type="text" style="width:45%; float:left;"/>
						<input id="btnPart.*" type="button" style="display:none;">
					</td>
					<td>
						<input class="txt" id="txtProjno.*" type="text" style="width:45%; float:left;"/>
						<input class="txt" id="txtProj.*" type="text" style="width:45%; float:left;"/>
						<input id="btnProj.*" type="button" style="display:none;">
					</td>
					<td>
						<input class="txt" id="txtWeight.*" type="text num" style="width:95%; float:left;"/>
					</td>
					<td>
						<input class="txt" id="txtMemo.*" type="text" style="width:95%; float:left;"/>
					</td>
				</tr>
			</table>
		</div>
		
		<input id="q_sys" type="hidden" />
	</body>
</html>
