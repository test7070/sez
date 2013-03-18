﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
            var q_name = "payb";
            var q_readonly = ['txtVccno','txtAccno','txtNoa', 'txtMoney', 'txtTax', 'txtDiscount', 'txtTotal', 'txtWorker','txtUnpay','txtPayed','txtWorker2'];
            var q_readonlys = ['txtTotal','txtMoney'];
            var bbmNum = [['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtDiscount', 10, 0, 1], ['txtUnpay', 10, 0, 1], ['txtPayed', 10, 0, 1]];
            var bbsNum = [['txtPrice', 10, 0, 1], ['txtDiscount', 10, 0, 1], ['txtMount', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            q_desc = 1;
            //ajaxPath = "";
            aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtComp,txtNick', 'tgg_b.aspx']
            , ['txtSalesno2', 'lblSales2', 'sss', 'noa,namea', 'txtSalesno2,txtSales2', 'sss_b.aspx']);
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

            }///  end Main()

            function pop(form) {
                b_pop = form;
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm], ['txtVbdate', r_picd], ['txtVedate', r_picd], ['txtPaydate', r_picd]];
                q_mask(bbmMask);
                q_gt('acomp', '', 0, 0, 0, "");
                q_gt('part', '', 0, 0, 0, "");
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
                //........................下拉選單
                q_cmbParse("cmbKind", q_getPara('payb.kind'), 's');
                //.........................
                //........................單據匯入
                $('#btnFix').click(function() {
                    var t_noa = $.trim($('#txtNoa').val());
					var t_tggno = $.trim($('#txtTggno').val());
					var t_mon = $.trim($('#txtMon').val());				
					if(t_tggno.length>0 && t_mon.length>0){
						var t_where = "where=^^ (a.[money]!=0 or a.tax!=0 or a.discount!=0) and ((b.noa is null) or (b.noa is not null and b.noa='"+t_noa+"'))" 
                    	+ " and a.tggno='"+t_tggno+"' and a.mon='"+t_mon+"' ^^";
                    	var t_where1 = " where[1]=^^ (a.plusmoney!=0) and ((b.noa is null) or (b.noa is not null and b.noa='"+t_noa+"')) and a.tggno='"+t_tggno+"' ^^"
                    	q_gt('payb_fix', t_where+t_where1, 0, 0, 0, "", r_accy);
					}else{
						alert('請輸入'+q_getMsg('lblMon')+'、'+q_getMsg('lblTgg'));						
					}
                });
                //.........................
                $('#txtVedate').change(function() {
                    if (!emp($('#txtVedate').val()))
                        $('#txtMon').val($('#txtVedate').val().substr(0, 6));
                });

                //........................會計傳票
                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "97%", "1054px", q_getMsg('btnAccc'), true);
                });
                //.........................
                $('#btnTgg').click(function() {
                    q_box('Tgg.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtTggno').val()), '', "95%", "600px", "廠商主檔");
                });
                $('#btnUcc').click(function() {
                    q_box('ucc.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "600px", "電子檔製作");

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
                    case 'payb_fix':
                        var as = _q_appendData("payb_fix", "", true);
                        if (as[0] != undefined) {
                        	var n = 0;
                        	var t_partno = $('#cmbPartno').val();
                        	for(var i in as){
                        		if(as[i].partno == t_partno)
                        			n++;
                        	}
                        	while(n>q_bbsCount){
                        		$('#btnPlus').click();
                        	}
                        	//reset
	                        for (var j = 0; j < q_bbsCount; j++) {
	                            $('#txtRc2no_'+j).val('');
	                            $('#cmbKind_'+j).val('');
	                            $('#txtInvono_'+j).val('');
	                            $('#txtTax_'+j).val(0);
	                            $('#txtMount_'+j).val(0);
	                            $('#txtPrice_'+j).val(0);
	                            $('#txtDiscount_'+j).val(0);
	                            $('#txtMoney_'+j).val(0);
	                            $('#txtTotal_'+j).val(0);
	                            $('#txtMemo_'+j).val('');
	                            $('#txtAcc1_'+j).val('');
	                            $('#txtAcc2_'+j).val('');
	                            $('#txtBal_'+j).val('');
	                        }
	                        //insert
	                        var n = 0;
	                        for(var i in as){
	                        	if(as[i].partno == t_partno){
	                        		if(as[i].wmoney!=0 && as[i].cmoney!=0){
	                        			//維修&輪胎
	                        			$('#txtRc2no_'+n).val(as[i].noa);
			                            $('#cmbKind_'+n).val('維修');
			                            $('#txtInvono_'+n).val(as[i].invono);
			                            $('#txtTax_'+n).val(as[i].tax); 
			                            $('#txtMount_'+n).val(1);
			                            $('#txtPrice_'+n).val(as[i].wmoney);
			                            $('#txtDiscount_'+n).val(as[i].discount);
			                            $('#txtMoney_'+n).val(as[i].wmoney);
			                            $('#txtTotal_'+n).val(as[i].wmoney);
			                            $('#txtMemo_'+n).val(as[i].memo);
			                            $('#txtAcc1_'+n).val(as[i].wacc1);
			                            $('#txtAcc2_'+n).val(as[i].wacc2);
			                            $('#txtBal_'+n).val('');
			                            n++;
			                            //----------------------
			                            $('#txtRc2no_'+n).val(as[i].noa);
			                            $('#cmbKind_'+n).val('費用');
			                            $('#txtInvono_'+n).val('');
			                            $('#txtTax_'+n).val(0); 
			                            $('#txtMount_'+n).val(1);
			                            $('#txtPrice_'+n).val(as[i].cmoney);
			                            $('#txtDiscount_'+n).val(0);
			                            $('#txtMoney_'+n).val(as[i].cmoney);
			                            $('#txtTotal_'+n).val(as[i].cmoney);
			                            $('#txtMemo_'+n).val(as[i].memo);
			                            $('#txtAcc1_'+n).val(as[i].cacc1);
			                            $('#txtAcc2_'+n).val(as[i].cacc2);
			                            $('#txtBal_'+n).val('');
	                        		}else if(as[i].wmoney!=0){
	                        			//維修
	                        			$('#txtRc2no_'+n).val(as[i].noa);
			                            $('#cmbKind_'+n).val('維修');
			                            $('#txtInvono_'+n).val(as[i].invono);
			                            $('#txtTax_'+n).val(as[i].tax); 
			                            $('#txtMount_'+n).val(1);
			                            $('#txtPrice_'+n).val(as[i].wmoney);
			                            $('#txtDiscount_'+n).val(as[i].discount);
			                            $('#txtMoney_'+n).val(as[i].wmoney);
			                            $('#txtTotal_'+n).val(as[i].wmoney);
			                            $('#txtMemo_'+n).val(as[i].memo);
			                            $('#txtAcc1_'+n).val(as[i].wacc1);
			                            $('#txtAcc2_'+n).val(as[i].wacc2);
			                            $('#txtBal_'+n).val('');
	                        		}else if(as[i].cmoney!=0){
	                        			//輪胎
	                        			$('#txtRc2no_'+n).val(as[i].noa);
			                            $('#cmbKind_'+n).val('費用');
			                            $('#txtInvono_'+n).val(as[i].invono);
			                            $('#txtTax_'+n).val(as[i].tax); 
			                            $('#txtMount_'+n).val(1);
			                            $('#txtPrice_'+n).val(as[i].cmoney);
			                            $('#txtDiscount_'+n).val(as[i].discount);
			                            $('#txtMoney_'+n).val(as[i].cmoney);
			                            $('#txtTotal_'+n).val(as[i].cmoney);
			                            $('#txtMemo_'+n).val(as[i].memo);
			                            $('#txtAcc1_'+n).val(as[i].cacc1);
			                            $('#txtAcc2_'+n).val(as[i].cacc2);
			                            $('#txtBal_'+n).val('');
	                        		}else{
	                        			$('#txtRc2no_'+n).val(as[i].noa);
			                            $('#cmbKind_'+n).val('費用');
			                            $('#txtInvono_'+n).val(as[i].invono);
			                            $('#txtTax_'+n).val(as[i].tax); 
			                            $('#txtMount_'+n).val(1);
			                            $('#txtPrice_'+n).val(as[i].money);
			                            $('#txtDiscount_'+n).val(as[i].discount);
			                            $('#txtMoney_'+n).val(as[i].money);
			                            $('#txtTotal_'+n).val(as[i].money);
			                            $('#txtMemo_'+n).val(as[i].memo);
			                            $('#txtAcc1_'+n).val(as[i].acc1);
			                            $('#txtAcc2_'+n).val(as[i].acc2);
			                            $('#txtBal_'+n).val('');
	                        		}
	                        		n++;
	                        	}
	                        }
                        }
                        sum();
                        break;
                    case 'part':
                        var as = _q_appendData("part", "", true);
                        if (as[0] != undefined) {
                            var t_item = "";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                            }
                            q_cmbParse("cmbPartno", t_item);
                            if (abbm[q_recno] != undefined) {
                                $("#cmbPartno").val(abbm[q_recno].partno);
                            }
                        }
                        break;
                    case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        if (as[0] != undefined) {
                            var t_item = " @ ";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                            }
                            q_cmbParse("cmbCno", t_item);
                            if (abbm[q_recno] != undefined) {
                                $("#cmbCno").val(abbm[q_recno].cno);
                            }
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                        if (q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                        break;
                }  /// end switch
            }

            function btnOk() {
                if ($.trim($('#txtNick').val()).length == 0)
                    $('#txtNick').val($('#txtComp').val());
                
                $('#txtAcomp').val($('#cmbCno').find(":selected").text());
                $('#txtPart').val($('#cmbPartno').find(":selected").text());

                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();
                
                var yufu=false;
                for (var j = 0; j < q_bbsCount; j++) {
                	if($('#cmbKind_'+j).val()!=null){
	                	if($('#cmbKind_'+j).val().indexOf('預付')>-1){
	                		yufu=true;
	                		break;
	                	}
                	}
                }
                if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }
                if(yufu &&$('#txtPayc').val().indexOf('預付')==-1)
                	$('#txtPayc').val($('#txtPayc').val()+' 預付');
				
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_payb') + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('payb_s.aspx', q_name + '_s', "550px", "450px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                	$('#lblNo_'+j).text(j+1);	
                	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                		$('#txtAcc1_' + j).change(function(e) {
		                    if($(this).val().length==4 && $(this).val().indexOf('.')==-1){
		                    	$(this).val($(this).val()+'.');	
		                    }else if($(this).val().length>4 && $(this).val().indexOf('.')==-1){
		                    	$(this).val($(this).val().substring(0,4)+'.'+$(this).val().substring(4));	
		                    }
                		});
                		$('#txtMount_' + j).change(function(e) {
	                        sum();
	                    });
	                    $('#txtPrice_' + j).change(function(e) {
	                        sum();
	                    });
                		$('#txtMoney_' + j).change(function(e) {
	                        sum();
	                    });
	                    $('#txtTax_' + j).change(function(e) {
	                        sum();
	                    });
	                    $('#txtDiscount_' + j).change(function(e) {
	                        sum();
	                    });
                	}
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtMon').val(q_date().substr(0, 6));
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                sum();
                $('#txtProductno').focus();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
               // if (!as['rc2no'] && !as['invono'] && !as['total'] && !as['money'] && !as['memo']) {
                if (as['money'] ==0 && as['tax'] ==0 && as['acc1'] =='') {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['date'] = abbm2['date'];
                return true;
            }

            function sum() {
            	var t_money,t_total,t_tax,t_discount;
            	var tot_money=0,tot_tax=0,tot_discount=0,tot_total=0;
            	for (var j = 0; j < q_bbsCount; j++) {
            		t_money = round(q_float('txtMount_'+j) * q_float('txtPrice_'+j),0);
            		t_total = t_money + q_float('txtTax_'+j) - q_float('txtDiscount_'+j);        		
            		$('#txtMoney_'+j).val(t_money);
            		$('#txtTotal_'+j).val(t_total);
            		tot_money+=t_money;
            		tot_tax+=q_float('txtTax_'+j);
            		tot_discount+=q_float('txtDiscount_'+j);
            		tot_total+=t_total;
            	}
                $('#txtMoney').val(tot_money);
            	$('#txtTax').val(tot_tax);
            	$('#txtDiscount').val(tot_discount);
            	$('#txtTotal').val(tot_total);
            }

            function refresh(recno) {
                _refresh(recno);

            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);

                if (t_para) {
                    $('#btnFix').attr('disabled', 'disabled');
                } else {
                    $('#btnFix').removeAttr('disabled');
                }

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
            	if($('#txtPayed').val() == 0){
                	_btnDele();
            	}
            }

            function btnCancel() {
                _btnCancel();
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString.split(";")[0];
                abbm[q_recno]['payed'] = xmlString.split(";")[1];
                abbm[q_recno]['unpay'] = xmlString.split(";")[2];
                //$('#txtAccno').val(xmlString.split(";")[0]);
                //$('#txtPayed').val(xmlString.split(";")[1]);
                //$('#txtUnpay').val(xmlString.split(";")[2]);
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 390px;
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
                width: 560px;
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
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs input[type="text"] {
                width: 95%;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"], select {
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
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:150px; color:black;"><a id='vewComp'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewTotal'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewUnpay'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" />
						</td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="nick" style="text-align: center;">~nick</td>
						<td id="total,0,1" style="text-align: right;">~total,0,1</td>
						<td id="unpay,0,1" style="text-align: right;">~unpay,0,1</td>
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
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa"   type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblAcomp" class="lbl btn" > </a></td>
						<td>
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp" type="text"  style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon"  type="text"  class="txt c1" /></td>			
						
					</tr>
					<tr>
						<td><span> </span><a id="lblPart" class="lbl btn" > </a></td>
						<td>
							<select id="cmbPartno" class="txt c1"> </select>
							<input id="txtPart"  type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblSales2" class="lbl btn" > </a></td>
						<td colspan="2">
							<input id="txtSalesno2" type="text" style="float:left; width:50%;"/>
							<input id="txtSales2" type="text" style="float:left; width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg"  class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtTggno" type="text" style="float:left; width:20%;"/>
						<input id="txtComp"  type="text" style="float:left; width:80%;"/>
						<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td>
						<input type="button" id="btnFix"  value="單據匯入">
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPayc' class="lbl"></a></td>
						<td colspan="2">
							<input id="txtPayc" type="text" style="float:left; width:50%;"/>
							<input id="txtPaydate" type="text" style="float:left; width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblVdate'class="lbl" > </a></td>
						<td>
						<input id="txtVbdate" type="text"  class="txt c1"/>
						</td>
						<td>
						<input id="txtVedate" type="text"  class="txt c1"/>
						</td>
					</tr>						
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text"  class="txt num c1" /></td>
						
					</tr>
					<tr>
						<td><span> </span><a id='lblDiscount' class="lbl"> </a></td>
						<td><input id="txtDiscount" type="text"  class="txt num c1" /></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPayed' class="lbl"> </a></td>
						<td><input id="txtPayed" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblUnpay' class="lbl"> </a></td>
						<td><input id="txtUnpay" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblVccno' class="lbl"> </a></td>
						<td><input id="txtVccno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1"/></td>
						
					</tr>
					<tr>
						<td><span> </span><a id='lblPic' class="lbl"> </a></td>
						<td><input id="txtPic"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3" ><textarea id="txtMemo" cols="10" rows="5" style="width: 99%; height:50px;"> </textarea></td>
						<td class="td8">
						<input id="btnTgg" type="button"/>
						<input id="btnUcc" type="button"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:120px;">#<a id='lblRc2no'> </a></td>
					<td align="center" style="width:60px;">#<a id='lblKind'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMount'> </a></td>
					<td align="center" style="width:80px;">*<a id='lblMoneys'> </a></td>
					<td align="center" style="width:120px;">#<a id='lblInvonos'> </a>/<a id='lblTaxs'> </a></td>
					<td align="center" style="width:80px;">*<a id='lblTotals'> </a></td>
					<td align="center" style="width:150px;">*<a id='lblMemos'> </a></td>
					<td align="center" style="width:120px;"><a id='lblBal'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td>
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*"  style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtRc2no.*" type="text"  style="width: 95%;"/></td>
					<td><select id="cmbKind.*" style="width: 95%;"> </select></td>	
					<td>
						<input id="txtMount.*" type="text" style="text-align: right; width: 95%;" />
						<input id="txtPrice.*" type="text" style="text-align: right; width: 95%;" />
					</td>
					<td>
						<input id="txtMoney.*" type="text" style="text-align: right; width: 95%;"/>
						<input id="txtDiscount.*" type="text" style="text-align: right; width: 95%;" />
					</td>
					<td>
						<input id="txtInvono.*" type="text" style="width: 95%;"/>
						<input id="txtTax.*" type="text" style="text-align: right; width: 95%;" />
					</td>
					<td><input id="txtTotal.*" type="text" style="text-align: right; width: 95%;" /></td>
					<td>
						<input id="txtMemo.*" type="text" style=" width: 95%;"/>	
						<input class="btn"  id="btnAcc.*" type="button" value='.' style="float: left; font-weight: bold;width:1%;" />
						<input type="text" id="txtAcc1.*"  style="float: left;width:40%;"/>
						<input type="text" id="txtAcc2.*"  style="float: left;width:40%;"/>
					</td>
					<td><input id="txtBal.*" type="text" style="width: 95%;" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

