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
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "lcu";
            var q_readonly = ['txtNoa','txtWorker'];
            var bbmNum = [['txtMoney',10,0,1],['txtFloata',10,2,1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 15;
             
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'],
            ['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx'],
            ['txtBankno', 'lblBank', 'bank', 'noa,bank', 'txtBankno,txtBank', 'bank_b.aspx'],
            ['txtIssuingbankno', 'lblIssuingbank', 'bank', 'noa,bank', 'txtIssuingbankno,txtIssuingbank', 'bank_b.aspx'],
            ['txtAdvisingbankno', 'lblAdvisingbank', 'bank', 'noa,bank', 'txtAdvisingbankno,txtAdvisingbank', 'bank_b.aspx'],
            ['txtNegotiatingbankno', 'lblNegotiatingbank', 'bank', 'noa,bank', 'txtNegotiatingbankno,txtNegotiatingbank', 'bank_b.aspx']);
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
                q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
            	bbmMask = [['txtDatea', r_picd],['txtVdate',r_picd],['txtEdate',r_picd],['txtCdate',r_picd],['txtIssuedate', r_picd],['txtReceivedate', r_picd],['txtOnboarddate', r_picd],['txtNegotiatingdate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('lcu.typea'));
                //q_cmbParse("cmbCoin", q_getPara('sys.coin'));
                $('#cmbTypea').focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				});
				$('#btnIssuing').click(function(){
					$('#ChangeIssuing').toggle();
				});
				$('#btnCloseissuing').click(function(){
				$('#ChangeIssuing').toggle();
				});
                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "1054px", q_getMsg('btnAccc'), true);
                });
                $('#lblAccno2').click(function() {
                    q_pop('txtAccno2', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno2').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "1054px", q_getMsg('btnAccc'), true);
                });
                $('#btnLcv').click(function() {
					q_box("lcv.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";", 'lcv', "95%", "95%", q_getMsg('popLcv'));
				});
				
				$('#txtLcno').change(function() {
					t_where="where=^^ lcno='"+$('#txtLcno').val()+"'^^";
                	q_gt('lcu', t_where, 0, 0, 0, "check_Lcno", r_accy);
				});
				
				 $('#lblOrdeno').click(function () { 
				 	if(emp($('#txtOrdeno').val()))
				 		q_pop('txtOrdeno', "orde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";custno='"+$('#txtCustno').val()+"';" + r_accy + '_' + r_cno, 'orde', 'noa', '', "92%", "1024px", q_getMsg('lblOrdeno'), true);
				 	else
	            		q_pop('txtOrdeno', "orde.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex(noa,'"+$('#txtOrdeno').val()+"')>0;" + r_accy + '_' + r_cno, 'orde', 'noa', '', "92%", "1024px", q_getMsg('lblOrdeno'), true); 
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
                	case 'flors_coin':
						var as = _q_appendData("flors", "", true);
						var z_coin='';
						for ( i = 0; i < as.length; i++) {
							z_coin+=','+as[i].coin;
						}
						if(z_coin.length==0) z_coin=' ';
						
						q_cmbParse("cmbCoin", z_coin);
						if(abbm[q_recno])
							$('#cmbCoin').val(abbm[q_recno].coin);
						break;
					case 'flors':
						var as = _q_appendData("flors", "", true);
						if (as[0] != undefined) {
							q_tr('txtFloata',as[0].floata);
						}
						break;
                	case 'check_Lcno':
                		var as = _q_appendData("lcu", "", true);
                        if (as[0] != undefined){
                        	alert(q_getMsg('lblLcno')+'已存在!!');
                        }
                		break;
                	case 'check_btnOk':
                		var as = _q_appendData("lcu", "", true);
                        if (as[0] != undefined){
                        	alert(q_getMsg('lblLcno')+'已存在!!')
                        }else{
                        	q_gtnoa(q_name, replaceAll(q_getPara('sys.key_lcu') + $('#txtDatea').val(), '/', ''));
                        }
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                        break;
                }  
            }
            
            function coin_chg() {
				var t_where = "where=^^ ('" + $('#txtDatea').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
				q_gt('flors', t_where, 0, 0, 0, "");
			}

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('lcu_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#chkEnds').prop('checked',false);
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
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
				q_box('z_lcu.aspx', '', "95%", "650px", q_getMsg("popPrint"));
            }

            function btnOk() {
            	 var t_err = '';
	            t_err = q_chkEmpField([['txtLcno', q_getMsg('lblLcno')],['txtDatea', q_getMsg('lblDatea')],['txtEdate', q_getMsg('lblEdate')]]);
	            
	            if( t_err.length > 0) {
	                alert(t_err);
	                return;
	            }
            	
            	if (!q_cd($('#txtDatea').val())){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
                }
            	if ($('#txtVdate').val().length>0 && !q_cd($('#txtVdate').val())){
                	alert(q_getMsg('lblVdate')+'錯誤。');
                	return;
                }
                if ($('#txtEdate').val().length>0 && !q_cd($('#txtEdate').val())){
                	alert(q_getMsg('lblEdate')+'錯誤。');
                	return;
                }
                if ($('#txtCdate').val().length>0 && !q_cd($('#txtCdate').val())){
                	alert(q_getMsg('lblCdate')+'錯誤。');
                	return;
                } 
                var t_noa = trim($('#txtNoa').val());
				if (t_noa.length == 0 || t_noa == "AUTO"){
					t_where="where=^^ lcno='"+$('#txtLcno').val()+"'^^";
                	q_gt('lcu', t_where, 0, 0, 0, "check_btnOk", r_accy);
                }else{
                	$('#txtWorker').val(r_name);
                    wrServer(t_noa);
                }
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
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
                width: 35%;
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
                width: 60%;
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
                width: 30%;
                float: left;
            }
            .txt.c3 {
                width: 68%;
                float: left;
            }
            .txt.c4 {
                width: 49%;
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
						<td align="center" style="width:20%; color:black;"><a id='vewNick'> </a></td>
						<td align="center" style="width:15%; color:black;"><a id='vewEdate'> </a></td>
						<td align="center" style="color:black;"><a id='vewLcno'> </a></td>
						<td align="center" style="width:20%; color:black;"><a id='vewMoney'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='edate' style="text-align: center;">~edate</td>
						<td id='lcno' style="text-align: left;">~lcno</td>
						<td id="money,0" style="text-align:right;">~money,0</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>					
						<td><span> </span><a id="lblLcno" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtLcno" type="text" class="txt c1"/>
							<input id="txtNoa" type="hidden"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td>
							<input id="txtCno" type="text" style="float:left; width:20%;"/>
							<input id="txtAcomp" type="text" style="float:left; width:80%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td>
							<input id="txtCustno" type="text" style="float:left; width:20%;"/>
							<input id="txtComp" type="text" style="float:left; width:80%;"/>
							<input id="txtNick" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblUmmno" class="lbl"> </a></td>
						<td><input id="txtUmmno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
		                <td>
		                	<select id="cmbCoin" class="txt c4" onchange='coin_chg()'> </select>
		                	<input id="txtFloata" type="text" class="txt num c4"/>
		                </td>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBank" class="lbl btn"> </a></td>
						<td colspan="3"><input id="txtBankno" type="text" class="txt c2"/>
							<input id="txtBank" type="text" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblVdate" class="lbl"> </a></td>
						<td><input id="txtVdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblEdate" class="lbl"> </a></td>
						<td><input id="txtEdate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text" class="txt c1"/></td>
						<td><input id="chkEnds" type="checkbox" class="lbl txt"/><a id="lblEnds" class="lbl txt"> </a></td>
						<td><input id="btnLcv" type="button" class="txt "/> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCdate" class="lbl"> </a></td>
						<td><input id="txtCdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblAccno2" class="lbl btn"> </a></td>
						<td><input id="txtAccno2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdeno" class="lbl btn"> </a></td>
						<td ><input id="txtOrdeno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblExportno" class="lbl"> </a></td>
						<td ><input id="txtExportno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblIssuingbank" class="lbl btn"> </a></td>
						<td >
							<input id="txtIssuingbankno" type="text" class="txt c2"/>
							<input id="txtIssuingbank" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id="lblIssuedate" class="lbl"> </a></td>
						<td><input id="txtIssuedate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAdvisingbank" class="lbl btn"> </a></td>
						<td >
							<input id="txtAdvisingbankno" type="text" class="txt c2"/>
							<input id="txtAdvisingbank" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id="lblOnboarddate" class="lbl"> </a></td>
						<td><input id="txtOnboarddate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNegotiatingbank" class="lbl btn"> </a></td>
						<td >
							<input id="txtNegotiatingbankno" type="text" class="txt c2"/>
							<input id="txtNegotiatingbank" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id="lblNegotiatingdate" class="lbl"> </a></td>
						<td><input id="txtNegotiatingdate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl btn"> </a></td>
						<td ><input id="txtMemo" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
