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

            var q_name = "banks";
            var q_readonly = ['txtNoa','txtAccno','txtWorker'];
            var bbmNum = [['txtMoney', 10, 0, 1], ['txtMoney2', 10, 0, 1], ['txtMoney3', 10, 0, 1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 20;
            aPop = new Array(['txtBankno', 'lblBank', 'bank2', 'noa,bank2,account', 'txtBankno,txtBank', 'bank2_b.aspx'],
            				 ['txtBanktno', 'lblBankt', 'bankt', 'noa,namea', 'txtBanktno,txtBanktname', 'bankt_b.aspx'],
           					 ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
           					 ['txtAcc3', 'lblAcc2', 'acc', 'acc1,acc2', 'txtAcc3,txtAcc4', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
            $(document).ready(function() {
                bbmKey = ['noa'];
                brwCount2 = 20
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);          
            }

            function mainPost() {
				bbmMask = [['txtDatea', r_picd],['txtEnddate', r_picd],['txtPaydate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbBankt", q_getPara('bankt.typea'));
				$('#txtAcc1').change(function() {
					var str=$.trim($(this).val());
                	if((/^[0-9]{4}$/g).test(str))
                		$(this).val(str+'.');
				});
				$('#txtAcc3').change(function() {
					var str=$.trim($(this).val());
                	if((/^[0-9]{4}$/g).test(str))
                		$(this).val(str+'.');
				});
				
				$('#lblAccno').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + (!emp($('#txtDatea').val())?$('#txtDatea').val().substring(0, 3):r_accy) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('lblAccc'), true);
				});
            }
            
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }  
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                } 
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('banks_s.aspx', q_name + '_s', "500px", "500px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtDatea').val(q_date());
            	$('#txtNoa').val('AUTO');
                $('#txtDatea').focus();
                bankt_change();
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                
          		if (q_chkClose())
             		    return;
                _btnModi();
                $('#txtDatea').focus();
                
            }

            function btnPrint() {

            }

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtbanks', q_getMsg('lblbanks')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                $('#txtWorker').val(r_name);
				var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_banks') + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                $('#lblAcc1x').text($('#lblAcc1').text());
				$('#lblAcc2x').text($('#lblAcc2').text());
				bankt_change();
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
            	
          		if (q_chkClose())
             		    return;
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            function bankt_change(){
				bankt_val = $('#cmbBankt').val();
				if(bankt_val == '1'){
					$('#txtAcc1').val('').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
					$('#txtAcc2').val('').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
					$('#txtEnddate').val('').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
					$('#txtAcc3').attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
					$('#txtAcc4').attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
					$('#txtMoney2').attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
					$('#txtCheckno').attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
					$('#txtPaydate').attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
					$('#txtBankno3').attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
					$('#txtMoney3').attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
					$('#txtBank3').attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
					$('#lblAcc1').show();
					$('#lblAcc1x').hide();
					$('#lblAcc2').hide();
					$('#lblAcc2x').show();
				}else if(bankt_val == '2'){
					$('#txtAcc3').val('').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
					$('#txtAcc4').val('').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
					$('#txtMoney2').val('0').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
					$('#txtCheckno').val('').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
					$('#txtPaydate').val('').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
					$('#txtBankno3').val('').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
					$('#txtMoney3').val('0').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
					$('#txtBank3').val('').removeAttr('readonly').css('background-color', 'rgb(255, 255, 255)').css('color','');
					$('#txtAcc1').attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
					$('#txtAcc2').attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
					$('#txtEnddate').attr('readonly','readonly').css('background-color', 'rgb(237, 237, 238)').css('color','green');
					$('#lblAcc1x').show();
					$('#lblAcc1').hide();
					$('#lblAcc2x').hide();
					$('#lblAcc2').show();
				}else{
					$('#lblAcc1x').hide();
					$('#lblAcc2x').hide();
				}
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
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
                width: 10%;
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
            }
            .tbbs input[type="text"] {
                width: 98%;
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
            
            .pay {
                background-color: tan;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:280px; color:black;"><a id='vewBank'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='bank' style="text-align: left;">~bank</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBank' class="lbl btn"> </a></td>
						<td><input id="txtBankno"  type="text" class="txt c1" /></td>
						<td><input id="txtBank"  type="text" class="txt c1" /></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblLcno' class="lbl"> </a></td>
						<td><input id="txtLcno" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblLcno2' class="lbl"> </a></td>
						<td><input id="txtLcno2" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBankt' class="lbl btn"> </a></td>
						<td><input id="txtBanktno" type="text" class="txt c1" /></td>
						<td><input id="txtBanktname" type="text" class="txt c1" /></td>
						<td><select id="cmbBankt" class="txt c1" onchange="bankt_change();"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCointype' class="lbl"> </a></td>
						<td><input id="txtCointype" type="text" class="txt c1" /></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFloat' class="lbl"> </a></td>
						<td><input id="txtFloat" type="text" class="txt num c1" /></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcc1' class="lbl btn"> </a><a id='lblAcc1x' class="lbl btn"> </a></td>
						<td><input id="txtAcc1" type="text" class="txt c1" /></td>
						<td><input id="txtAcc2" type="text" class="txt c1" /></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEnddate' class="lbl"> </a></td>
						<td><input id="txtEnddate" type="text" class="txt c1" /></td>
						<td> </td>
					</tr>
					<tr class="pay">
						<td><span> </span><a id='lblAcc2' class="lbl btn"> </a> <a id='lblAcc2x' class="lbl btn"> </a></td>
						<td><input id="txtAcc3" type="text" class="txt c1" /></td>
						<td><input id="txtAcc4" type="text" class="txt c1" /></td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="pay">
						<td><span> </span><a id='lblMoney2' class="lbl"> </a></td>
						<td><input id="txtMoney2" type="text" class="txt num c1" /></td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="pay">
						<td><span> </span><a id='lblCheckno' class="lbl"> </a></td>
						<td><input id="txtCheckno" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblPaydate' class="lbl"> </a></td>
						<td><input id="txtPaydate" type="text" class="txt c1" /></td>
						<td> </td>
					</tr>
					<tr class="pay">
						<td><span> </span><a id='lblBankno3' class="lbl"> </a></td>
						<td><input id="txtBankno3" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblMoney3' class="lbl"> </a></td>
						<td><input id="txtMoney3" type="text" class="txt num c1" /></td>
						<td> </td>
					</tr>
					<tr class="pay">
						<td><span> </span><a id='lblBank3' class="lbl"> </a></td>
						<td colspan="3"><input id="txtBank3" type="text" class="txt c1" /></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3" ><textarea id="txtMemo"  style="width:100%; height: 60px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
