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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_desc = 1;
            q_tables = 's';
            var q_name = "trip";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtPartno','txtPart'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            brwCount2 = 5;
            aPop = new Array(['txtSssno', 'lblSss', 'sss', 'noa,namea,part', 'txtSssno,txtNamea', 'sss_b.aspx'], ['txtCno_', 'btnAcomp_', 'custtgg', 'noa,comp', 'txtCno_,txtAcomp_', 'custtgg_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_desc = 1;
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                bbsMask = [['txtBtime', '99:99'], ['txtEtime', '99:99']];
                q_mask(bbsMask);
				$('#txtDatea').datepicker();
                $('#txtSssno').change(function() {
                    //aPop後會檢查 員工是否重覆輸入出差日期
                });
                $('#txtDatea').change(function() {
                    chkTrip('chk_trip_change');
                });
                $('#lblAgent').click(function () {
	            	q_box("sss_b2.aspx", 'sss', "95%", "95%", q_getMsg("popSss"));
	        	});

            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                	case 'sss':
                        ret = getb_ret();
                        if(q_cur > 0 && q_cur < 4){
	                        if(ret[0]!=undefined){
	                        	for (var i = 0; i < ret.length; i++) {
	                        		if($('#txtAgent').val().length>0){
		                            	var temp=$('#txtAgent').val();
		                            	$('#txtAgent').val(temp+','+ret[i].namea);
		                            }else{
		                            	$('#txtAgent').val(ret[i].namea);
		                            } 
	                        	}
	                        }
						}
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_popPost(s1) {
                switch (s1) {
                    case 'txtSssno':
                    	//有時點選APOP會有問題,因此相關資料重抓一次
                    	var t_sssno = $.trim($('#txtSssno').val());
                    	if(t_sssno.length>0){
                    		var t_where = "where=^^ noa='"+ t_sssno +"'^^";
                    		q_gt('sss', t_where, 0, 0, 0, "apop_sss", r_accy);
                    	}else{
                    		$('#txtNamea').val('');
                        	$('#txtPartno').val('');
                        	$('#txtPart').val('');
                    	}
                        break;
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'apop_sss':
                		var as = _q_appendData("sss", "", true);
                        if (as[0] != undefined) {
                        	$('#txtNamea').val(as[0]['namea']);
                        	$('#txtPartno').val(as[0]['partno']);
                        	$('#txtPart').val(as[0]['part']);
                        }
                        chkTrip('chk_trip_change');
                		break;
                	case 'chk_trip_change':
                		var as = _q_appendData("trip", "", true);
                        if (as[0] != undefined) {
                        	alert('重覆輸入出差日期。');
                        }
                		break;
                	case 'chk_trip_btnok':
                		var as = _q_appendData("trip", "", true);
                        if (as[0] != undefined) {
                        	alert('重覆輸入出差日期!');
                        	Unlock();
                        }else{
                        	if(q_cur ==1){
				            	$('#txtWorker').val(r_name);
				            }else if(q_cur ==2){
				            	$('#txtWorker2').val(r_name);
				            }else{
				            	alert("error: btnok!");
				            }
                        	var t_noa = trim($('#txtNoa').val());
			                var t_date = trim($('#txtDatea').val());
			                if (t_noa.length == 0 || t_noa == "AUTO")
			                    q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
			                else
			                    wrServer(t_noa);
                        }
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
            function chkTrip(key){
            	//chk_trip_change :  sssno、datea 異動時
            	//chk_trip_btnok :  存檔時
            	//判斷員工是否重覆輸入出差日期
            	var t_noa = $.trim($('#txtNoa').val());
                var t_sssno = $.trim($('#txtSssno').val());
                var t_datea = $.trim($('#txtDatea').val());
        		if (t_sssno.length>0 && t_datea.length>0) {
                    var t_where = "where=^^ noa !='"+ t_noa +"' and datea ='" + t_datea + "' and sssno='" + t_sssno + "' ^^";
                    q_gt('trip', t_where, 0, 0, 0, key, r_accy);
                }
            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }
            function btnOk() {
            	Lock();
            	if($.trim($('#txtSssno').val()).length == 0){
            		alert(q_getMsg('lblSss') + '禁止為空。');
                    Unlock();
                    return;
            	}
            	if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock();
                    return;
                }     
                for (var i = 0; i < q_bbsCount; i++) {
                    for (var j = 0; j < q_bbsCount; j++) {
                        if (!emp($('#txtBtime_' + i).val()) && !emp($('#txtEtime_' + i).val()) && i != j && !emp($('#txtBtime_' + j).val()) && !emp($('#txtEtime_' + j).val()) && ($('#txtBtime_' + i).val() < $('#txtBtime_' + j).val() && $('#txtEtime_' + i).val() > $('#txtBtime_' + j).val() || $('#txtEtime_' + i).val() > $('#txtEtime_' + j).val() && $('#txtBtime_' + i).val() < $('#txtEtime_' + j).val())) {
                            alert('時間段與其他行程時間重疊,請檢查!!!');
                            $('#txtBtime_' + i).focus();
                            Unlock();
                            return;
                        }
                    }
                }
				sum();
				chkTrip('chk_trip_btnok');
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('trip_s.aspx', q_name + '_s', "600px", "500px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_'+i).text(i+1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                        $('#txtBtime_' + i).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;

                            if (!emp($('#txtBtime_' + b_seq).val()) && !emp($('#txtEtime_' + b_seq).val()) && $('#txtBtime_' + b_seq).val() > $('#txtEtime_' + b_seq).val()) {
                                var t_time = $('#txtBtime_' + b_seq).val();
                                $('#txtBtime_' + b_seq).val($('#txtEtime_' + b_seq).val());
                                $('#txtEtime_' + b_seq).val(t_time);
                            }
                            for (var j = 0; j < q_bbsCount; j++) {
                                if (!emp($('#txtBtime_' + b_seq).val()) && !emp($('#txtEtime_' + b_seq).val()) && b_seq != j && !emp($('#txtBtime_' + j).val()) && !emp($('#txtEtime_' + j).val()) && ($('#txtBtime_' + b_seq).val() < $('#txtBtime_' + j).val() && $('#txtEtime_' + b_seq).val() > $('#txtBtime_' + j).val() || $('#txtEtime_' + b_seq).val() > $('#txtEtime_' + j).val() && $('#txtBtime_' + b_seq).val() < $('#txtEtime_' + j).val())) {
                                    alert('該時間段與其他行程時間重疊!!!');
                                    $('#txtBtime_' + b_seq).focus();
                                    return;
                                }
                                if (!emp($('#txtBtime_' + b_seq).val()) && b_seq != j && !emp($('#txtBtime_' + j).val()) && !emp($('#txtEtime_' + j).val()) && ($('#txtBtime_' + b_seq).val() > $('#txtBtime_' + j).val() && $('#txtBtime_' + b_seq).val() < $('#txtEtime_' + j).val())) {
                                    alert('該時間與其他行程時間重疊!!!');
                                    $('#txtBtime_' + b_seq).focus();
                                    return;
                                }
                            }
                        });
                        $('#txtEtime_' + i).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if (!emp($('#txtBtime_' + b_seq).val()) && !emp($('#txtEtime_' + b_seq).val()) && $('#txtBtime_' + b_seq).val() > $('#txtEtime_' + b_seq).val()) {
                                var t_time = $('#txtBtime_' + b_seq).val();
                                $('#txtBtime_' + b_seq).val($('#txtEtime_' + b_seq).val());
                                $('#txtEtime_' + b_seq).val(t_time);
                            }
                            for (var j = 0; j < q_bbsCount; j++) {
                                if (!emp($('#txtBtime_' + b_seq).val()) && !emp($('#txtEtime_' + b_seq).val()) && b_seq != j && !emp($('#txtBtime_' + j).val()) && !emp($('#txtEtime_' + j).val()) && ($('#txtBtime_' + b_seq).val() < $('#txtBtime_' + j).val() && $('#txtEtime_' + b_seq).val() > $('#txtBtime_' + j).val() || $('#txtEtime_' + b_seq).val() > $('#txtEtime_' + j).val() && $('#txtBtime_' + b_seq).val() < $('#txtEtime_' + j).val())) {
                                    alert('該時間段與其他行程時間重疊!!!');
                                    $('#txtBtime_' + b_seq).focus();
                                    return;
                                }
                                if (!emp($('#txtEtime_' + b_seq).val()) && b_seq != j && !emp($('#txtBtime_' + j).val()) && !emp($('#txtEtime_' + j).val()) && ($('#txtEtime_' + b_seq).val() > $('#txtBtime_' + j).val() && $('#txtEtime_' + b_seq).val() < $('#txtEtime_' + j).val())) {
                                    alert('該時間與其他行程時間重疊!!!');
                                    $('#txtEtime_' + b_seq).focus();
                                    return;
                                }
                            }
                        });
                    }
                }

                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtMemo').focus();
            }

            function btnPrint() {
                q_box('z_trip.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['cno'] && !as['btime'] && !as['memo']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['datea'] = abbm2['datea'];
                as['sssno'] = abbm2['sssno'];

                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0, money_total = 0;
                for (var j = 0; j < q_bbsCount; j++) {

                } // j
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
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
                width: 250px;
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
                width: 700px;
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
                width: 950px;
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
                width: 100%;
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
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewDatea"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewNamea"> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="namea" style="text-align: center;">~namea</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height: 1px;">
						<td><input type="text" id="txtCheckno" style="display:none;"></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSss" class="lbl btn"> </a></td>
						<td>
							<input id="txtSssno"  type="text" style="float:left;width:40%;"/>
							<input id="txtNamea"  type="text" style="float:left;width:60%;"/>
						</td>
						<td>
							<input id="txtPartno"  type="text" style="float:left;display:none;"/>
							<input id="txtPart"  type="text" style="float:left;width:40%;"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAgent' class="lbl btn"> </a></td>
						<td class="td2" colspan="3"><input id="txtAgent"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan='3'><input id="txtMemo"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold; width:90%;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:150px;"><a id='lblTimes'></a></td>
					<td align="center" style="width:120px;"><a id='lblCnos'></a></td>
					<td align="center" style="width:200px;"><a id='lblAcomps'></a></td>
					<td align="center" style="width:300px;"><a id='lblMemos'></a></td>
					<td align="center" style="width:60px;"><a id='lblTele_pollings'></a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold; width:90%;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td >
						<input id="txtBtime.*" type="text" style="float:left; width:60px;" />
						<a style="display:block;float:left; width:20px;">&sim;</a>
						<input id="txtEtime.*" type="text" style="float:left; width:60px;"/>
					</td>
					<td>
						<input id="btnAcomp.*" type="button" style="float:left;width:10px;" />
						<input id="txtCno.*" type="text" style="float:left;width:90px;"/>
					</td>
					<td><input type="text" id="txtAcomp.*"  style="width:95%;"/></td>
					<td><input id="txtMemo.*" type="text" style="width:95%;"/></td>
					<td><input id="chkTele_polling.*" type="checkbox"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
