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
		<script type="text/javascript">
            this.errorHandler = null;

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            q_desc = 1;
            var q_name = "vcc";
            var q_readonly = ['txtNoa', 'txtComp', 'txtAcomp', 'txtMoney', 'txtTotal','txtAccno','txtWorker'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney', 10, 0], ['txtTax', 10, 0], ['txtTotal', 10, 0]];
            var bbsNum = [['txtPrice', 12, 3], ['txtMount', 9, 2], ['txtTotal', 10, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 20;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'datea';
			brwCount2 = 20;
            q_xchg = 1;
            
            aPop = new Array(
             ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,tel,zip_invo,addr_invo,paytype', 'txtCustno,txtComp,txtNick,txtTel,txtZipcode,txtAddr,txtPaytype', 'cust_b.aspx']
            , ['txtSalesno2', 'lblSales2', 'sss', 'noa,namea', 'txtSalesno2,txtSales2', 'sss_b.aspx']
            , ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
            , ['txtAcc1_', 'btnAccno_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],'s');
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                brwCount2 = 11;
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
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
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('vcc.typea'));
                q_cmbParse("cmbStype", q_getPara('vcc.stype'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
                q_cmbParse("cmbTrantype", q_getPara('vcc.tran'));
                
                q_gt('acomp', '', 0, 0, 0, "");
                q_gt('part', '', 0, 0, 0, "");
				
				$("#cmbTypea").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
				$("#cmbStype").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
				$("#cmbTaxtype").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                }).change(function(e) {				
					sum();
				}).click(function(e) {			
					sum();
				});
				$("#cmbTrantype").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
				$("#cmbCno").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
				$("#cmbPartno").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
				$("#cmbPartno2").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
  				$("#combPaytype").change(function(e) {
					 $('#txtPaytype').val($('#combPaytype').find(":selected").text()); 
				});
				$("#txtTax").change(function(e) {				
					sum();
				});
              
                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "97%", "1054px", q_getMsg('btnAccc'), true);
                });
				$('#lblInvono').click(function() {
                    var t_where = "";
                    var tmp = $('#txtInvono').val().split(',');
                    for (var i in tmp)
                    t_where += (t_where.length > 0 ? ' or ' : '') + "noa='" + tmp[i] + "'";
                    q_pop('txtInvono', "vcca.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno, 'vcca', 'noa', 'datea', "92%", "950px", q_getMsg('popVcca'), true);
                });
            }

            function q_boxClose(s2) {
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
                	case 'part':
                        var as = _q_appendData("part", "", true);
                        if (as[0] != undefined) {
                            var t_item = "";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                            }
                            q_cmbParse("cmbPartno", t_item);
                            $("#cmbPartno").val(abbm[q_recno].partno);
                            q_cmbParse("cmbPartno2", t_item);
                            $("#cmbPartno2").val(abbm[q_recno].partno);
                        }
                        break;
                	case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        var t_item = " @ ";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_cmbParse("cmbCno", t_item);
                        $("#cmbCno").val(abbm[q_recno].cno);
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString;
                $('#txtAccno').val(xmlString);
            }
            function btnOk() {
            	if(!q_cd($('#txtDatea').val())){
            		alert(q_getMsg('lblDatea')+'錯誤。');
            		return;
            	}
            	if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val()))
                    alert(q_getMsg('lblMon')+'錯誤。');	
            	
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();
                $('#txtWorker').val(r_name);
                $('#txtAcomp').val($('#cmbCno').find(":selected").text());
                $('#txtPart').val($('#cmbPartno').find(":selected").text());
                $('#txtPart2').val($('#cmbPartno2').find(":selected").text());
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcctran') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;

                q_box('vcc_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
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
                $('#txtDatea').focus();
            }
            function btnPrint() {
            	q_box('z_vcctran.aspx'+ "?;;;;"+r_accy+";noa="+trim($('#txtNoa').val()), '', "90%", "650px", m_print);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsAssign() {
                for(var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_'+i).text(i+1);	
                	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                		$('#txtAcc1_' + i).change(function() {
                            var str=$.trim($(this).val());
		                	if((/^[0-9]{4}$/g).test(str))
		                		$(this).val(str+'.');
                        });
                        $('#txtMount_' + i).change(function() {
                            sum();
                        });
                        $('#txtPrice_' + i).change(function() {
                            sum();
                        });
                        $('#txtTotal_' + i).change(function() {
                            sum();
                        });
                    }
                }
                _bbsAssign();
            }

            function bbsSave(as) {
                if (parseFloat(as['total'])==0) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                if (t_err) {
                    alert(t_err)
                    return false;
                }
                return true;
            }

            function sum() {
            	if(!(q_cur==1 || q_cur==2))
					return;	
            	var t_money = 0, t_rate = 0, t_tax = 0, t_total = 0;
            	var t_moneys;
                for ( j = 0; j < q_bbsCount; j++) {
                	t_moneys = round(q_float('txtMount_'+j)*q_float('txtPrice_'+j),0)
                	$('#txtTotal_'+j).val(t_moneys);
                	t_money += t_moneys;
                }
                t_taxrate = parseFloat(q_getPara('sys.taxrate'))/100;
			    switch ($('#cmbTaxtype').val()) {
			        case '1':  // 應稅
			            t_tax = round(t_money * t_taxrate, 0);
			            t_total = t_money + t_tax;
			            break;
			        case '2': //零稅率
			        	t_tax = 0;
			        	t_total = t_money + t_tax;
			        	break;
			        case '3':  // 內含
			            t_tax = round(t_money / (1 + t_taxrate) * t_taxrate, 0);
			            t_total = t_money;
			            t_money = t_total - t_tax;
			            break;
			        case '4':  // 免稅
			            t_tax = 0;
			        	t_total = t_money + t_tax;
			            break;
			        case '5':  // 自定
			        	$('#txtTax').removeAttr('readonly');
						t_tax = round(q_float('txtTax'),0);
			        	t_total = t_money + t_tax;
			            break;
			        case '6':  // 作廢-清空資料
			            break;		
			        default:		
			    }
			    $('#txtMoney').val(t_money);
			    $('#txtTax').val(t_tax);
			    $('#txtTotal').val(t_total);
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
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 950px;
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
                width: 950px;
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
                width: 950px;
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
						<td align="center" style="width:60px; color:black;"><a id='vewType'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="typea=vcc.typea" style="text-align: center;">~typea=vcc.typea</td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="nick" style="text-align: center;">~nick</td>
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
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input type="text" id="txtNoa" class="txt c1"/>	</td>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input type="text" id="txtDatea" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input type="text" id="txtMon" class="txt c1"/></td>						
					</tr>
					<tr>
						<td><span> </span><a id="lblCno" class="lbl"> </a></td>
						<td colspan="3">
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp" type="text"  style="display:none;"/>
						</td>
						<td><span> </span><a id='lblInvono' class="lbl btn"> </a></td>
						<td><input type="text" id="txtInvono" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td colspan="3">
							<input type="text" id="txtCustno" style="float:left;width:30%;"/>
							<input type="text" id="txtComp" style="float:left;width:70%;"/>
							<input type="text" id="txtNick" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td><input id="txtPaytype" type="text" class="txt c1"/></td>
						<td><select id="combPaytype" style="float:left; width:20px;"> </select>
							<span> </span><a id='lblTrantype' class="lbl"> </a>
						</td>
						<td><select id="cmbTrantype" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td><input type="text" id="txtTel" class="txt c1"/>	</td>
						<td><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td colspan="5">
							<input type="text" id="txtZipcode" style="float:left;width:10%;"/>
							<input type="text" id="txtAddr" style="float:left;width:90%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPart" class="lbl btn"> </a></td>
						<td>
							<select id="cmbPartno" class="txt c1"> </select>
							<input id="txtPart"  type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id='lblSales' class="lbl btn"> </a></td>
						<td colspan="2">
							<input type="text" id="txtSalesno" style="float:left;width:40%;"/>
							<input type="text" id="txtSales" style="float:left;width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPart2" class="lbl btn"> </a></td>
						<td>
							<select id="cmbPartno2" class="txt c1"> </select>
							<input id="txtPart2"  type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id='lblSales2' class="lbl btn"> </a></td>
						<td colspan="2">
							<input type="text" id="txtSalesno2" style="float:left;width:40%;"/>
							<input type="text" id="txtSales2" style="float:left;width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblTaxrate" class="lbl"> </a></td>
						<td><select id="cmbTaxtype" class="txt c1"> </select></td>
						<td><span> </span><a id="lblTax" class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt c1 num"/>	</td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td><input type="text" id="txtAccno" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input type="text" id="txtWorker" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:150px;"><a id='lblAcc1_s'> </a></td>
					<td align="center" style="width:300px;"><a id='lblAcc2_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTotal_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="btnAccno.*" type="button" value=".." style="float:left;width:20px;"/>
						<input id="txtAcc1.*"type="text" style="float:left;width: 120px;"/>			
					</td>
					<td><input id="txtAcc2.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtMount.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td><input id="txtPrice.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td><input id="txtTotal.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td><input id="txtMemo.*" type="text" style="width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
