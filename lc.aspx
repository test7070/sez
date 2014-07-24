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
            var q_name = "lc";
            var q_readonly = ['txtWorker', 'txtWorker2', 'txtUnpay', 'txtUnpayus', 'txtTotal', 'txtBank'];
            var q_readonlys = [];
            var bbmNum = [['txtCredit', 15, 0, 1], ['txtConrate1', 15, 0, 1], ['txtConrate2', 15, 0, 1], ['txtExpire', 3, 0, 1], ['txtRate', 10, 4, 1], ['txtUnpay', 15, 0, 1], ['txtUnpayus', 15, 0, 1], ['txtTotal', 15, 0, 1]];
            var bbsNum = [['txtMoney', 15, 0, 1], ['txtLcmoney', 15, 0, 1], ['txtRate', 15, 4, 1], ['txtConrate1', 15, 4, 1], ['txtConrate2', 15, 4, 1], ['txtFloat', 15, 4, 1], ['txtUnpay', 15, 0, 1], ['txtPay', 15, 0, 1], ['txtLch', 15, 0, 1], ['txtChgmoney', 15, 0, 1], ['txtChgfloat', 15, 4, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtAcc1', 'lblNamea', 'acc', 'acc1,acc2', 'txtAcc1,txtNamea', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], ['txtAccno', 'lblAccno', 'acc', 'acc1,acc2', 'txtAccno', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], ['txtAccno2', 'lblAccno2', 'acc', 'acc1,acc2', 'txtAccno2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], ['txtAccno4', 'lblAccno4', 'acc', 'acc1,acc2', 'txtAccno4', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], ['txtAccno5', 'lblAccno5', 'acc', 'acc1,acc2', 'txtAccno5', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], ['txtAccno6', 'lblAccno6', 'acc', 'acc1,acc2', 'txtAccno6', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], ['txtBankno', 'lblBank', 'bank', 'noa,bank', 'txtBankno,txtBank', "bank_b.aspx"]);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtAcc1').focus();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                // 1=Last  0=Top
            }

            function mainPost() {
                bbmMask = [['txtDatea', r_picd]];
                bbsMask = [['txtDatea', r_picd]]
                q_mask(bbmMask);
                q_cmbParse("cmbCoin", q_getPara('sys.coin'));

                $('#txtAccno3').change(function() {
                    $(this).val($.trim($(this).val()).toUpperCase());
                    if ($(this).val().length > 0 && q_cur == 1) {
                        t_where = "where=^^ accno3='" + $(this).val() + "'^^";
                        q_gt('lc', t_where, 0, 0, 0, "findAccno3", r_accy);
                    }
                });

                $('#txtAcc1').change(function(e) {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');

                    $(this).val($.trim($(this).val()).toUpperCase());
                    if ($(this).val().length > 0 && q_cur == 1) {
                        t_where = "where=^^ acc1='" + $(this).val() + "'^^";
                        q_gt('lc', t_where, 0, 0, 0, "checkAcc1_change", r_accy);
                    }
                });

                $('#txtAccno').change(function(e) {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');

                    $(this).val($.trim($(this).val()).toUpperCase());
                });

                $('#txtAccno2').change(function(e) {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');

                    $(this).val($.trim($(this).val()).toUpperCase());
                });

                $('#txtAccno4').change(function(e) {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');

                    $(this).val($.trim($(this).val()).toUpperCase());
                });

                $('#txtAccno6').change(function(e) {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');

                    $(this).val($.trim($(this).val()).toUpperCase());
                });

                $('#txtAccno5').change(function(e) {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');

                    $(this).val($.trim($(this).val()).toUpperCase());
                });

                $('#btnLcc').click(function(e) {
                    q_box('z_lcc.aspx', 'z_lcc;', "95%", "95%", $('#btnLcc').val());
                });
                
                $('#btnGqb').click(function(e) {
                    q_box('z_gqb.aspx', 'z_gqb;', "95%", "95%", $('#btnGqb').val());
                });
                
                $('#btnAccc').click(function(e) {
                    q_box('z_accc.aspx', 'z_accc;', "95%", "95%", $('#btnAccc').val());
                });
                
                $('#btnBank').click(function(e) {
                    q_box('z_bank.aspx', 'z_accc;', "95%", "95%", $('#btnBank').val());
                });
            }
			
			var qbox=false;
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'lcs':
                    	if(!emp($('#txtNoa').val())){
                    		q_func('qtxt.query.lcschang', 'lc.txt,lcschang,' + $('#txtNoa').val());
                    	}
                    	qbox=true;
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///q_boxClose 3/4
                        break;
                }/// end Switch
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'gettotal':
                     var t_bill=0;
                     var as = _q_appendData("lcs", "", true);
                     for (var i=0; i < as.length; i++) {
						t_bill=q_sub(dec(as[i].lcmoney),dec(as[i].money));
                     };
                     
                     q_tr('txtTotal',q_sub(q_sub(q_float('txtCredit'),q_float('txtUnpay')),t_bill));
                     
                     break;
                    case 'findAccno3':
                        var as = _q_appendData("lc", "", true);
                        if (as[0] != undefined) {
                            $('#txtAccname3').val(as[0].accname3);
                        }
                        break;
                    case 'checkAcc1_change':
                        var as = _q_appendData("lc", "", true);
                        if (as[0] != undefined) {
                            alert('已存在 ' + as[0].acc1 + ' ' + as[0].namea);
                        }
                        break;
                    case 'checkAcc1_btnOk':
                        var as = _q_appendData("lc", "", true);
                        if (as[0] != undefined) {
                            alert('已存在 ' + as[0].acc1 + ' ' + as[0].namea);
                            Unlock();
                            return;
                        } else {
                            acc1ok = true;
                            Unlock();
                            btnOk();
                        }
                        break;
					case 'recnobbs':
						refresh(q_recno);
						qbox=false;
						break;
                    case q_name:
                    	if (q_cur == 0 && qbox){
                    		t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
                        	q_gt('lc', t_where, 0, 0, 0, "recnobbs", r_accy);
						}
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
            }

            function btnIns() {
                _btnIns();
                refreshBbm();
                $('#txtAcc1').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
                $('#txtCredit').focus();
            }

            function btnPrint() {
                q_box('z_lc.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }

            var acc1ok = false;
            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtAcc1', q_getMsg('lblAcc1')]]);

                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }

                if (!acc1ok && q_cur == 1) {
                    Lock();
                    t_where = "where=^^ acc1='" + $('#txtAcc1').val() + "'^^";
                    q_gt('lc', t_where, 0, 0, 0, "checkAcc1_btnOk", r_accy);
                    return;
                }

                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);

                var t_noa = trim($('#txtAcc1').val()).replace('.', '');
                if (t_noa.length == 0)
                    q_gtnoa(q_name, t_noa);
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						$('#btnDetail_'+i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_where = "noa='"+$('#txtNoa').val()+"' and noq='"+$('#txtNoq_'+b_seq).val()+"'";
                        	q_box('lcs.aspx', 'lcs;' + t_where, "80%", "80%", $('#btnDetail_'+b_seq).val());
						});
                    }
                }
                _bbsAssign();
                
               $('.dbbs .txt').css('color','green').css('background','RGB(237,237,237)').attr('disabled','disabled');
               
               /*$('#btnPluss').click(function(e) {
	               	if(!emp($('#txtNoa').val())){
	                    var t_where = "noa='"+$('#txtNoa').val()+"'";
	                	q_box('lcs.aspx', 'lcs;' + t_where, "98%", "95%", q_getMsg('popLcs'));
	                }
                });*/
            }

            function bbsSave(as) {
                if (!as['datea']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                //as['datea'] = abbm2['datea'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                refreshBbm();
                if(emp($('#txtAccno3').val())){
					var t_noa = trim($('#txtAcc1').val()).replace('.','');
					var t_where = "swhere=^^noa='"+t_noa+"' and isnull(chgdate,'')!='' and '"+q_date()+"'<=isnull(lcdate,'') and isnull(lcno,'')!='' and isnull(lcodate,'')!='' and isnull(coin,'')='' ^^";
					q_gt('lcs', t_where, 0, 0, 0, "gettotal", r_accy);
				}else{
					$('#txtTotal').val('0');
				}
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                refreshBbm();
                 $('.dbbs .txt').css('color','green').css('background','RGB(237,237,237)').attr('disabled','disabled');
                 if(!t_para){
                 	$('#btnPluss').attr('disabled','disabled');
                 	for (var i = 0; i < q_bbsCount; i++) {
                 		$('#btnDetail_'+i).attr('disabled','disabled');
                 	}
                 }
            }

            function refreshBbm() {
                if (q_cur == 1) {
                    $('#txtAcc1').css('color', 'black').css('background', 'white').removeAttr('readonly');
                } else {
                    $('#txtAcc1').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                }
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
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.lcschang':
                		q_gt(q_name, q_content, q_sqlCount, 1);
                	break;
                }
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 98%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 98%;
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
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
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
                width: 50%;
                float: left;
            }
            .txt.c7 {
                width: 70%;
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
            .tbbm textarea {
                font-size: medium;
            }
            .dbbs {
                width: 2800px;
            }
            .tbbs a {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbm .ch1, .tbbm .ch2, .tbbm .ch3, .tbbm .ch4 {
                background-color: #FFEC8B;
                text-align: right;
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1260px;">
			<div class="dview" id="dview" style="float: left;  width:250px;"  >
				<table class="tview" id="tview"border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewAcc1'> </a></td>
						<td align="center" style="width:30%"><a id='vewNamea'> </a></td>
						<!--<td align="center" style="width:20%"><a id='vewAccno3'> </a></td>
						<td align="center" style="width:30%"><a id='vewAccname3'> </a></td>-->
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='acc1'>~acc1</td>
						<td align="center" id='namea'>~namea</td>
						<!--<td align="center" id='accno3'>~accno3</td>
						<td align="center" id='accname3'>~accname3</td>-->
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 1000px;float: left;">
				<table class="tbbm"  id="tbbm"border="0" cellpadding='2'  cellspacing='5'>
					<tr class="tr1">
						<td class="td1"><span> </span><a id="lblNamea" class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtAcc1" type="text" class="txt c1"/>
							<input id="txtNoa" type="text" style="display:none;"/>
						</td>
						<td class="td4" colspan="2"><input id="txtNamea" type="text" class="txt c1" /></td>
						<td class="td5"><span> </span><a id="lblCredit" class="lbl"> </a></td>
						<td class="td6"><input id="txtCredit" type="text" class="txt num c1" /></td>
						<td class="td7"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td8"><input id="txtDatea" type="text" class="txt c1" /></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtAccno" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id="lblAccno2" class="lbl btn"> </a></td>
						<td class="td4"><input id="txtAccno2" type="text" class="txt c1" /></td>
						<td class="td5"><span> </span><a id="lblAccno4" class="lbl btn"> </a></td>
						<td class="td6"><input id="txtAccno4" type="text" class="txt c1" /></td>
						<td class="td7"><span> </span><a id="lblAccno6" class="lbl btn"> </a></td>
						<td class="td8"><input id="txtAccno6" type="text" class="txt c1" /></td>
						<td class="td9"><span> </span><a id="lblAccno5" class="lbl btn"> </a></td>
						<td class="tdA"><input id="txtAccno5" type="text" class="txt c1" /></td>
					</tr>
					<tr class="tr3">
						<td align="left"><a id="lblSet" style="color: #000066;font-size: 20px;"> </a></td>
					</tr>
					<tr class="tr4">
						<td class="ch1"><span> </span><a id="lblConrate2" class="lbl"> </a></td>
						<td class="ch2">
							<input id="txtConrate2" type="text" class="txt num c7"/>
							<a id="lblSymbol" > </a>
						</td>
						<td class="ch3"><span> </span><a id="lblConrate1" class="lbl"> </a></td>
						<td class="ch4">
							<input id="txtConrate1" type="text" class="txt num c7"/>
							<a id="lblSymbol1"> </a>
						</td>
						<td class="td5"><span> </span><a id="lblExpire" class="lbl"> </a></td>
						<td class="td6">
							<input id="txtExpire" type="text" class="txt num c2"/>
							<a id="lblsymbol2"> </a>
						</td>
						<td class="td7"><span> </span><a id="lblRate" class="lbl"> </a></td>
						<td class="td8"><input id="txtRate" type="text" class="txt num c1"/></td>
						<td class="td9"><span> </span><a id="lblCoin" class="lbl"> </a></td>
						<td class="tdA"><select id="cmbCoin" class="txt c1"> </select></td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblAccname3" class="lbl"> </a></td>
						<td class="td2"><input id="txtAccno3" type="text" class="txt c1"/></td>
						<td class="td4" colspan="2"><input id="txtAccname3" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblUnpay" class="lbl"> </a></td>
						<td class="td6"><input id="txtUnpay" type="text" class="txt num c1"/></td>
						<td class="td8" colspan="2"><input id="txtUnpayus" type="text" class="txt num c1"/></td>
						<td class="td9"><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td class="tdA"><input id="txtTotal" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblBank" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtBankno" type="text" class="txt c1"/></td>
						<td class="td3" colspan="2"><input id="txtBank" type="text" class="txt c1" /></td>
						<td class="td5"><span> </span><a id="lblDetail" class="lbl"> </a></td>
						<td class="td6"> </td>
						<td class="td7"><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td class="td8"><input id="txtWorker" type="text" class="txt c1"/></td>
						<td class="td9"><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td class="tdA"><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr7">
						<td class="td6"> </td>
						<td class="td6" colspan="7">
							<input id="btnLcc" type="button"/>
							<input id="btnGqb" type="button"/>
							<input id="btnAccc" type="button"/>
							<input id="btnBank" type="button"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;height: 31px;">
						<!--<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />-->
						<!--<input class="btn"  id="btnPluss" type="button" value='+' style="font-weight: bold;"  />-->
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:50px;"> </td>
					<td align="center" style="width:100px;"><a id='lblDatea_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblTgg_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPay_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblUnpay_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblRate_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPaydate_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblLcmoney_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblLcodate_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblLcdate_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblLcno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblCoin_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblConrate1_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblConrate2_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblFloat_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPaymonth_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblCno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPayno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPayaccno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblLch_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblLcaccno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblChgdate_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblChgacc1_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblChgmoney_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblChgaccno_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="btnDetail.*" type="button" value="Detail"/></td>
					<td><input id="txtDatea.*" type="text" class="txt c1" /></td>
					<td>
						<input id="txtTggno.*" type="text" class="txt c1" />
						<input id="txtTgg.*" type="text" class="txt c1" />
					</td>
					<td><input id="txtMoney.*" type="text" class="txt c1 num" /></td>
					<td><input id="txtPay.*" type="text" class="txt c1 num" /></td>
					<td><input id="txtUnpay.*" type="text" class="txt c1 num" /></td>
					<td><input id="txtRate.*" type="text" class="txt c1 num" /></td>
					<td><input id="txtPaydate.*" type="text" class="txt c1" /></td>
					<td><input id="txtLcmoney.*" type="text" class="txt c1 num" /></td>
					<td><input id="txtLcodate.*" type="text" class="txt c1" /></td>
					<td><input id="txtLcdate.*" type="text" class="txt c1" /></td>
					<td><input id="txtLcno.*" type="text" class="txt c1" /></td>
					<td><input id="txtCoin.*" type="text" class="txt c1" /></td>
					<td><input id="txtConrate1.*" type="text" class="txt c1 num" /></td>
					<td><input id="txtConrate2.*" type="text" class="txt c1 num" /></td>
					<td><input id="txtFloat.*" type="text" class="txt c1 num" /></td>
					<td><input id="txtPaymonth.*" type="text" class="txt c1" /></td>
					<td><input id="txtCno.*" type="text" class="txt c1" /></td>
					<td><input id="txtPayno.*" type="text" class="txt c1" /></td>
					<td><input id="txtPayaccno.*" type="text" class="txt c1" /></td>
					<td><input id="txtLch.*" type="text" class="txt c1 num" /></td>
					<td><input id="txtLcaccno.*" type="text" class="txt c1" /></td>
					<td><input id="txtChgdate.*" type="text" class="txt c1" /></td>
					<td><input id="txtChgacc1.*" type="text" class="txt c1" /></td>
					<td><input id="txtChgmoney.*" type="text" class="txt c1 num" /></td>
					<td><input id="txtChgaccno.*" type="text" class="txt c1" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
