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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			q_desc = 1;
            q_tables = 's';
            var q_name = "ordb";
            var q_readonly = ['txtTgg', 'txtAcomp','txtSales','txtNoa','txtWorker','txtWorker2', 'txtMoney', 'txtTotal', 'txtTotalus', 'txtTax','txtPart'];
            var q_readonlys = ['txtNo3','txtTotal','txtC1','txtNotv','txtOrdeno','txtNo2'];
            var bbmNum = [['txtFloata', 10, 5, 1],['txtMoney', 10, 0, 1],['txtTax', 10, 0, 1],['txtTotal', 10, 0, 1],['txtTotalus', 10, 0, 1]];
            var bbsNum = [['txtMount', 10, 0, 1],['txtPrice', 10, 3, 1],['txtWeight', 10, 3, 1],['txtTotal', 10, 0, 1]];
            var bbmMask = [['txtOdate', '999/99/99']];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Odate';
            aPop = new Array(['txtProductno_', 'btnProduct_', 'bcc', 'noa,product,unit,price', '0txtProductno_,txtProduct_,txtUnit_,txtPrice_,txtMount_', 'bcc_b.aspx']
					,['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
					,['txtCno','lblAcomp','acomp','noa,nick','txtCno,txtAcomp','acomp_b.aspx']
					,['txtTggno','lblTgg','tgg','noa,nick,paytype','txtTggno,txtTgg,txtPaytype','tgg_b.aspx']
					,['txtPartno','lblPart','part','noa,part','txtPartno,txtPart','part_b.aspx']
			);
					
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'no3'];
                q_brwCount();
               q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtOdate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbKind", q_getPara('ordb.kind')); 
                q_cmbParse("cmbCoin", q_getPara('sys.coin'));      
                q_cmbParse("combPaytype", q_getPara('vcc.paytype'));  
                q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
                q_cmbParse("cmbApv",'N,Y');
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                $('#btnOrde').click(function() {
                     q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";", 'ordes', "95%", "95%", q_getMsg('popOrde'));
                });
                
                $('#cmbPaytype').change(function () {
	            	$('#txtPay').val($('#cmbPaytype').find("option:selected").text());
			     });
			     
			     $('#txtTax').change(function () {
	            	sum();
			     });
			     
			     $('#txtFloata').change(function () {
	            	sum();
			     });
			     
			     $('#btnTggx').click(function() {
                    q_box('tgg.aspx' + "?;;;;" + r_accy , '', "95%", "600px", "廠商主檔");
                });
                $('#btnBccx').click(function() {
                    q_box('bcc.aspx' + "?;;;;" + r_accy, '', "95%", "600px", "資材主檔");

                });
            }

            function q_boxClose(s2) {///   q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
					case 'ordes':
	                    if (q_cur > 0 && q_cur < 4) {
	                        b_ret = getb_ret();
	                        if (!b_ret || b_ret.length == 0)
	                            return;
	                        var i, j = 0;
	                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtPrice,txtOrdeno,txtNo2,txtWeight', b_ret.length, b_ret
	                                                           , 'productno,product,unit,mount,price,noa,no2,weight'
	                                                           , 'txtOrdeno,txtNo2');   /// 最後 aEmpField 不可以有【數字欄位】
	                        sum();
	                    }
						break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'find_ordc':
                		ordc_modi = _q_appendData("view_ordcs", "", true);
                		find_ordc=true;
                		btnModi();
                		break;
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
            	//103/09/01應請購匯入會依採購人匯入所以必須要填
            	if(q_getPara('sys.comp').indexOf('大昌')>-1){
            		t_err = q_chkEmpField([['txtSalesno', q_getMsg('lblSales')],['txtPartno', q_getMsg('lblPart')]]);
                
	                if(t_err.length > 0) {
	                    alert(t_err);
	                    return;
	                }
            	}
            	
	            $('#txtDatea').val($.trim($('#txtDatea').val()));
	                if (checkId($('#txtDatea').val())==0){
	                	alert(q_getMsg('lblDatea')+'錯誤。');
	                	return;
	            }
	           	sum();
	           	
	           	//1030419 當專案沒有勾 BBM的取消和結案被打勾BBS也要寫入
				if(!$('#chkIsproj').prop('checked')){
					for (var j = 0; j < q_bbsCount; j++) {
						if($('#chkEnda').prop('checked'))
							$('#chkEnda_'+j).prop('checked','true');
					}
				}
	           	
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
				if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
                
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('B' + $('#txtOdate').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('ordb_s.aspx', q_name + '_s', "500px", "480px", q_getMsg("popSeek"));
            }

            function combPaytype_chg() {
                var cmb = document.getElementById("combPaytype")
                if (!q_cur)
                    cmb.value = '';
                else
                    $('#txtPaytype').val(cmb.value);
                cmb.value = '';
            }

            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
            		  if (!$('#btnMinus_' + j).hasClass('isAssign')) {
            		  		$('#txtMount_' + j).change(function () {
								sum();
				            });
				            
				            $('#txtPrice_' + j).change(function () {
				                sum();
				            });
            		  }
            	}
                _bbsAssign();
            }
            
            function q_popPost(s1) {
		    	switch (s1) {
			       
		    	}
			}

            function btnIns() {
                _btnIns();
                $('#chkIsproj').attr('checked', true);
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtOdate').val(q_date());
                $('#txtDatea').val(q_cdn(q_date(),30));
                $('#txtOdate').focus();
            }
			
			var find_ordc=false,ordc_modi;//設定有採購就不能修改請購
            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
				//大昌一開始不會設品號
				if(q_getPara('sys.comp').indexOf('大昌')==-1){
					if(!find_ordc){
						var t_where = "where=^^ ordbno='"+$('#txtNoa').val()+"' ^^";
						q_gt('view_ordcs', t_where, 0, 0, 0, "find_ordc", r_accy);
						return;
					}
				}
                _btnModi();
                if(q_getPara('sys.comp').indexOf('大昌')==-1){
	                find_ordc=false;
	                if (ordc_modi[0] != undefined) {
	                	for (var i = 0; i < ordc_modi.length; i++) {
	                		for (var j = 0; j < q_bbsCount; j++) {
	                			if(ordc_modi[i].no3==$('#txtNo3_'+j).val()){
	                				for (var k = 0; k < fbbs.length; k++) {
	                					$('#'+fbbs[k]+'_'+j).attr('disabled', 'disabled');
	                				}
	                			}
	                		}
	                	}
	                }
				}
                $('#txtCno').focus();
            }

            function btnPrint() {
				q_box('z_ordbp.aspx?;;;;'+ r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['productno'] && !as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                as['datea'] = abbm2['datea'];
				as['kind'] = abbm2['kind'];
				as['apv'] = abbm2['apv'];
                as['tggno'] = abbm2['tggno'];
                as['odate'] = abbm2['odate'];
                return true;
            }

            function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
				$('#txtMoney').attr('readonly', true);
				$('#txtTax').attr('readonly', true);
				$('#txtTotal').attr('readonly', true);
				$('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
				$('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');

				var t_mount = 0, t_price = 0, t_money = 0, t_weight = 0, t_total = 0, t_tax = 0;
				var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;
				var t_float = q_float('txtFloata');

				for (var j = 0; j < q_bbsCount; j++) {
					t_prices = q_float('txtPrice_' + j);
					t_mounts = q_float('txtMount_' + j);
					t_moneys = round(q_mul(t_prices, t_mounts), 0);

					t_mount = q_add(t_mount, t_mounts);
					t_money = q_add(t_money, t_moneys);

					$('#txtTotal_' + j).val(q_trv(t_moneys, 0, 1));
				}
				t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
				switch ($('#cmbTaxtype').val()) {
					case '1':
						// 應稅
						t_tax = round(q_mul(t_money, t_taxrate), 0);
						t_total = q_add(t_money, t_tax);
						break;
					case '2':
						//零稅率
						t_tax = 0;
						t_total = q_add(t_money, t_tax);
						break;
					case '3':
						// 內含
						t_tax = round(q_mul(q_div(t_money, q_add(1, t_taxrate)), t_taxrate), 0);
						t_total = t_money;
						t_money = q_sub(t_total, t_tax);
						break;
					case '4':
						// 免稅
						t_tax = 0;
						t_total = q_add(t_money, t_tax);
						break;
					case '5':
						// 自定
						$('#txtTax').attr('readonly', false);
						$('#txtTax').css('background-color', 'white').css('color', 'black');
						t_tax = round(q_float('txtTax'), 0);
						t_total = q_add(t_money, t_tax);
						break;
					case '6':
						// 作廢-清空資料
						t_money = 0, t_tax = 0, t_total = 0;
						break;
					default:
				}

				$('#txtMoney').val(q_trv(t_money, 0, 1));
				$('#txtTax').val(q_trv(t_tax, 0, 1));
				$('#txtTotal').val(q_trv(t_total, 0, 1));
				$('#txtTotalus').val(q_trv(round(q_mul(q_float('txtTotal'), q_float('txtFloata')), 2), 0, 1));
			}

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_cur==1 || q_cur==2){
					if(r_modi)
						$('#cmbApv').removeAttr('disabled');
					else
						$('#cmbApv').attr('disabled', 'disabled');
				}
                
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if(q_tables == 's')
                    bbsAssign();
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
			function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVXYWZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//錯誤
            }
            
	</script>
    <style type="text/css">
         #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 28%;
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
                width: 70%;
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
                width: 39%;
                float: left;
            }
            .txt.c3 {
                width: 59%;
                float: left;
            }
            .txt.c4 {
                width: 20%;
                float: left;
            }
            .txt.c5 {
                width: 78%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
                
            }
            .txt.c7 {
                width: 95%;
                float: left;
            }
            .txt.c8 {
                width: 47%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .txt.lef {
             float: left;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .tbbm td input[type="button"] {
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

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
    </style>
</head>
<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
<!--#include file="../inc/toolbar.inc"--> 
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:25%"><a id='vewDatea'> </a></td>
                <td align="center" style="width:25%"><a id='vewNoa'> </a></td>
                <td align="center" style="width:40%"><a id='vewTgg'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='odate'>~odate</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='tggno tgg,4'>~tggno ~tgg,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' >
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr class="tr1">
               <td class="td1"><span> </span><a id='lblKind' class="lbl"> </a></td>
               <td class="td2"><select id="cmbKind" class="txt c1 lef"> </select></td>
               <td> </td>
               <td class="td3"><span> </span><a id='lblOdate' class="lbl"> </a></td>
               <td class="td4"><input id="txtOdate" type="text" class="txt c1 lef"/></td>
               <td> </td>
               <td class="td5"><span> </span><a id='lblDatea' class="lbl"> </a></td>
               <td class="td6"><input id="txtDatea" type="text" class="txt c1 lef"/></td>
            </tr>
            <tr class="tr2">
               <td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
               <td class="td2" colspan="2"><input id="txtCno"  type="text" class="txt c4 lef"/>
               <input id="txtAcomp"    type="text" class="txt c5 lef"/></td>
               <td class="td4"><span> </span><a id='lblPart' class="lbl btn"> </a></td>
               <td class="td5" colspan="2">
					<input id="txtPartno"  type="text" class="txt c2 lef"/>
					<input id="txtPart"    type="text" class="txt c3 lef"/>
               	</td>
               <td class="td7"><span> </span><a id='lblNoa' class="lbl"> </a></td>
               <td class="td8"><input id="txtNoa"   type="text"  class="txt c1 lef"/></td>   
            </tr>
           <tr class="tr3">
                <td class="td1"><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
                <td class="td2" colspan="2"><input id="txtTggno" type="text" class="txt c2 lef"/>
                <input id="txtTgg"  type="text" class="txt c3 lef"/></td>
                <td class="td4"><span> </span><a id='lblPaytype' class="lbl"> </a></td>
                <td class="td5"  colspan='2'>
                	<input id="txtPaytype" type="text" class="txt c8 lef"/>
					<select id="combPaytype" class="txt c8 lef" onchange='combPaytype_chg()'> </select>
				</td>
                <td class="td7"><span> </span><a id='lblTrantype' class="lbl "> </a></td>
                <td class="td8"><select id="cmbTrantype" class="txt c1 lef" name="D1" > </select></td> 
            </tr>
            <tr class="tr4">
                <td class="td1"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
                <td class="td2" colspan="2"><input id="txtSalesno" type="text" class="txt c2 lef"/> 
                <input id="txtSales" type="text" class="txt c3 lef"/></td> 
                <td class="td4"><span> </span><a id='lblTel' class="lbl"> </a></td>
                <td class="td5" colspan='2'><input id="txtTel"  type="text"  class="txt c1 lef"/></td>
                <td class="td7"><span> </span><a id='lblFax' class="lbl"> </a></td>
                <td class="td8"><input id="txtFax" type="text" class="txt c1 lef"/></td>
            </tr>
            <tr class="tr5">
                <td class="td1"><span> </span><a id='lblAddr' class="lbl"> </a></td>
                <td class="td2"><input id="txtPost"  type="text"  class="txt c1 lef"/></td>
                <td class="td3" colspan='4' ><input id="txtAddr"  type="text" class="txt c1 lef"/></td>
                <td class="td4"><span> </span><a id='lblContract' class="lbl"> </a></td>
				<td class="td5"><input id="txtContract"  type="text" class="txt c1 lef"/></td>
                <!--<td class="td8"><input id="btnOrde" type="button" /></td>--> 
            </tr>
            <tr class="tr6">
                <td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
                <td class="td2" colspan="2"><input id="txtMoney" type="text" class="txt num c1 lef" /></td>
                <td class="td3"><span> </span><a id='lblTax' class="lbl"> </a></td>
                <td class="td4"><input id="txtTax"  type="text" class="txt num c1 lef" /></td>
                <td class="td5"><select id="cmbTaxtype" class="txt c1 lef" onchange="sum()" > </select></td>
                <td class="td6"><span> </span><a id='lblTotal' class="lbl"> </a></td>
                <td class="td7"><input id="txtTotal" type="text" class="txt num c1 lef" /></td>
            </tr>
            <tr class="tr7">
            	<td class="td1"><span> </span><a id='lblTotalus' class="lbl"> </a></td>
                <td class="td2" colspan="2"><input id="txtTotalus"  type="text" class="txt num c1 lef" /></td> 
                <!--<td class="td4"><span> </span><a id='lblWeight' class="lbl"></a></td>
                <td class="td5" colspan='2'><input id="txtWeight"  type="text" class="txt num c1" /></td>-->
                <td class="td4"><span> </span><a id='lblFloata' class="lbl"> </a></td>
                <td class="td5"><select id="cmbCoin" class="txt c1 lef"> </select></td>                 
                <td class="td6"><input id="txtFloata"  type="text"  class="txt num c1 lef" /></td>
                <td class="td7" align="right">
                	<input id="chkIsproj" type="checkbox"/>
                	<a id='lblIsproj' style="width: 50%;"> </a>
				</td>
                <td class="td8" align="right">
                	<input id="chkEnda" type="checkbox"/>
                	<a id='lblEnd' style="width: 40%;"> </a><span> </span>
                </td>
            </tr>
            <tr class="tr8">
                <td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
                <td class="td2"><input id="txtWorker"  type="text" class="txt c1 lef" /></td> 
                <td> </td>
                <td class="td3"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
                <td class="td4"><input id="txtWorker2"  type="text" class="txt c1 lef" /></td>
                <td> </td>
                <td class="td7"><span> </span><a id="lblApv" class="lbl"> </a></td>
                <td class="td8">
                	<!--<input id="txtApv" type="text" maxlength='1' class="txt c1 lef" disabled="disabled"/>-->
                	<select id="cmbApv" class="txt c1 lef" name="D1" > </select>
                </td> 
            </tr>
            
            <tr class="tr9">
                <td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
                <td class="td2" colspan='5'><textarea id="txtMemo" rows="5" cols="10" style="width: 99%; height: 50px;"> </textarea></td>
                <td align="center"><input id="btnTggx" type="button" value="廠商主檔" style="float: center;"/></td>
				<td align="center"><input id="btnBccx" type="button" value="資材主檔" style="float: center;"/></td>
            </tr>
        </table>
        </div>
		</div>
        <div class='dbbs' >
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:13%;"><a id='lblProductno'> </a></td>
                <td align="center" style="width:20%;"><a id='lblProduct_st'> </a></td>
                <!--<td align="center"><a id='lblSize'></a></td>-->
                <td align="center" style="width:5%;"><a id='lblUnit'> </a></td>
                <td align="center" style="width:8%;"><a id='lblMount'> </a></td>
                <!--<td align="center"><a id='lblWeights'></a></td>-->
                <td align="center" style="width:8%;"><a id='lblPrices'> </a></td>
                <td align="center" style="width:10%;"><a id='lblTotals'> </a></td>
                <td align="center" style="width:10%;"><a id='lblGemounts'> </a></td>
                <td align="center" style="width:19%;"><a id='lblMemos'> </a></td>
                <td align="center" style="width:50px;"><a id='lblEndas'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
              	<td>
              			<input class="txt c1"  id="txtProductno.*" type="text" />
                        <input class="txt c3" id="txtNo3.*" type="text" />
                        <input class="btn"  id="btnProduct.*" type="button" value='.' style=" font-weight: bold;" />
				</td>
                <td><input class="txt c1" id="txtProduct.*" type="text" /></td>
                <td><input class="txt c1" id="txtUnit.*" type="text" /></td>
                <td>
                	<input class="txt num c1" id="txtMount.*" type="text" />
                	<!--<input class="txt num c1" id="txtWeight.*" type="text" />-->
                </td>
                <td><input class="txt num c1" id="txtPrice.*" type="text" /></td>
                <td><input class="txt num c1" id="txtTotal.*" type="text" /></td>
                <td>
                	<input class="txt num c1" id="txtC1.*" type="text" />
                	<input class="txt num c1" id="txtNotv.*" type="text" />
                </td>
                <td>
                	<input class="txt c1" id="txtMemo.*" type="text" />
                	<input class="txt" id="txtOrdeno.*" type="text" style="width:73%;" />
                	<input class="txt" id="txtNo2.*" type="text" style="width:20%;" />
                	<input id="recno.*" type="hidden" />
                </td>
                <td align="center"><input id="chkEnda.*" type="checkbox"/></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>