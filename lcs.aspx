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

            var q_name = "lcs";
            var q_readonly = ['txtUnpay', 'txtPay', 'txtLcaccno', 'txtPayno', 'txtAccno', 'txtChgaccno', 'txtTgg', 'textAcc1','txtBank'];
            var bbmNum = [['txtMoney', 15, 0, 1], ['txtLcmoney', 15, 0, 1], ['txtRate', 15, 4, 1], ['txtConrate1', 15, 4, 1], ['txtConrate2', 15, 4, 1], ['txtFloat', 15, 4, 1], ['txtUnpay', 15, 0, 1], ['txtPay', 15, 0, 1], ['txtLch', 15, 0, 1], ['txtChgmoney', 15, 0, 1], ['txtChgfloat', 15, 4, 1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = "";
            aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,nick', 'txtTggno,txtTgg', 'tgg_b.aspx']
            							,['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            							, ['txtBankno', 'lblBank', 'bank', 'noa,bank', 'txtBankno,txtBank', "bank_b.aspx"]
            							,['txtChgacc1', 'lblChgacc1','acc','acc1,acc2', 'txtChgacc1', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);

            $(document).ready(function() {
                bbmKey = ['noa','noq'];
                if (window.parent.q_name == 'lc' && window.parent.document.getElementById('txtNoa').value!='') {
                    q_readonly.push('txtNoa');
                }
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
            
            function sum() {
            	
            }

            function mainPost() {
                bbmMask = [['txtDatea', r_picd], ['txtPaydate', r_picd], ['txtLcodate', r_picd], ['txtLcdate', r_picd], ['txtChgdate', r_picd], ['txtPaymonth', r_picm]];
                q_mask(bbmMask);
                q_cmbParse("cmbCoin", q_getPara('sys.coin'));
                
                $('#lblAccno').click(function () {
                	if(!emp($('#txtAccno').val()))
		            	q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
		        });
		        
		        $('#lblLcaccno').click(function () {
		        	if(!emp($('#txtLcaccno').val()))
		            	q_pop('txtLcaccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtLcaccno').val() + "';" + $('#txtDatea').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
		        });
		        
		        $('#lblChgaccno').click(function () {
		        	if(!emp($('#txtChgaccno').val()))
		            	q_pop('txtChgaccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtChgaccno').val() + "';" + $('#txtChgdate').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
		        });
		        
		        $('#lblPayaccno').click(function () {
		        	if(!emp($('#txtPayaccno').val()))
		            	q_pop('txtPayaccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtPayaccno').val() + "';" + $('#txtPaymonth').val().substring(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
		        });
		        
		        $('#lblPayno').click(function () {
		        	if(!emp($('#txtPayno').val()))
		            	q_box("pay.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtPayno').val() + "'", 'pay', "95%", "95%", q_getMsg("popPay"));
		        });
		        
		        $('#btnLct').click(function () {
		        	if(!emp($('#txtNoa').val()) && !emp($('#txtNoq').val()))
		            	q_box("lct.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val()+'-'+ $('#txtNoq').val() + "'", 'lct', "500px", "500px", $('#btnLct').val());
		        });
		        
		        $('#txtChgacc1').change(function () {
		        	var s1 = trim($(this).val());
					if (s1.length > 4 && s1.indexOf('.') < 0)
						$(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
					if (s1.length == 4)
						$(this).val(s1 + '.');
		        });
		        
		        $('#btnLoan').click(function () {
		        	//lc.genAccc( noa, 4)  // 借款
		        	q_func('lc.genAccc.4',$('#txtNoa').val()+",4");
		        });
		        
		        $('#btnLch').click(function () {
		        	//lc.genAccc( noa, 1)  // 開狀
		        	q_func('lc.genAccc.1',$('#txtNoa').val()+",1");
		        });
		        
		        $('#btnPay').click(function () {
		        	//lc.genAccc( noa, 2)  // 付款
		        	q_func('lc.genAccc.2',$('#txtNoa').val()+",2");
		        });
		        
		        $('#btnChg').click(function () {
		        	//lc.genAccc( noa, 3)  // 改貸
		        	q_func('lc.genAccc.3',$('#txtNoa').val()+",3");
		        });
		        
		        $('#btnSeek').hide();
		        $('#btnPrint').hide();
		        $('#btnPrev').hide();
		        $('#btnNext').hide();
		        $('#btnPrevPage').hide();
		        $('#btnNextPage').hide();
		        $('#dview').hide();
            }
			
			var qbox=false;
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'lct':
                		if(!emp($('#txtNoa').val())&&!emp($('#txtNoq').val())){
                    		q_func('qtxt.query.lctchang', 'lc.txt,lctchang,' + $('#txtNoa').val()+';'+$('#txtNoq').val());
                    	}
                    	qbox=true;
                		break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'getnoq':
                		var t_noq='000';
                		var as = _q_appendData("lcs", "", true);
                		if (as[0] != undefined) {
                			t_noq=as[0].noq
                		}
                		t_noq=('000'+(dec(t_noq)+1)).toString().substr(-3);
                		$('#txtNoq').val(t_noq);
                		var t_lcnoa = window.parent.document.getElementById('txtNoa').value;
                    	t_lcnoa = trim(t_lcnoa).replace('.', '');
                		wrServer(t_lcnoa);
                		break;
                	case 'recnobbs':
						refresh(q_recno);
						qbox=false;
						break;
                    case q_name:
                    	if (q_cur == 0 && qbox){
                    		t_where = "where=^^ noa='" + $('#txtNoa').val() + "' and noq='" + $('#txtNoq').val() + "'^^";
                        	q_gt('lcs', t_where, 0, 0, 0, "recnobbs", r_accy);
						}
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('lcs_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                if (q_readonly.indexOf('txtNoa') != -1) {
                    $('#txtNoa').val('AUTO');
                }
                
                if (window.parent.q_name == 'lc') {
                	$('#txtRate').val(window.parent.document.getElementById('txtRate').value);
                	$('#txtConrate1').val(window.parent.document.getElementById('txtConrate1').value);
                	$('#txtConrate2').val(window.parent.document.getElementById('txtConrate2').value);
                	$('#cmbCoin').val(window.parent.document.getElementById('cmbCoin').value);
                	$('#txtBankno').val(window.parent.document.getElementById('txtBankno').value);
                	$('#txtBank').val(window.parent.document.getElementById('txtBank').value);
                }

                $('#txtTggno').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;

                _btnModi();
                $('#txtTggno').focus();
            }

            function btnPrint() {
				
            }

            function btnOk() {
                var t_err = '';

                t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                sum();

                var t_noa = trim($('#txtNoa').val());
                if (t_noa.length == 0){
                	alert("請由正常方式進行新增修改資料!!");
                }else if (t_noa == 'AUTO') {
                    var t_lcnoa = window.parent.document.getElementById('txtNoa').value;
                    t_lcnoa = trim(t_lcnoa).replace('.', '');
                    
                    var t_where = "swhere=^^ noa='"+t_lcnoa+"' ^^ stop=1";
                 	q_gt('lcs', t_where, 0, 0, 0, "getnoq", r_accy);
                } else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbmKey[1], '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                
                if (window.parent.q_name == 'lc') {
                	$('#textAcc1').val(window.parent.document.getElementById('txtAcc1').value);
                }
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
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.lctchang':
                		q_gt(q_name, q_content, q_sqlCount, 1);
                	break;
                	case 'lc.genAccc.1':// 開狀
						$('#txtLcaccno').val(result);
						abbm[q_recno]['lcaccno'] = result;
						break;
					case 'lc.genAccc.2':// 付款
						var s2=result.split(';');
						$('#txtPayaccno').val(s2[0]);
						abbm[q_recno]['payaccno'] = s2[0];
						$('#txtPayno').val(s2[0]);
						abbm[q_recno]['payno'] = s2[0];
						break;
                	case 'lc.genAccc.3':// 改貸
						$('#txtChgaccno').val(result);
						abbm[q_recno]['chgaccno'] = result;
                		break;
                	case 'lc.genAccc.4':// 借款
						$('#txtAccno').val(result);
						abbm[q_recno]['accno'] = result;
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
                width: 10%;
            }
            .td4 {
                background-color: #FFEC8B;
                width: 10%;
                text-align: right;
            }
            .td5, .td6 {
                background-color: #FFEC8B;
                width: 10%
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

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left;  width:50%;" >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:3%"><a id='vewChk'> </a></td>
						<td align="center" style="width:15%"><a id='vewTgg'> </a></td>
						<td align="center" style="width:10%"><a id='vewXdatea'> </a></td>
						<td align="center" style="width:15%"><a id='vewMoney'> </a></td>
						<td align="center" style="width:10%"><a id='vewLcodate'> </a></td>
						<td align="center" style="width:15%"><a id='vewLcmoney'> </a></td>
						<td align="center" style="width:10%"><a id='vewLcdate'> </a></td>
						<td align="center" style="width:15%"><a id='vewUnpay'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='tgg,4'>~tgg,4</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='money,0,1'>~money,0,1</td>
						<td align="center" id='lcodate'>~lcodate</td>
						<td align="center" id='lcmoney,0,1'>~lcmoney,0,1</td>
						<td align="center" id='lcdate'>~lcdate</td>
						<td align="center" id='unpay,0,1'>~unpay,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 100%;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr class="tr1" style="display: none;">
						<td class="td1"><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td class="td2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td class="td3"><input id="txtNoq" type="text" class="txt c1"/></td>
						<td class="td4"> </td>
						<td class="td5"> </td>
						<td class="td6"> </td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblTgg" class="lbl btn" > </a></td>
						<td class="td2" colspan="2">
							<input id="txtTggno" type="text" class="txt c2"/>
							<input id="txtTgg" type="text" class="txt c3" />
						</td>
						<td class="td4"><span> </span><a id="lblBank" class="lbl btn"> </a></td>
						<td class="td5"><input id="txtBankno" type="text" class="txt c1" /></td>
						<td class="td6"><input id="txtBank" type="text" class="txt c1" /></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class="td4"><span> </span><a id="lblLch" class="lbl"> </a></td>
						<td class="td5"><input id="txtLch" type="text" class="txt num c1" /></td>
						<td class="td6"> </td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td class="td4"><span> </span><a id="lblLcaccno" class="lbl btn"> </a></td>
						<td class="td5"><input id="txtLcaccno" type="text" class="txt c1" /></td>
						<td class="td6"><input id="btnLch" type="button"/></td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id="lblPaydate" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtPaydate" type="text" class="txt c1"/></td>
						<td class="td4"> </td>
						<td class="td5"> </td>
						<td class="td6"> </td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id="lblLcno" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtLcno" type="text" class="txt c1"/></td>
						<td class="td4"><span> </span><a id="lblCno" class="lbl btn"> </a></td>
						<td class="td5"><input id="txtCno" type="text" class="txt c1" /></td>
						<td class="td6"><input id="txtAcomp" type="hidden" class="txt c1" /></td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id="lblLcodate" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtLcodate" type="text" class="txt c1"/></td>
						<td class="td4"><span> </span><a id="lblPaymonth" class="lbl"> </a></td>
						<td class="td5"><input id="txtPaymonth" type="text" class="txt c1" /></td>
						<td class="td6"><input id="btnPay" type="button"/></td>
					</tr>
					<tr class="tr8">
						<td class="td1"><span> </span><a id="lblLcmoney" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtLcmoney" type="text" class="txt num c1"/></td>
						<td class="td4"><span> </span><a id="lblPayno" class="lbl btn"> </a></td>
						<td class="td5"><input id="txtPayno" type="text" class="txt c1" /></td>
						<td class="td6"> </td>
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id="lblLcdate" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtLcdate" type="text" class="txt c1"/></td>
						<td class="td4"><span> </span><a id="lblPayaccno" class="lbl btn"> </a></td>
						<td class="td5"><input id="txtPayaccno" type="text" class="txt c1" /></td>
						<td class="td6"> </td>
					</tr>
					<tr class="tr10">
						<td class="td1"><span> </span><a id="lblRate" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtRate" type="text" class="txt num c1"/></td>
						<td class="td4"> </td>
						<td class="td5"> </td>
						<td class="td6"> </td>
					</tr>
					<tr class="tr11">
						<td class="td1"><span> </span><a id="lblConrate1" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtConrate1" type="text" class="txt num c1"/></td>
						<td class="td4"><span> </span><a id="lblChgdate" class="lbl"> </a></td>
						<td class="td5"><input id="txtChgdate" type="text" class="txt c1" /></td>
						<td class="td6"> </td>
					</tr>
					<tr class="tr12">
						<td class="td1"><span> </span><a id="lblConrate2" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtConrate2" type="text" class="txt num c1"/></td>
						<td class="td4"><span> </span><a id="lblChgacc1" class="lbl"> </a></td>
						<td class="td5"><input id="txtChgacc1" type="text" class="txt c1" /></td>
						<td class="td6"> </td>
					</tr>
					<tr class="tr13">
						<td class="td1"><span> </span><a id="lblCoin" class="lbl"> </a></td>
						<td class="td2" colspan="2"><select id="cmbCoin" class="txt c1"> </select></td>
						<td class="td4"><span> </span><a id="lblChgmoney" class="lbl"> </a></td>
						<td class="td5"><input id="txtChgmoney" type="text" class="txt num c1" /></td>
						<td class="td6"> </td>
					</tr>
					<tr class="tr14">
						<td class="td1"><span> </span><a id="lblFloat" class="lbl"> </a></td>
						<td class="td2" ><input id="txtFloat" type="text" class="txt num c1"/></td>
						<td align="center"><span> </span><a id="lblUseacc"> </a></td>
						<td class="td4"><span> </span><a id="lblChgfloat" class="lbl"> </a></td>
						<td class="td5"><input id="txtChgfloat" type="text" class="txt num c1" /></td>
						<td class="td6"><input id="btnChg" type="button"/> </td>
					</tr>
					<tr class="tr15">
						<td class="td1"><span> </span><a id="lblUnpay" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtUnpay" type="text" class="txt num c1"/></td>
						<td class="td4"><span> </span><a id="lblChgaccno" class="lbl btn"> </a></td>
						<td class="td5"><input id="txtChgaccno" type="text" class="txt c1" /></td>
						<td class="td6"> </td>
					</tr>
					<tr class="tr16">
						<td class="td1"><span> </span><a id="lblPay" class="lbl"> </a></td>
						<td class="td2" colspan="2"><input id="txtPay" type="text" class="txt num c1"/></td>
						<td class="td4"><span> </span><a id="lblAcc1" class="lbl"> </a></td>
						<td class="td5"><input id="textAcc1" type="text" class="txt c1" /></td>
						<td class="td6"> </td>
					</tr>
					<tr class="tr17">
						<td class="td1"><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td class="td2"><input id="txtAccno" type="text" class="txt c1" /></td>
						<td class="td3"><input id="btnLoan" type="button"/></td>
						<td class="td4"> </td>
						<td class="td5"><input id="btnLct" type="button"/></td>
						<td class="td6"> </td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
