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
			
			q_copy=1;
            q_desc = 1;
            q_tables = 's';
            var q_name = "custprice";
            var q_readonly = ['txtNoa', 'txtDatea','txtWorker'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtOprice', 10, 2, 1],['txtPrice', 10, 2, 1],['txtDiscount', 10, 2, 1],['txtTaxrate', 5, 2, 1],['txtNotaxprice', 10, 2, 1]
            ,['txtCost', 10, 3, 1],['txtTranprice', 10, 3, 1],['txtCommission', 10, 2, 1],['txtProfit', 10, 2, 1],['txtInsurance', 10, 2, 1],['txtPrice2', 10, 3, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
            ['txtAgentno', 'lblAgentno', 'agent', 'noa,agent', 'txtAgentno,txtAgent', 'agent_b.aspx'],
            ['txtProductno_', 'btnProductno_', 'view_ucaucc', 'noa,product,unit,saleprice', 'txtProductno_,txtProduct_,txtUnit_,txtOprice_', 'ucaucc_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
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
                bbmMask = [['txtDatea', r_picd],['txtBdate', r_picd]];
                q_getFormat();
                q_mask(bbmMask);
                q_cmbParse("cmbPayterms", q_getPara('sys.payterms'),'s');
                
                $('#txtBdate').focusout(function() {
                    q_cd($(this).val(), $(this));
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
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();
                $('#txtWorker').val(r_name);
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_custprice') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('custprice_s.aspx', q_name + '_s', "500px", "320px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtBdate').val(q_date());
                $('#txtBdate').focus();
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtBdate').focus();
            }
            function btnPrint() {
                q_box('z_custprice.aspx', '', "95%", "650px", q_getMsg("popPrint"));
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
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtProductno_'+i).blur(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if((q_cur==1 || q_cur==2)&&!emp($('#txtProductno_'+b_seq).val())){
								if(emp($('#txtDiscount_'+b_seq).val()))
									$('#txtDiscount_'+b_seq).val(100);
								if(emp($('#txtTaxrate_'+b_seq).val()))
									$('#txtTaxrate_'+b_seq).val(5);
							}
						});
						$('#txtOprice_'+i).change(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtNotaxprice_'+b_seq,round(q_div(q_mul(dec($('#txtOprice_'+b_seq).val()),dec($('#txtDiscount_'+b_seq).val())),100),2));
							q_tr('txtPrice_'+b_seq,round(q_add(q_float('txtNotaxprice_'+b_seq),q_div(q_mul(q_float('txtNotaxprice_'+b_seq),q_float('txtTaxrate_'+b_seq)),100)),2));
						});
						$('#txtDiscount_'+i).change(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtNotaxprice_'+b_seq,round(q_div(q_mul(dec($('#txtOprice_'+b_seq).val()),dec($('#txtDiscount_'+b_seq).val())),100),2));
							q_tr('txtPrice_'+b_seq,round(q_add(q_float('txtNotaxprice_'+b_seq),q_div(q_mul(q_float('txtNotaxprice_'+b_seq),q_float('txtTaxrate_'+b_seq)),100)),2));
						});
						$('#txtNotaxprice_'+i).change(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtPrice_'+b_seq,round(q_add(q_float('txtNotaxprice_'+b_seq),q_div(q_mul(q_float('txtNotaxprice_'+b_seq),q_float('txtTaxrate_'+b_seq)),100)),2));
						});
						$('#txtTaxrate_'+i).change(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							q_tr('txtPrice_'+b_seq,round(q_add(q_float('txtNotaxprice_'+b_seq),q_div(q_mul(q_float('txtNotaxprice_'+b_seq),q_float('txtTaxrate_'+b_seq)),100)),2));
						});
						
						//isport
						$('#txtCost_'+i).change(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							paytermschange(b_seq);
						});
						
						$('#cmbPayterms_'+i).change(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							paytermschange(b_seq);
						});
						
						$('#txtCommission_'+i).change(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							paytermschange(b_seq);
						});
						
						$('#txtProfit_'+i).change(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							paytermschange(b_seq);
						});
						
						$('#txtInsurance_'+i).change(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							paytermschange(b_seq);
						});
						
						$('#txtTranprice_'+i).change(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							paytermschange(b_seq);
						});
                    }
                }
                
                _bbsAssign();
                
                if(q_getPara('sys.isport')=='1'){ //外銷
                	$('.isport').show();
                	$('.isnotport').hide();
                	$('#lblCustno').text('客戶');
                	$('.dbbs').css('width','2000px');
                	$('.dbbs .isport.td1').css('width','5%');
                	$('.dbbs .memo').css('width','6%');
                	$('.dbbs .pno').css('width','7%');
                	$('.dbbs .prod').css('width','12%');
                }
            }
            
            function paytermschange(n){
				var cost=dec($('#txtCost_'+n).val());
				var tranprice=dec($('#txtTranprice_'+n).val());
				var fee=0;
				var profit=dec($('#txtProfit_'+n).val());
				var insurance=dec($('#txtInsurance_'+n).val());
				var commission=dec($('#txtCommission_'+n).val());
				var payterms= $('#cmbPayterms_'+n).val();
				var price=0
				var precision=dec(q_getPara('vcc.pricePrecision'));
				switch (payterms) {//P利潤 I保險 C佣金 F運費
					case 'C＆F'://(成本/(1-P)+F) //=CFR   
						price=round(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),precision);
						break;
					case 'C＆F＆C'://(成本/(1-P)+F)/(1-C)
						price=round(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'C＆I': //成本/(1-P)/(1-I)
						price=round(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(insurance,100))),precision);
						break;
					case 'C＆I＆C'://成本/(1-P)/(1-I)/(1-C)
						price=round(q_div(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(insurance,100))),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'CIF'://(成本/(1-P)+F)/(1-I)   
						price=round(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(insurance,100))),precision);
						break;
					case 'CIF＆C'://(成本/(1-P)+F)/(1-I)/(1-C)
						price=round(q_div(q_div(q_add(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),tranprice),q_sub(1,q_div(insurance,100))),q_sub(1,q_div(commission,100))),precision);
						break;
					case 'EXW'://成本/(1-P)
						price=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),precision);
						break;
					case 'FOB'://成本/(1-P)
						price=round(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),precision);
						break;
					case 'FOB＆C': //成本/(1-P)/(1-C)
						price=round(q_div(q_div(q_add(cost,fee),q_sub(1,q_div(profit,100))),q_sub(1,q_div(commission,100))),precision);
						break;
				}
				$('#txtPrice2_'+n).val(price);
			}
            function bbsSave(as) {
                t_err = '';
                if (!as['productno'] && !as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['custno'] = abbm2['custno'];
                as['bdate'] = abbm2['bdate'];
                return true;
            }
            function sum() {
                var t1 = 0, t_unit, t_mount, t_income = 0, t_pay = 0;
                for (var j = 0; j < q_bbsCount; j++) {
                 
                }// j
            }
            function refresh(recno) {
                _refresh(recno);
                if(q_getPara('sys.isport')=='1'){ //外銷
                	$('.isport').show();
                	$('.isnotport').hide();
                	$('#lblCustno').text('客戶');
                }
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_getPara('sys.isport')=='1'){ //外銷
                	$('.isport').show();
                	$('.isnotport').hide();
                	$('#lblCustno').text('客戶');
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
                if (q_chkClose())
                    return;
                _btnDele();
            }
            function btnCancel() {
                _btnCancel();
            }
            
            function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						if(!emp($('#txtProductno_'+b_seq).val()) &&dec($('#txtCost_'+b_seq).val())==0){
							var t_where = "where=^^ noa='"+$('#txtProductno_'+b_seq).val()+"' ^^";
							q_gt('ucx', t_where, 0, 0, 0, "getucxcost", r_accy, 1);
							var as = _q_appendData("ucx", "", true);
							if (as[0] != undefined) {
								$('#txtCost_'+b_seq).val(as[0].cost);
							}
						}
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
                width: 355px;
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
                width: 500px;
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
                width: 36%;
                float: right;
            }
            .txt.c3 {
                width: 62%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 98%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
            }
            .txt.c7 {
                width: 95%;
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
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbm select {
                font-size: medium;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
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
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:40%"><a id='vewBdate'> </a></td>
						<td align="center" style="width:40%"><a id='vewCust'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='bdate'>~bdate</td>
						<td align="center" id='comp'>~comp</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr>
						<td class="td1" style="width: 30%"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2"  style="width: 50%"><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td class="td3"  style="width: 20%"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCustno' class="lbl btn"> </a></td>
						<td class="td2" colspan="2">
							<input id="txtCustno" type="text" class="txt c2"/>
							<input id="txtComp" type="text" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAgentno' class="lbl btn"> </a></td>
						<td class="td2" colspan="2">
							<input id="txtAgentno" type="text" class="txt c2"/>
							<input id="txtAgent" type="text" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblBdate' class="lbl"> </a></td>
						<td class="td2"><input id="txtBdate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td class="td2"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width: 2%;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:12%;" class="pno"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:18%;" class="prod"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:4%;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:10%;" class="isnotport"><a id='lblOprice_s'> </a></td>
					<td align="center" style="width:7%;" class="isnotport"><a id='lblDiscount_s'> </a></td>
					<td align="center" style="width:10%;" class="isnotport"><a id='lblNotaxprice_s'> </a></td>
					<td align="center" style="width:7%;" class="isnotport"><a id='lblTaxrate_s'> </a></td>
					<td align="center" style="width:10%;" class="isnotport"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:7%;display: none;" class="isport td1"><a id='lblCost_s'> </a></td>
					<td align="center" style="width:7%;display: none;" class="isport td1"><a id='lblTranprice_s'> </a></td>
					<td align="center" style="width:7%;display: none;" class="isport td1"><a id='lblPayterms_s'> </a></td>
					<td align="center" style="width:6%;display: none;" class="isport td1"><a id='lblCommission_s'> </a></td>
					<td align="center" style="width:6%;display: none;" class="isport td1"><a id='lblProfit_s'> </a></td>
					<td align="center" style="width:6%;display: none;" class="isport td1"><a id='lblInsurance_s'> </a></td>
					<td align="center" style="width:6%;display: none;" class="isport td1"><a id='lblPrice2_s'> </a></td>
					<td align="center" style="width:8%;" class="memo"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:7%;display: none;" class="isport"><a id='lblMemo1_s'> </a></td>
					<td align="center" style="width:7%;display: none;" class="isport"><a id='lblMemo2_s'> </a></td>
					<td align="center" style="width:7%;display: none;" class="isport"><a id='lblMemo3_s'> </a></td>
					<td align="center" style="width:7%;display: none;" class="isport"><a id='lblMemo4_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td>
						<input id="txtProductno.*" type="text" style="width: 80%;float:left;"/>
						<input id="btnProductno.*" type="button" style="width: 1%;float:left;font-size: medium; font-weight: bold;" value="."/>
					</td>
					<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td class="isnotport"><input id="txtOprice.*" type="text" class="txt num c1"/></td>
					<td class="isnotport"><input id="txtDiscount.*" type="text" class="txt num c1"/></td>
					<td class="isnotport"><input id="txtNotaxprice.*" type="text" class="txt num c1"/></td>
					<td class="isnotport"><input id="txtTaxrate.*" type="text" class="txt num c1"/></td>
					<td class="isnotport"><input id="txtPrice.*" type="text" class="txt num c1"/></td>
					<td class="isport" style="display: none;"><input id="txtCost.*" type="text" class="txt num c1"/></td>
					<td class="isport" style="display: none;"><input id="txtTranprice.*" type="text" class="txt num c1"/></td>
					<td class="isport" style="display: none;"><select id="cmbPayterms.*" class="txt c1" style="font-size: medium;"> </select></td>
					<td class="isport" style="display: none;"><input id="txtCommission.*" type="text" class="txt num c1"/></td>
					<td class="isport" style="display: none;"><input id="txtProfit.*" type="text" class="txt num c1"/></td>
					<td class="isport" style="display: none;"><input id="txtInsurance.*" type="text" class="txt num c1"/></td>
					<td class="isport" style="display: none;"><input id="txtPrice2.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMemo.*" type="text"   class="txt c1"/></td>
					<td class="isport" style="display: none;"><input id="txtMemo1.*" type="text" class="txt c1"/></td>
					<td class="isport" style="display: none;"><input id="txtMemo2.*" type="text" class="txt c1"/></td>
					<td class="isport" style="display: none;"><input id="txtMemo3.*" type="text" class="txt c1"/></td>
					<td class="isport" style="display: none;"><input id="txtMemo4.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>