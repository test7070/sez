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

            var q_name = "bankf2";
            var q_readonly = ['txtNoa','txtLcno2','txtAccno','txtAccno2','txtWorker','txtWorker2'];
            var bbmNum = [['txtMoney', 15, 3,1],['txtMoney2', 15, 3,1],['txtTax', 15, 3,1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtAcc1', 'lblAcc', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
							 ['txtBankno', 'lblBank', 'bank', 'noa,bank', 'txtBankno,txtBank', "bank_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
						);

            $(document).ready(function() {
                bbmKey = ['noa'];
                brwCount2 = 22;
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
                q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);          
            }

            function mainPost() {
            	bbmMask = [['txtDatea', r_picd],['txtDate2', r_picd],['txtDate3', r_picd],['txtLdate', r_picd]];
                q_mask(bbmMask);
                
                q_cmbParse("cmbType", ('').concat(new Array('', '一個月', '二個月', '三個月', '四個月', '五個月', '六個月', '七個月', '八個月', '九個月', '十個月', '十一個月')));
                q_cmbParse("cmbTypeyear", ('').concat(new Array('', '一年', '二年', '三年')));
                q_cmbParse("cmbPayitype", ('').concat(new Array('到期付息', '每月付息', '到期入本金')));
                q_cmbParse("cmbMoneytype", ('').concat(new Array('台幣', '美元', '日幣', '港幣', '人民幣', '歐元', '英鎊', '新加坡幣')));
                q_cmbParse("cmbRate", ('').concat(new Array('固定利率', '機動利率')));
                
                q_gt('acomp', '', 0, 0, 0, "");
                
				$('#txtAcc1').change(function() {
					var str=$.trim($(this).val());
                	if((/^[0-9]{4}$/g).test(str))
                		$(this).val(str+'.');
				});
				$('#txtBankno').change(function() {
					var str=$.trim($(this).val());
                	if((/^[0-9]{4}$/g).test(str))
                		$(this).val(str+'.');
				});
				
				$('#lblAccno').click(function() {
					q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + (!emp($('#txtDatea').val())?$('#txtDatea').val().substring(0, 3):r_accy) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('lblAccc'), true);
				});
				
				$('#lblAccno2').click(function() {
					q_pop('txtAccno2', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno2').val() + "';" + (!emp($('#txtDatea').val())?$('#txtDatea').val().substring(0, 3):r_accy) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('lblAccc'), true);
				});
				
				$("#cmbCno").change(function() {
                    var selectVal = $('#cmbCno').val();
                    if(compArr[selectVal]!=undefined)
                    	$('#txtNick').val(compArr[selectVal][0].nick);
                    else
                    	$('#txtNick').val('');
                });
                
                $("#txtMoney").change(function() {
                    var taxrate=dec(q_getPara('bankf.taxrate'));
                    $('#txtTax').val(q_mul(q_float('txtMoney'),q_div(taxrate,100)));
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
			
			var compArr = new Array();
            var z_cno = r_cno, z_acomp = r_comp, z_nick = r_comp.substr(0, 2);
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'cno_acomp':
						var as = _q_appendData("acomp", "", true);
						if (as[0] != undefined) {
							z_cno = as[0].noa;
							z_acomp = as[0].acomp;
							z_nick = as[0].nick;
						}
						break;
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        if (as[0] != undefined) {
                            var t_item = "@";
                            for (var  i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                                compArr[as[i].noa] = new Array();
                                compArr[as[i].noa].push({
                                	cno:as[i].noa,
                                	acomp:as[i].acomp,
                                	nick:as[i].nick
                                });
                            }
                            q_cmbParse("cmbCno", t_item);
                            if (abbm[q_recno] != undefined){
                                $("#cmbCno").val(abbm[q_recno].cno);
                                if(abbm[q_recno].cno!='')
                            		$('#txtNick').val(compArr[abbm[q_recno].cno].nick);
                            }
                        }
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
                q_box('bankf2_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }
            
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
                $('#txtLcno').focus();
                $('#cmbCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
            }
            
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtNoa').attr('disabled','disabled')
                $('#txtLcno').focus();
            }

            function btnPrint() {
            	q_box('z_bankf.aspx'+ "?;;;;"+r_accy+";", '', "90%", "650px", m_print);
            }

            function btnOk() {
            	$('#txtAcomp').val($('#cmbCno').find(":selected").text());
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else if (q_cur == 2) {
                    $('#txtWorker2').val(r_name);
                } else {
                    alert("error: btnok!");
                }
                
               	var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_bankf2')+ (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
                
                if (q_cur == 1 || q_cur == 2)
					q_func('qtxt.query.c0', 'bankf2.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(q_getPara('sys.key_bankf')) + ';0');
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
                //_btnDele();
                
                if (!confirm(mess_dele))
					return;
				q_cur = 3;
				q_func('qtxt.query.c2', 'bankf2.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(q_getPara('sys.key_bankf')) + ';0');
                
            }

            function btnCancel() {
                _btnCancel();
            }
            
            function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.c0':
						q_func('qtxt.query.c1', 'bankf2.txt,post,' + r_accy + ';' + encodeURI($('#txtNoa').val())+ ';' + encodeURI(q_getPara('sys.key_bankf')) + ';1');
						break;
					case 'qtxt.query.c1':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] != undefined) {
							abbm[q_recno]['lcno2'] = as[0].lcno2;
							$('#txtLcno2').val(as[0].lcno2);
						}
						break;
					case 'qtxt.query.c2':
						_btnOk($('#txtNoa').val(), bbmKey[0],'', '', 3)
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
                width: 380px; 
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
                width: 550px;
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
						<td align="center" style="width:120px; color:black;"><a id='vewLcno'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewType'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewBank'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='lcno' style="text-align: center;">~lcno</td>
						<td id='type' style="text-align: center;">~type</td>
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
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl"> </a></td>
						<td colspan="2"><select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp" type="text" style="display:none;"/>
							<input id="txtNick" type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblLcno' class="lbl"> </a></td>
						<td><input id="txtLcno"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypeyear" class="txt c1"> </select></td>
						<td><select id="cmbType" class="txt c1"> </select></td>
						<!--<td><input id="txtType" type="text" class="txt c1" /></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblBank' class="lbl btn"> </a></td>
						<td><input id="txtBankno" type="text" class="txt c1" /></td>
						<td><input id="txtBank" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAccount' class="lbl"> </a></td>
						<td colspan="2"><input id="txtAccount"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoneytype' class="lbl"> </a></td>
						<td><select id="cmbMoneytype"  class="txt c1" > </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblRate' class="lbl"> </a></td>
						<td><select id="cmbRate"  class="txt c1" > </select></td>
						<td><input id="txtInterestrate"  type="text" class="txt num c1" style="width: 80%;" />%</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPayitype' class="lbl"> </a></td>
						<td><select id="cmbPayitype" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax"  type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDate2' class="lbl"> </a></td>
						<td><input id="txtDate2" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcc' class="lbl btn"> </a></td>
						<td><input id="txtAcc1" type="text" class="txt c1" /></td>
						<td><input id="txtAcc2" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney2' class="lbl"> </a></td>
						<td><input id="txtMoney2" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDate3' class="lbl"> </a></td>
						<td><input id="txtDate3" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblLcno2' class="lbl"> </a></td>
						<td><input id="txtLcno2"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblLdate' class="lbl"> </a></td>
						<td><input id="txtLdate"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3" ><textarea id="txtMemo"  style="width:100%; height: 60px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblAccno2' class="lbl btn"> </a></td>
						<td><input id="txtAccno2" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
