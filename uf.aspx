<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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

            q_desc = 1;
            q_tables = 's';
            var q_name = "uf";
            var q_readonly = ['txtAccno', 'txtNoa', 'txtWorker', 'txtWorker2', 'txtMoney', 'txtCheckno', 'txtCmoney'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney', 10, 0, 1]];
            var bbsNum = [['txtMoney', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [['txtDatea', '999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtBankno_', 'btnBankno_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx'], 
            				 ['txtBankno', 'lblBank', 'bank', 'noa,bank,account,acc1,cno,acomp', 'txtBankno,txtBank,txtAccount,txtAcc1,txtCno,txtAcomp', 'bank_b.aspx'], 
            				 ['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
            				 ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
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
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                bbsMask = [['txtDatea', r_picd]];
                q_getFormat();
                q_cmbParse("cmbTypea", q_getPara('uf.typea'));
                $("#cmbTypea").focus(function() {
                    var len = $("#cmbTypea").children().length > 0 ? $("#cmbTypea").children().length : 1;
                    $("#cmbTypea").attr('size', len + "");
                }).blur(function() {
                    $("#cmbTypea").attr('size', '1');
                }).change(function() {
                	compshow();
				});
                
                $('#lblAccno').click(function() {
                    var t_year=$('#txtDatea').val().substr(0,r_len);
                	if(r_len==4){
                		t_year=q_sub(t_year,1911);
                	}
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + t_year + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                });
                //........................託收匯入
                $('#btnGqb').click(function() {
                    var t_where = "";
                    //11/12到期日<= 兌現日
                    if (emp($('#txtBankno').val())) {
						t_where = "where=^^isnull(a.indate,'')<='"+$('#txtDatea').val()+"' and ( (len(isnull(a.usage,''))=0 and isnull(a.enda,'')!='Y' and isnull(b.sel,0) = 0 and a.typea='" + $('#cmbTypea').val() + "') or (c.noa is not null and c.noa='" + $('#txtNoa').val() + "') ) ^^";
                    } else {
                        if ($('#cmbTypea').val() == '1'){
                            t_where = "where=^^isnull(a.indate,'')<='"+$('#txtDatea').val()+"' and ( (len(isnull(a.usage,''))=0 and a.tbankno='" + $('#txtBankno').val() + "' and isnull(a.enda,'')!='Y' and isnull(b.sel,0) = 0 and a.typea='" + $('#cmbTypea').val() + "') or (c.noa is not null and c.noa='" + $('#txtNoa').val() + "') ) ^^";
                            if(q_getPara('sys.project').toUpperCase()=='VU')
                            	t_where = "where=^^isnull(a.indate,'')<='"+$('#txtDatea').val()+"' and ( (len(isnull(a.usage,''))=0 and a.tbankno='" + $('#txtBankno').val() + "' and isnull(a.enda,'')!='Y' and isnull(b.sel,0) = 0 and a.typea='" + $('#cmbTypea').val() + "') or (c.noa is not null and c.noa='" + $('#txtNoa').val() + "') ) ^^";
                        }if ($('#cmbTypea').val() == '2'){
                            t_where = "where=^^isnull(a.indate,'')<='"+$('#txtDatea').val()+"' and ( (len(isnull(a.usage,''))=0 and a.bankno='" + $('#txtBankno').val() + "' and isnull(a.enda,'')!='Y' and isnull(b.sel,0) = 0  and a.typea='" + $('#cmbTypea').val() + "') or (c.noa is not null and c.noa='" + $('#txtNoa').val() + "') ) ^^";
                            if(q_getPara('sys.project').toUpperCase()=='VU')
                            	t_where = "where=^^isnull(a.indate,'')<='"+$('#txtDatea').val()+"' and ( (len(isnull(a.usage,''))=0 and a.bankno='" + $('#txtBankno').val() + "' and isnull(a.enda,'')!='Y' and isnull(b.sel,0) = 0  and a.typea='" + $('#cmbTypea').val() + "') or (c.noa is not null and c.noa='" + $('#txtNoa').val() + "') ) ^^";
                           }
                    }
                    Lock();
                    q_gt('uf_gqb', t_where, 0, 0);
                });
                //.........................
            }

            function browGqb(obj) {
                var noa = $.trim($(obj).val());
                if (noa.length > 0)
                    q_box("gqb.aspx?;;;gqbno='" + noa + "';" + r_accy, 'gqb', "95%", "95%", q_getMsg("popGqb"));
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'uf_gqb':
                        var as = _q_appendData("gqb", "", true);
                        //if(as.length>q_bbsCount)
                        q_gridAddRow(bbsHtm, 'tbbs', 'chkSel,txtCheckno,txtBankno,txtBank,txtDatea,txtMoney,txtTaccl,txtCompno,txtComp,txtTcompno,txtTcomp'
                        , as.length, as, 'sel,gqbno,bankno,bank,indate,money,tacc1,compno,comp,tcompno,tcomp', '');

                        for (var j = 0; j < q_bbsCount; j++) {
                            if ($('#chkSel_' + j).prop("checked")) {//判斷是否被選取
                                $('#trSel_' + j).addClass('chksel');
                                //變色
                            } else {
                                $('#trSel_' + j).removeClass('chksel');
                                //取消變色
                            }
                        }
                        Unlock();
                        sum();
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
                /// end switch
            }

            function btnOk() {
                sum();
                var t_checkno = "";
                var t_cmoney = "", t_money = 0;
                var t_err='';
                for (var i = 0; i < q_bbsCount; i++) {
                    if ($.trim($('#txtCheckno_' + i).val()).length > 0) {
                        t_checkno += (t_checkno.length > 0 ? "," : "") + $.trim($('#txtCheckno_' + i).val());
                    }
                    t_money = parseFloat($('#txtMoney_' + i).val().length == 0 ? '0' : $('#txtMoney_' + i).val().replace(',', ''));
                    if (t_money != 0) {
                        t_cmoney += ',' + t_money + ',';
                    }
                    
                    //1050223 只取第一筆無託會票據
                    if(q_getPara('sys.project').toUpperCase()=='VU' && $('#cmbTypea').val()=='1' && !emp($('#txtCheckno_'+i).val()) && emp($('#txtTaccl_'+i).val()) && t_err.length==0){
                    	t_err=$('#txtCheckno_'+i).val()+"無"+q_getMsg('lblTaccl')+"!!"
                    }
                }
                $('#txtCheckno').val(t_checkno);
                $('#txtCmoney').val(t_cmoney);
                
                if(t_err.length>0){
                	alert(t_err);
                    return;
                }
                
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else if (q_cur == 2) {
                    $('#txtWorker2').val(r_name);
                } else {
                    alert("error: btnok!");
                }
                Lock();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_uf') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('uf_s.aspx', q_name + '_s', "550px", "450px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                        $('#chkSel_' + i).click(function() {
                            sum();
                        });
                        $('#chkSel_' + i).hover(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            $('#trSel_' + b_seq).addClass('sel');
                        }, function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            $('#trSel_' + b_seq).removeClass('sel');
                            if ($('#chkSel_' + b_seq).prop("checked")) {//判斷是否被選取
                                $('#trSel_' + b_seq).addClass('chksel');
                                //變色
                            } else {
                                $('#trSel_' + b_seq).removeClass('chksel');
                                //取消變色
                            }
                        });
                    }
                }//end for
                _bbsAssign();
                ChecknoReadonly();
                compshow();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                $('#cmbTypea').val(2).focus();
                compshow();
                //取消變色
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#trSel_' + i).removeClass('chksel');
                }
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                if (q_chkClose())
                    return;
                _btnModi();
                ChecknoReadonly();
                $('#txtDatea').focus();
            }

            function btnPrint() {
                q_box('z_uf.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (as['sel'] != 'true' && as['checkno'].substring(as['checkno'].length, as['checkno'].length - 1) != '##') {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['date'] = abbm2['date'];
                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0, money_total = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                    if ($('#chkSel_' + j).prop("checked"))
                        money_total += dec($('#txtMoney_' + j).val());
                    //兌現金額總計
                }// j
                q_tr('txtMoney', money_total, 2);
            }

            function q_stPost() {
                if (q_cur == 1 || q_cur == 2) {
                    abbm[q_recno]['accno'] = xmlString;
                    /// 存檔後， server 傳回 xmlString
                    $('#txtAccno').val(xmlString);
                    /// 顯示 server 端，產生之傳票號碼
                }
                Unlock();
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function refresh(recno) {
                _refresh(recno);
                for (var j = 0; j < q_bbsCount; j++) {
                    if ($('#chkSel_' + j).prop("checked")) {//判斷是否被選取
                        $('#trSel_' + j).addClass('chksel');
                        //變色
                    } else {
                        $('#trSel_' + j).removeClass('chksel');
                        //取消變色
                    }
                }
                ChecknoReadonly();
                compshow();
            }

            function ChecknoReadonly() {
                for (var j = 0; j < q_bbsCount; j++) {
                    if ((q_cur == 1 || q_cur == 2) && $('#txtCheckno_' + j).val() != '') {
                        $('#txtCheckno_' + j).attr('readonly', 'readonly');
                        $('#txtCheckno_' + j).css('background-color', 'rgb(237, 237, 238)').css('color', 'green');
                    }
                }// j
                
                if(q_getPara('sys.project').toUpperCase()=='VU'){ //1050226
					$('#txtBankno').attr('readonly', 'readonly').css('background-color', 'rgb(237, 237, 238)').css('color', 'green');
					$('#txtBank').attr('readonly', 'readonly').css('background-color', 'rgb(237, 237, 238)').css('color', 'green');
					$('#txtCno').attr('readonly', 'readonly').css('background-color', 'rgb(237, 237, 238)').css('color', 'green');
					$('#txtAcomp').attr('readonly', 'readonly').css('background-color', 'rgb(237, 237, 238)').css('color', 'green');
					$('#txtAccount').attr('readonly', 'readonly').css('background-color', 'rgb(237, 237, 238)').css('color', 'green');
					$('#txtAcc1').attr('readonly', 'readonly').css('background-color', 'rgb(237, 237, 238)').css('color', 'green');
					$('#txtAcc2').attr('readonly', 'readonly').css('background-color', 'rgb(237, 237, 238)').css('color', 'green');
					
					aPop = new Array(['txtBankno_', 'btnBankno_', 'bank', 'noa,bank', 'txtBankno_,txtBank_', 'bank_b.aspx']);
                }
                
            }
            
            function compshow() {
                if($('#cmbTypea').val()=='1'){
                	$('.ccomp').show();
                	$('.tcomp').hide();
                }else{
                	$('.tcomp').show();
                	$('.ccomp').hide();
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#btnGqb').attr('disabled', 'disabled');
                } else {
                    $('#btnGqb').removeAttr('disabled');
                }
                ChecknoReadonly();
                compshow();
            }

            function btnMinus(id) {
                _btnMinus(id);
                var fieldId = id.split('_')[1];
                $('#txtCheckno_' + fieldId).removeAttr('readonly');
                $('#txtCheckno_' + fieldId).css('background-color', 'rgb(255, 255, 255)').css('color', '');
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                sum();
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
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 200px;
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
                width: 750px;
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
                width: 14%;
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
            .dbbs {
                width: 950px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
            tr.sel td {
                background-color: yellow;
            }
            tr.chksel td {
                background-color: bisque;
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
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMoney'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td id='money,0,1' style="text-align: right;" >~money,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td><input id="txtCheckno"type="text" style="display:none;"/></td>
						<td><input id="txtCmoney"type="text" style="display:none;"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblType" class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1" style="font-size: medium;"> </select></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBank" class="lbl btn" > </a></td>
						<td colspan="3">
							<input id="txtBankno" type="text" style="float:left; width:40%;"/>
							<input id="txtBank"  type="text" style="float:left; width:60%;"/>
						</td>
						<td><span> </span><a id="lblCno" class="lbl btn" > </a></td>
						<td colspan="2">
							<input id="txtCno" type="text" style="float:left; width:40%;"/>
							<input id="txtAcomp"  type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAccount" class="lbl" > </a></td>
						<td colspan="3"><input id="txtAccount" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblAcc1" class="lbl btn" > </a></td>
						<td colspan="2">
							<input id="txtAcc1" type="text" style="float:left; width:40%;"/>
							<input id="txtAcc2"  type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney"  type="text" class="txt num c1" /></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
						<td><span> </span></td>
						<td><input type="button" id="btnGqb" class="txt c1 " value="託收匯入" style="width:80%;"></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" class="td0"><a id='vewChks'> </a></td>
					<td align="center" class="td1"> </td>
					<td align="center" class="td1"><a id='lblCheckno'> </a></td>
					<td align="center" class="td1" style="width:18%"><a id='lblBanknos'> </a></td>
					<td align="center" style="width:15%"><a id='lblBanks'> </a></td>
					<td align="center" style="width:115px;" class="ccomp"><a id='lblComps'> </a></td>
					<td align="center" style="width:115px;" class="tcomp"><a id='lblTcomps'> </a></td>
					<td align="center" class="td1" style="width:10%"><a id='lblDateas'> </a></td>
					<td align="center" class="td1"><a id='lblMoneys'> </a></td>
					<td align="center" class="td1" style="width:15%"><a id='lblTaccl'> </a></td>
				</tr>
				<tr id="trSel.*" style='background:#cad3ff;'>
					<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td ><input id="chkSel.*" type="checkbox"/></td>
					<td ><input id="txtCheckno.*" onclick="browGqb(this)" type="text" style="width: 95%"/></td>
					<td ><input id="txtBankno.*" type="text" style="width: 95%"/></td>
					<td ><input id="txtBank.*" type="text" style="width: 95%"/></td>
					<td class="ccomp">
						<input class="txt c1" id="txtCompno.*" type="hidden"/>
						<input class="txt c1 ccomp" id="txtComp.*" type="text"  style="width: 95%"/>
					</td>
					<td class="tcomp">
						<input class="txt c1" id="txtTcompno.*" type="hidden"/>
						<input class="txt c1 tcomp" id="txtTcomp.*" type="text"  style="width: 95%"/>
					</td>
					<td ><input id="txtDatea.*" type="text" style="width: 95%"/></td>
					<td ><input class="txt num c1" id="txtMoney.*" type="text" style="width: 95%"/></td>
					<td >
						<input class="txt c1" id="txtTaccl.*" type="text" style="width: 95%"/>
						<input id="txtNoq.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
