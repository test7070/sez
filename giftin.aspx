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
            var q_name = "giftin";
            var q_readonly = ['txtNoa', 'txtWorker','txtMoney','txtTax','txtTotal'];
            var q_readonlys = ['txtTotal'];
            var bbmNum = [['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtDiscount', 10, 0, 1]];
            var bbsNum = [['txtMount', 10, 0, 1], ['txtMount2', 10, 0, 1], ['txtPrice', 15, 0, 1], ['txtDiscount', 15, 0, 1], ['txtMoney', 15, 0, 1], ['txtTotal', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 7;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
            , ['txtGiftno_', 'btnGiftno_', 'gift', 'noa,product,unit,price', 'txtGiftno_,txtGift_,txtUnit_,txtPrice_', 'gift_b.aspx']
            ,['txtBuyer', 'lblBuyer', 'sss', 'namea,noa', 'txtBuyer', 'sss_b.aspx']);
            
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
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtIndate', r_picd], ['txtMon', r_picm]];

                q_mask(bbmMask);
                q_gt('store', '', 0, 0, 0, "");
                q_gt('part', '', 0, 0, 0, "");
                q_gt('acomp', '', 0, 0, 0, "");
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));

                $('#txtInvono').change(function() {
                	$(this).val($.trim($(this).val().toUpperCase()));
                	if ($(this).val().length > 0 && !(/^[A-Z]{2}[0-9]{8}$/g).test($(this).val()))
                    	alert(q_getMsg('lblInvono')+'��~�C');
                });
                $('#cmbTaxtype').focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				}).change(function(e) {				
					sum();
				}).click(function(e) {			
					sum();
				});	
                $('#txtMoney').change(function() {
                	sum();
                });
                $('#txtTax').change(function() {
                	sum();
                });
                $('#txtDiscount').change(function() {
                	sum();
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
                	case 'acomp':
		                var as = _q_appendData("acomp", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "@";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
		                    }
							q_cmbParse("cmbCno", t_item);
							if(abbm[q_recno])
		                    	$("#cmbCno").val(abbm[q_recno].cno);
		                }
		                break;
                    case 'part':
		                var as = _q_appendData("part", "", true);
		                if (as[0] != undefined) {
		                    var t_item = " @ ";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
		                    }
							q_cmbParse("cmbPartno", t_item);
							if(abbm[q_recno])
		                    	$("#cmbPartno").val(abbm[q_recno].partno);
		                }
		                break;
                    case 'store':
		                var as = _q_appendData("store", "", true);
		                if (as[0] != undefined) {
		                    var t_item = "";
		                    for (i = 0; i < as.length; i++) {
		                        t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].store;
		                    }
		                    q_cmbParse("cmbStoreno", t_item);
		                    if(abbm[q_recno])
		                    	$("#cmbStoreno").val(abbm[q_recno].storeno);
		                }
		                break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
            	$('#txtAcomp').val($('#cmbCno').find(":selected").text());
            	$('#txtPart').val($('#cmbPartno').find(":selected").text());
                $('#txtMon').val($.trim($('#txtMon').val()));
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
                    alert(q_getMsg('lblMon') + '��~�C');
                    return;
                }
                if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '��~�C');
                    return;
                }
                sum();
                $('#txtWorker').val(r_name);
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
               	var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll('KG' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('giftin_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }
            function bbsAssign() {           
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')){
                    	$('#txtMount_' + j).change(function() {
                    		var n = $.trim($(this).attr('id').replace("txtMount_",''));
                    		$('#txtMount2_'+n).val($(this).val());
	                        sum();
	                    });
	                    $('#txtMount2_' + j).change(function() {
	                        sum();
	                    });
	                    $('#txtPrice_' + j).change(function() {
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
                $('#txtIndate').val(q_date());
                $('#txtMon').val(q_date().substr(0, 6));
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
                sum();
            }

            function btnPrint() {
                //q_box('z_bccin.aspx', '', "95%", "650px", q_getMsg("popPrint"));
                //q_box("z_bccin.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy + "_" + r_cno, 'bccin', "95%", "650px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['giftno'] && !as['gift']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['storeno'] = abbm2['storeno'];
                as['datea'] = abbm2['datea'];
                return true;
            }

            function sum() {
            	if(!(q_cur==1 || q_cur==2))
					return;		
				$('#txtMoney').attr('readonly',true);			
				$('#txtTax').attr('readonly',true);	
				$('#txtTotal').attr('readonly', true);
				$('#txtMoney').css('background-color','rgb(237,237,238)').css('color','green');
				$('#txtTax').css('background-color','rgb(237,237,238)').css('color','green');
				$('#txtTotal').css('background-color','rgb(237,237,238)').css('color','green');
				
                var t_mount, t_price = 0,t_money=0,t_total=0,t_tax,t_discount,t_taxrate;
                for (var j = 0; j < q_bbsCount; j++) {
                	t_mount = q_float('txtMount2_'+j);
                	t_price = q_float('txtPrice_'+j);
                	t_money = round(t_mount*t_price,0);
                	$('#txtTotal_'+j).val(t_money);
                	t_total+=t_money;
                }
                t_money = t_total;
                t_discount = q_float('txtDiscount');
                t_taxrate = parseFloat(q_getPara('sys.taxrate'))/100;
                switch ($('#cmbTaxtype').val()) {
			        case '1':  
			            t_tax = round(t_money * t_taxrate, 0);
			            t_total = t_money + t_tax - t_discount;
			            break;
			        case '2': 
			        	t_tax = 0;
			        	t_total = t_money + t_tax - t_discount;
			        	break;
			        case '3':  
			            t_tax = round(t_money / (1 + t_taxrate) * t_taxrate, 0);
			            t_total = t_money - t_discount;
			            t_money = t_total - t_tax;
			            break;
			        case '4':  
			            t_tax = 0;
			        	t_total = t_money + t_tax - t_discount;
			            break;
			        case '5':  
			        	$('#txtTax').attr('readonly',false);	
						$('#txtTax').css('background-color','white').css('color','black');
						t_tax = round(q_float('txtTax'),0);
			        	t_total = t_money + t_tax - t_discount;
			            break;
			        case '6': 
			        	t_money = 0,t_tax = 0, t_total = - t_discount;  
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
                width: 270px;
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
                width: 680px;
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
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"],select {
                font-size: medium;
            }
            .num {
                text-align: right;
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
						<td align="center" style="width:90px; color:black;"><a id='vewInvono'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTotal'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="invono" style="text-align: center;">~invono</td>
						<td id="total,0,1" style="text-align: right;">~total,0,1</td>
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
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblIndate' class="lbl"> </a></td>
						<td><input id="txtIndate"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td><input id="txtMon"  type="text" class="txt c1"/></td>						
						<td><span> </span><a id="lblPart" class="lbl"> </a></td>
						<td>
							<select id="cmbPartno" class="txt c1"> </select>
							<input id="txtPart" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblStore" class="lbl"> </a></td>
						<td>
							<select id="cmbStoreno" class="txt c1"> </select>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno"  type="text" style="float:left; width:30%;"/>
							<input id="txtTgg"  type="text" style="float:left; width:70%;"/>
						</td>
						<td><span> </span><a id='lblBuyer' class="lbl btn"> </a></td>
						<td><input id="txtBuyer"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblInvono' class="lbl"> </a></td>
						<td><input id="txtInvono"  type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblAcomp" class="lbl"> </a></td>
						<td colspan="2">
							<select id="cmbCno" class="txt c1"> </select>
							<input id="txtAcomp" type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblTaxtype' class="lbl"> </a></td>
						<td><select id="cmbTaxtype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDiscount' class="lbl"> </a></td>
						<td><input id="txtDiscount"  type="text"  class="txt num c1"/></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td><input id="txtTotal"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:1%;"> </td>
					<td align="center" style="width: 5%;"><a id='lblGiftno_s'> </a></td>
					<td align="center" style="width: 15%;"><a id='lblGift_s'> </a></td>
					<td align="center" style="width: 5%;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width: 5%;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width: 5%;"><a id='lblMount2_s'> </a></td>	
					<td align="center" style="width: 5%;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width: 5%;"><a id='lblTotals_s'> </a></td>
					<td align="center" style="width: 10%;"><a id='lblUno_s'> </a></td>
					<td align="center" style="width: 10%;"><a id='lblMemos_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					<input id="txtStoreno.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="btnGiftno.*" type="button" value="." style="float:left;width: 20%;"/>
						<input id="txtGiftno.*" type="text" style="float:left;width: 75%;" />
					</td>
					<td><input id="txtGift.*" type="text" style="width: 95%;" /></td>
					<td><input id="txtUnit.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtMount.*" type="text" style="width: 95%; text-align: right;"/></td>
					<td><input id="txtMount2.*" type="text" style="width: 95%; text-align: right;"/></td>
					<td><input id="txtPrice.*" type="text" style="width: 95%; text-align: right;"/></td>
					<td><input id="txtTotal.*" type="text" style="width: 95%; text-align: right;"/></td>
					<td><input id="txtUno.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtMemo.*"type="text" style="width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
