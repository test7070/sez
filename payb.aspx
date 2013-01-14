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

            q_desc = 1
            q_tables = 's';
            var q_name = "payb";
            var q_readonly = ['txtNoa', 'txtMoney', 'txtTax', 'txtTotal', 'txtUnpay', 'txtPayed', 'txtWorker'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtUnpay', 10, 0, 1], ['txtPayed', 10, 0, 1]];
            var bbsNum = [['txtPrice', 10, 0, 1], ['txtDiscount', 10, 0, 1], ['txtMount', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            //ajaxPath = "";
            aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtProductno_', 'btnchgitem_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            , ['txtPartno_', 'btnpart_', 'part', 'noa,part', 'txtPartno_,txtPart_', 'part_b.aspx']
            , ['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtComp,txtNick', 'tgg_b.aspx']
            , ['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx']
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
                q_cmbParse("cmbTypea", q_getPara('payb.typea'), 's');
                //.........................
                //........................單據匯入
                $('#btnFix').click(function() {
                    if (!emp($('#txtTggno').val())) {
                        var t_where = "where=^^ tggno='" + $('#txtTggno').val() + "' and datea between '" + $('#txtMon').val() + "/01' and '" + $('#txtMon').val() + "/31' ^^";
                        //var t_where1 = "where[1]=^^ tggno='"+$('#txtTggno').val()+"' and datea between '"+$('#txtMon').val()+"/01' and '"+$('#txtMon').val()+"/31' ^^";
                        q_gt('payb_fix', t_where, 0, 0, 0, "", r_accy);
                    }

                });
                //.........................
                $('#txtVedate').change(function() {
                    if (!emp($('#txtVedate').val()))
                        $('#txtMon').val($('#txtVedate').val().substr(0, 6));
                });

                //........................會計傳票
                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
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
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'payb_fix':
                        var as = _q_appendData("fixin", "", true);

                        //判斷是否是匯入的資料
                        for (var j = 0; j < q_bbsCount; j++) {
                            if (($('#txtMemo_' + j).val()).substr(0, 1) == '.') {
                                btnMinus("btnMinus_" + j);
                            }
                        }
                        q_gridAddRow(bbsHtm, 'tbbs', 'txtRc2no,cmbKind,cmbTypea,txtInvono,txtTax,txtDiscount,txtMoney,txtTotal,txtPartno,txtPart,txtMemo,txtAcc1,txtAcc2', as.length, as, 'noa,kind,typea,invono,tax,discount,money,total,partno,part,memo,acc1,acc2', 'txtProductno');
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
            	if($.trim($('#txtNick').val()).length==0)
            		$('#txtNick').val($('#txtComp').val());
                $('#txtWorker').val(r_name);
				$('#txtAcomp').val($('#cmbCno').find(":selected").text());
                $('#txtPart').val($('#cmbPartno').find(":selected").text());
                
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if (s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('A' + $('#txtDatea').val(), '/', ''));
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
                    $('#txtAcc1_' + j).change(function() {
                        t_IdSeq = -1;
                        /// 要先給  才能使用 q_bodyId()
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        if ($('#txtAcc1_' + b_seq).val().length == 4) {
                            $('#txtAcc1_' + b_seq).val($('#txtAcc1_' + b_seq).val() + '.');
                        }
                    });
                    //----------------數量和單價計算
                    $('#txtMount_' + j).change(function() {
                        t_IdSeq = -1;
                        /// 要先給  才能使用 q_bodyId()
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        $('#txtMoney_' + b_seq).val(dec($('#txtMount_' + b_seq).val()) * dec($('#txtPrice_' + b_seq).val()));
                        $('#txtTotal_' + b_seq).val(dec($('#txtMoney_' + b_seq).val()) + dec($('#txtTax_' + b_seq).val()) - dec($('#txtDiscount_' + b_seq).val()));

                        /*if($('#txtPrice_'+b_seq).val()=='0' &&$('#txtMount_'+b_seq).val()=='0')
                         $('#txtMoney_'+b_seq).removeAttr('disabled');
                         else
                         $('#txtMoney_'+b_seq).attr('disabled', 'disabled');
                         */
                        sum();
                    });

                    $('#txtPrice_' + j).change(function() {
                        t_IdSeq = -1;
                        /// 要先給  才能使用 q_bodyId()
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        $('#txtMoney_' + b_seq).val(dec($('#txtMount_' + b_seq).val()) * dec($('#txtPrice_' + b_seq).val()));
                        $('#txtTotal_' + b_seq).val(dec($('#txtMoney_' + b_seq).val()) + dec($('#txtTax_' + b_seq).val()) - dec($('#txtDiscount_' + b_seq).val()));
                        /*
                         if($('#txtPrice_'+b_seq).val()=='0' &&$('#txtMount_'+b_seq).val()=='0')
                         $('#txtMoney_'+b_seq).removeAttr('disabled');
                         else
                         $('#txtMoney_'+b_seq).attr('disabled', 'disabled');
                         */
                        sum();
                    });
                    //-----------------

                    //----------------產品小計、折讓與營業稅變動重新計算合計
                    $('#txtMoney_' + j).change(function() {
                        t_IdSeq = -1;
                        /// 要先給  才能使用 q_bodyId()
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        q_tr('txtTotal_' + b_seq, q_float('txtMoney_' + b_seq) + q_float('txtTax_' + b_seq) - q_float('txtDiscount_' + b_seq));

                        sum();
                    });
                    $('#txtTax_' + j).change(function() {
                        t_IdSeq = -1;
                        /// 要先給  才能使用 q_bodyId()
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        q_tr('txtTotal_' + b_seq, q_float('txtMoney_' + b_seq) + q_float('txtTax_' + b_seq) - q_float('txtDiscount_' + b_seq));

                        sum();
                    });
                    $('#txtDiscount_' + j).change(function() {
                        t_IdSeq = -1;
                        /// 要先給  才能使用 q_bodyId()
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        q_tr('txtTotal_' + b_seq, q_float('txtMoney_' + b_seq) + q_float('txtTax_' + b_seq) - q_float('txtDiscount_' + b_seq));

                        sum();
                    });
                    //----------------
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

                if (emp(as['invono']) && emp(as['rc2no'])) {
                    as[bbsKey[1]] = '';
                    return;
                }

                if (!as['total'] && !as['money'] && !as['memo']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                /*if(!as['invono']) {
                 as[bbsKey[1]] = '';
                 return;
                 }*/

                q_nowf();
                as['date'] = abbm2['date'];
                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                var t_tax = 0, t_money = 0, t_discount = 0, t_total = 0;
                for (var j = 0; j < q_bbsCount; j++) {

                    t_tax += q_float('txtTax_' + j);
                    //稅合計

                    if ($('#cmbKind_0').val() == '預付')
                        t_money -= q_float('txtMoney_' + j);
                    //產品小計合計
                    else
                        t_money += q_float('txtMoney_' + j);
                    //產品小計合計

                    t_discount += q_float('txtDiscount_' + j);
                    //折讓合計
                    t_total += q_float('txtTotal_' + j);

                }// j
                q_tr('txtTax', t_tax);
                q_tr('txtMoney', t_money - t_discount);

                if (t_money == 0 && t_tax == 0)
                    q_tr('txtTotal', t_total - t_discount);
                else
                    q_tr('txtTotal', t_money - t_discount + t_tax);

                q_tr('txtUnpay', q_float('txtTotal') - q_float('txtPayed'));
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
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString;
                $('#txtAccno').val(xmlString);
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
            input[type="text"], input[type="button"], select{
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
						<td align="center" style="width:80px; color:black;"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="datea" style="text-align: center;">~datea</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"   type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon"  type="text"  class="txt c1" />	</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl btn" > </a></td>
						<td colspan="3">
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp" type="text"  style="display:none;"/>
						</td>
						<td><span> </span><a id='lblVccno' class="lbl"> </a></td>
						<td><input id="txtVccno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg"  class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtTggno" type="text" style="float:left; width:30%;"/>
							<input id="txtComp"  type="text" style="float:left; width:70%;"/>
							<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td><input type="button" id="btnFix"  value="單據匯入"></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1"/></td>	
					</tr>
					<tr>
						<td><span> </span><a id='lblPayc' class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtPayc" type="text" style="float:left; width:50%;"/>
							<input id="txtPaydate" type="text" style="float:left; width:50%;"/>
						</td>
						<td><span> </span><a id='lblVdate'class="lbl" > </a></td>
						<td><input id="txtVbdate" type="text"  class="txt c1"/></td>
						<td><input id="txtVedate" type="text"  class="txt c1"/></td>					
					</tr>
					<tr>
						<td><span> </span><a id="lblPart" class="lbl btn" > </a></td>
						<td>
							<select id="cmbPartno" class="txt c1"> </select>
							<input id="txtPart"  type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblSales2" class="lbl btn" > </a></td>
						<td>
							<input id="txtSalesno2" type="text" style="float:left; width:50%;"/>
							<input id="txtSales2" type="text" style="float:left; width:50%;"/>
						</td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text"  class="txt num c1" /></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPayed' class="lbl"> </a></td>
						<td class="td7" ><input id="txtPayed" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblUnpay" class="lbl"> </a></td>
						<td><input id="txtUnpay"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblPic' class="lbl"> </a></td>
						<td><input id="txtPic"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="4" >
							<textarea id="txtMemo" cols="10" rows="5" style="width: 99%; height:50px;"> </textarea></td>
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
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" class="td2">#<a id='lblRc2no'></a></td>
					<td align="center" style="width: 5%;">#<a id='lblKind'></a></td>
					<td align="center" style="width: 4%;">#<a id='lblType'></a></td>
					<td align="center" style="width: 8%;">#<a id='lblInvonos'></a>/<a id='lblTaxs'></a></td>
					<!--<td align="center" class="td1"><a id='lblParts'></a></td>-->
					<td align="center" style="width: 5%;"><a id='lblMount'></a></td>
					<td align="center" style="width: 7%;"><a id='lblPrice'></a></td>
					<td align="center"  style="width: 7%;" class="td2">*<a id='lblMoneys'></a></td>
					<td align="center"  style="width: 7%;"class="td1">*<a id='lblTotals'></a></td>
					<td align="center" style="width: 12%;"><a id='lblProduct'></a></td>
					<td align="center" style="width: 15%;">*<a id='lblMemos'></a></td>
					<td align="center" style="width: 10%;"><a id='lblBal'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:1%;">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					</td>
					<td>
					<input id="txtRc2no.*" type="text"  class="txt c1"/>
					</td>
					<td><select id="cmbKind.*" ></select></td><!--<input id="txtKind.*" type="text"class="txt c1"/>-->
					<td><select id="cmbTypea.*" ></select></td><!--<input id="txtTypea.*" type="text"  class="txt c1"/>-->
					<td>
					<input id="txtInvono.*" type="text" class="txt c1"/>
					<input id="txtTax.*" type="text" class="txt num c1" />
					</td>
					<!--<td><input class="btn"  id="btnpart.*" type="button" value='.' style=" float: left;font-weight: bold;width:1%;" />
					<input id="txtPartno.*" type="text" style="width:21%;"/>
					<input id="txtPart.*" type="text" style="width:50%;"/></td>-->
					<td>
					<input id="txtMount.*" type="text" class="txt num c1" />
					</td>
					<td>
					<input id="txtPrice.*" type="text" class="txt num c1" />
					<input id="txtDiscount.*" type="text" class="txt num c1" />
					</td>
					<td>
					<input id="txtMoney.*" type="text" class="txt num c1"/>
					</td>
					<td>
					<input id="txtTotal.*" type="text"  class="txt num c1" />
					</td>
					<td>
					<input class="btn"  id="btnchgitem.*" type="button" value='.' style="float: left;font-weight: bold;width:1%;" />
					<input id="txtProductno.*" type="text" style=" width: 80%;"/>
					<br>
					<input id="txtProduct.*" type="text" style=" width: 98%;"/>
					</td>
					<td >
					<input id="txtMemo.*" type="text" class="txt c1"/>
					</br>
					<input class="btn"  id="btnAcc.*" type="button" value='.' style="float: left; font-weight: bold;width:1%;" />
					<input type="text" id="txtAcc1.*"  style="width:35%;"/>
					<input type="text" id="txtAcc2.*"  style="width:40%;"/>
					<input type="hidden" id="txtNoq.*"  style="width:45%;"/>
					</td>
					<td>
					<input id="txtBal.*" type="text"  class="txt c1" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

