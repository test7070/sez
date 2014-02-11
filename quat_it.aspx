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
			q_desc=1;
			q_tables = 's';
			var q_name = "quat";
			var decbbs = ['price', 'weight', 'mount', 'total','dime', 'width', 'lengthb', 'c1', 'notv', 'theory'];
			var decbbm = ['money', 'tax', 'total', 'weight', 'floata', 'mount', 'price','totalus'];
			var q_readonly = ['txtWorker','txtComp', 'txtAcomp','txtSales','txtWorker2','txtPostname','txtNoa'];
			var q_readonlys = [];
			var bbmNum = [['txtMoney', 15, 0, 1],['txtTax', 10, 0, 1],['txtTotal', 15, 0, 1],['txtTotalus', 15, 2, 1],
						  ['txtFloata', 15, 3, 1]];
			var bbsNum = [['txtMount', 10, 0, 1],
						  ['txtPrice', 10, 2, 1],['txtTotal', 15, 0, 1]];
			var bbmMask = [];
			var bbsMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwCount2 = 9;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(
				['txtProductno_', 'btnProduct_', 'ucc', 'noa,product,unit,saleprice', 'txtProductno_,txtProduct_,txtUnit_,txtPrice_,txtMount_', 'ucc_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
				 ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'no3'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
				q_gt('sss', "where=^^noa='"+r_userno+"'^^", 0, 0, 0, "sssissales");
			});
			
			//////////////////	end Ready
			function main() {
				if(dataErr) {
					dataErr = false;
					return;
				}

				mainForm(1);
			}
			function currentData() {}
			currentData.prototype = {
				data : [],
				exclude : ['txtNoa','chkEnda'],  //bbm
				excludes : ['chkEnda'], //bbs
				copy : function() {
					this.data = new Array();
					for (var i in fbbm) {
						var isExclude = false;
						for (var j in this.exclude) {
							if (fbbm[i] == this.exclude[j] ) {
								isExclude = true;
								break;
							}
						}
						if (!isExclude ) {
							this.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
					//bbs
					for (var i in fbbs) {
						for(var j = 0; j < q_bbsCount; j++) {
							var isExcludes = false;
							for (var k in this.excludes) {
								if (fbbs[i] == this.excludes[k] ) {
									isExcludes = true;
									break;
								}
							}
							if (!isExcludes ) {
								this.data.push({
									field : fbbs[i]+'_'+j,
									value : $('#' + fbbs[i]+'_'+j).val()
								});
							}
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in this.data) {
					   	$('#' + this.data[i].field).val(this.data[i].value);
				   	}
				}
			};
			var curData = new currentData();
			
			function sum() {
				var t1 = 0, t_unit, t_mount, t_weight = 0,t_total=0;
				for(var j = 0; j < q_bbsCount; j++) {
					q_tr('txtTotal_'+j,q_mul(q_float('txtMount_'+j),q_float('txtPrice_'+j)));
					t_total=q_add( t_total,q_float('txtTotal_'+j));
				}  // j
				q_tr('txtMoney',t_total);
				q_tr('txtTotal',t_total);
				calTax();
				q_tr('txtTotalus',q_mul( q_float('txtTotal'),q_float('txtFloata')));
			}
			
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd],['txtOdate',r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbStype", q_getPara('vcc.stype')); 
				q_cmbParse("cmbCoin", q_getPara('sys.coin'));	 
				q_cmbParse("combPaytype", q_getPara('vcc.paytype'));  
				q_cmbParse("cmbTrantype",q_getPara('sys.tran'));
				q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));  
				var t_where = "where=^^ 1=1  group by post,addr^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
				
				$('#txtFloata').change(function () {sum();});
				$('#txtTotal').change(function () {sum();});
				$('#txtAddr').change(function(){
					var t_custno = trim($(this).val());
					if(!emp(t_custno)){
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}  
				});
				$('#txtAddr2').change(function(){
					var t_custno = trim($(this).val());
					if(!emp(t_custno)){
						focus_addr = $(this).attr('id');
						var t_where = "where=^^ noa='" + t_custno + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "");
					}  
				});
				
				$('#txtCustno').change(function(){
					if(!emp($('#txtCustno').val())){
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
						q_gt('cust', t_where, 0, 0, 0, "cust_txt");
						post_custno=$('#txtCustno').val();
						popcust=false;
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
				});
				
				$('#cmbStype').change(function() {
					if($('#cmbStype').val()=='4'){
						$('#btnSample').show();
					}else{
						$('#btnSample').hide();
					}
					$('#div_sample').hide();
				});
				
				$('#btnSample').mousedown(function(e) {
			 		if(e.button==0){
			 			////////////控制顯示位置
						$('#div_sample').css('top',e.pageY);
						$('#div_sample').css('left',e.pageX-$('#div_sample').width());
						$('#div_sample').toggle();
					}
				 });
				 
				 $('#btnClose_div_sample').click(function() {
				 	$('#div_sample').toggle();
				 });
			}

			function q_boxClose(s2) {///	q_boxClose 2/4
				var ret;
				switch (s2[0]) {
					case 'ucc':
						$('#txtMount_'+t_IdSeq).focus();
						break;
				}/// end Switch
				
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						///	q_boxClose 3/4
						break;
				}/// end Switch
				b_pop = '';
			}
			
			var issales='false';
			var focus_addr='';
			var z_cno=r_cno,z_acomp=r_comp,z_nick=r_comp.substr(0,2);
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'sssissales':
					var as = _q_appendData("sss", "", true);
                        if (as[0] != undefined) {
                        	issales=as[0].issales;
						}
					break;
					case 'cust_txt':
						var as = _q_appendData("cust", "", true);
						if(as[0]!=undefined){
							$('#txtPaytype').val(as[0].paytype);
							$('#txtTel').val(as[0].tel);
							$('#txtFax').val(as[0].fax);
							$('#cmbTrantype').val(as[0].trantype);
							$('#txtPost').val(as[0].zip_comp);
							$('#txtAddr').val(as[0].addr_comp);
							$('#txtSalesno').val(as[0].salesno);
							$('#txtSales').val(as[0].sales);
                       }else{
	                       	if(!popcust){
								q_box("cust.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" , 'cust', "95%", "95%", q_getMsg('popCust'));
								popcust=false;
	                       }
                       }
                       $('#txtPost2').focus();
					break;
					case 'cust_pop':
						var as = _q_appendData("cust", "", true);
						if(as[0]!=undefined){
							$('#txtPaytype').val(as[0].paytype);
							$('#txtTel').val(as[0].tel);
							$('#txtFax').val(as[0].fax);
							$('#cmbTrantype').val(as[0].trantype);
							$('#txtPost').val(as[0].zip_comp);
							$('#txtAddr').val(as[0].addr_comp);
							$('#txtSalesno').val(as[0].salesno);
							$('#txtSales').val(as[0].sales);
                       }
                       
                       $('#txtPost2').focus();
					break;
					case 'cno_acomp':
                		var as = _q_appendData("acomp", "", true);
                		if (as[0] != undefined) {
	                		z_cno=as[0].noa;
	                		z_acomp=as[0].acomp;
	                		z_nick=as[0].nick;
	                	}
                		break;
					case 'custaddr':
						var as = _q_appendData("custaddr", "", true);
						var t_item = " @ ";
						if(as[0]!=undefined){
	                        for ( i = 0; i < as.length; i++) {
	                            t_item = t_item + (t_item.length > 0 ? ',' : '') +as[i].post +'@'+ as[i].addr;
	                        }
                       }
                       document.all.combAddr.options.length = 0; 
	                   q_cmbParse("combAddr", t_item);
					break;
					case 'cust':
						var as = _q_appendData("cust", "", true);
						if(as[0]!=undefined && focus_addr !=''){
							$('#'+focus_addr).val(as[0].addr_fact);
							focus_addr = '';
						}
						break;
					case q_name:
						if(q_cur == 4)
							q_Seek_gtPost();
						break;
				}  /// end switch
			}

			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')],['txtCustno', q_getMsg('lblCust')]]);
				if(t_err.length > 0) {
					alert(t_err);
					return;
				}
				
				var z_memo2=$('#textDivision').val()+'&&'+$('#textUnit').val()+'&&'+$('#textMode').val()+'&&'+
				$('#textMount').val()+'&&'+$("#checkPhoto").prop("checked")+'&&'+$('#textTimea').val()+'&&'+$('#textApplication').val()+'&&'+$('#textMemo').val();
				$('#txtMemo2').val(z_memo2);
				
				if(q_cur==1)
					$('#txtWorker' ).val(r_name);
				if(q_cur==2)
					$('#txtWorker2' ).val(r_name);
				
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if(s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_quat') + $('#txtDatea').val(), '/', ''));
				else
					wrServer(s1);
			}

			function _btnSeek() {
				if(q_cur > 0 && q_cur < 4)// 1-3
					return;

				q_box('quat_it_s.aspx', q_name + '_s', "500px", "410px", q_getMsg("popSeek"));
			}

			function combPay_chg() {
				var cmb = document.getElementById("combPaytype");
	            if (!q_cur)
	                cmb.value = '';
	            else
	                $('#txtPaytype').val(cmb.value);
	            cmb.value = '';
			}
			
			function combAddr_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
	            if (q_cur==1 || q_cur==2){
	                $('#txtAddr2').val($('#combAddr').find("option:selected").text());
	                $('#txtPost2').val($('#combAddr').find("option:selected").val());
	            }
	        }

			function bbsAssign() {
				for(var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtUnit_' + j).change(function () {sum();});
						$('#txtMount_' + j).change(function () {sum();});
						//$('#txtWeight_' + j).change(function () {sum();});
						$('#txtPrice_' + j).change(function () {sum();});
						$('#btnVccrecord_' + j).click(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							t_where = "cust='"+$('#txtCustno').val()+"' and noq='"+$('#txtProductno_'+b_seq).val()+"'";
							q_box("z_vccrecord.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccrecord', "95%", "95%", q_getMsg('lblRecord_s'));
						});
					}
				}
				_bbsAssign();
			}

			function btnIns() {
            	if($('#checkCopy').is(':checked'))
            		curData.copy();
                _btnIns();
            	if($('#checkCopy').is(':checked'))
	                curData.paste();
				$('#chkIsproj').attr('checked',true);
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtOdate').val(q_date());
				$('#txtDatea').focus();
				$('#cmbTaxtype').val('3');
				
				$('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
				
				var t_where = "where=^^ 1=1  group by post,addr^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
			}

			function btnModi() {
				if(emp($('#txtNoa').val()))
					return;
				if(issales=='true'&&$('#txtWorker').val()!=r_name)	
					return;
				_btnModi();
				$('#txtProduct').focus();
				
				if(!emp($('#txtCustno').val())){
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
			}

			function btnPrint() {
				q_box('z_quatpit.aspx'+ "?;;;noa="+trim($('#txtNoa').val())+";"+r_accy, '', "95%", "95%", m_print);
			}

			function wrServer(key_value) {
				var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if(!as['productno']) {
					as[bbsKey[1]] = '';
					return;
				}

				q_nowf();
				as['datea'] = abbm2['datea'];
				as['odate'] = abbm2['odate'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				
				if($('#cmbStype').val()=='4'){
					$('#btnSample').show();
				}else{
					$('#btnSample').hide();
				}
				$('#div_sample').hide();
				
				//拆分txtmemo2代入div
				var t_memo2 = replaceAll($('#txtMemo2').val(),'＆＆','&&').split('&&'); 
				$('#textDivision').val(t_memo2[0]);
				$('#textUnit').val(t_memo2[1]);
				$('#textMode').val(t_memo2[2]);
				$('#textMount').val(t_memo2[3]);
				if(t_memo2[4]=='true')
					$("#checkPhoto").prop("checked",true);
				else
					$("#checkPhoto").prop("checked",false);
				$('#textTimea').val(t_memo2[5]);
				$('#textApplication').val(t_memo2[6]);
				$('#textMemo').val(t_memo2[7]);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#combAddr').attr('disabled','disabled');
					
					$('#textDivision').attr('disabled','disabled');
					$('#textUnit').attr('disabled','disabled');
					$('#textMode').attr('disabled','disabled');
					$('#textMount').attr('disabled','disabled');
					$('#checkPhoto').attr('disabled','disabled');
					$('#textTimea').attr('disabled','disabled');
					$('#textApplication').attr('disabled','disabled');
					$('#textMemo').attr('disabled','disabled');
				}else{
					$('#combAddr').removeAttr('disabled');
					
					$('#textDivision').removeAttr('disabled');
					$('#textUnit').removeAttr('disabled');
					$('#textMode').removeAttr('disabled');
					$('#textMount').removeAttr('disabled');
					$('#checkPhoto').removeAttr('disabled');
					$('#textTimea').removeAttr('disabled');
					$('#textApplication').removeAttr('disabled');
					$('#textMemo').removeAttr('disabled');
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
			var popcust=false;
			function q_popPost(s1) {
		    	switch (s1) {
			        case 'txtCustno':
		    			if(!emp($('#txtCustno').val())){
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
							q_gt('cust', t_where, 0, 0, 0, "cust_pop");
							popcust=true;
							
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
							q_gt('custaddr', t_where, 0, 0, 0, "");
					}
			        break;
		    	}
			}
			
			function calTax(){
				var t_money=0,t_tax=0,t_total=0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_money+=q_float('txtTotal_' + j);
				}
				var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')) , 100);
				switch ($('#cmbTaxtype').val()) {
	               	case '0':
						// 無
						t_tax = 0;
						t_total = q_add(t_money,t_tax);
						break;
					case '1':
						// 應稅
						t_tax = round(q_mul(t_money,t_taxrate), 0);
						t_total = q_add(t_money,t_tax);
						break;
					case '2':
						//零稅率
						t_tax = 0;
						t_total = q_add(t_money,t_tax);
						break;
					case '3':
						// 內含
						 t_tax=0,t_total=0,t_money=0;
						for (var j = 0; j < q_bbsCount; j++) {
							t_tax += round(q_mul(q_div(q_float('txtTotal_' + j), q_add(1, t_taxrate)), t_taxrate), 0);
							t_total += q_float('txtTotal_' + j);
							t_money = q_sub(t_total, t_tax);
						}
						break;
					case '4':
						// 免稅
						t_tax = 0;
						t_total = q_add(t_money,t_tax);
						break;
					case '5':
						// 自定
						$('#txtTax').attr('readonly', false);
						$('#txtTax').css('background-color', 'white').css('color', 'black');
						t_tax = round(q_float('txtTax'), 0);
						t_total = q_add(t_money,t_tax);
						break;
					case '6':
						// 作廢-清空資料
						t_money = 0, t_tax = 0, t_total = 0;
						break;
					default:
				}
				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
			}
			
			function FormatNumber(n) {
	            var xx = "";
	            if(n<0){
	            	n = Math.abs(n);
	            	xx = "-";
				}     		
				n += "";
				var arr = n.split(".");
				var re = /(\d{1,3})(?=(\d{3})+$)/g;
				return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
			}
		</script> 
	<style type="text/css">
		#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 30%;
                border-width: 0px;
            }
            .tview {
            	width: 100%;
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
                width: 70%;
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
                /*width: 10%;*/
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
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 48%;
				float: left;
			}
			.txt.c3 {
				width: 50%;
				float: left;
			}
			.txt.c4 {
				width: 25%;
				float: left;
			}
			.txt.c5 {
				width: 72%;
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
				width: auto;
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
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size:medium;
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
<body>
	<div id="div_sample" style="position:absolute; top:300px; left:500px; display:none; width:600px; background-color: #ffffff; ">
		<table id="table_sample"  class="table_row" style="width:100%;" border="1" cellpadding='1'  cellspacing='0'>
			<tr>
				<td align="center" width="25%"><a class="lbl">試用科別</a></td>
				<td align="center" width="25%"><input id="textDivision" type="text"  class="txt  c1"/></td>
				<td align="center" width="25%"><a class="lbl">試用單位</a></td>
				<td align="center" width="25%"><input id="textUnit" type="text"  class="txt  c1"/></td>
			</tr>
			<tr>
				<td align="center" ><a class="lbl">試用方式</a></td>
				<td align="center" ><input id="textMode" type="text"  class="txt  c1"/></td>
				<td align="center" ><a class="lbl">試用人數</a></td>
				<td align="center" ><input id="textMount" type="text"  class="txt  c1"/></td>
			</tr>
			<tr>
				<td align="center" ><a class="lbl">拍照</a></td>
				<td align="center" ><input id="checkPhoto" type="checkbox"/></td>
				<td align="center" ><a class="lbl">更換時間</a></td>
				<td align="center" ><input id="textTimea" type="text"  class="txt  c1"/></td>
			</tr>
			<tr>
				<td align="center" ><a class="lbl">申請理由</a></td>
				<td align="center" colspan='3'><input id="textApplication" type="text"  class="txt c1"/></td>
			</tr>
			<tr style="display: none;">
				<td align="center" ><a class="lbl">備註</a></td>
				<td align="center" colspan='3'><input id="textMemo" type="text"  class="txt c1"/></td>
			</tr>
			<tr>
				<td align="center" colspan='4'><input id="btnClose_div_sample" type="button" value="關閉視窗"></td>
			</tr>
		</table>
	</div>
<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1270px;">
		<div class="dview" id="dview">
			<table class="tview" id="tview"	>
			<tr>
				<td align="center" style="width:5%"><a id='vewChk'> </a></td>
				<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
				<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
				<td align="center" style="width:40%"><a id='vewComp'> </a></td>
			</tr>
			 <tr>
				<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
				<td align="center" id='datea'>~datea</td>
				<td align="center" id='noa'>~noa</td>
				<td align="center" id='custno comp,4' style="text-align: left;">~custno ~comp,4</td>
			</tr>
		</table>
		</div>
		<div class='dbbm'>
		<table class="tbbm"  id="tbbm" style="width: 872px;">
			<tr class="tr1">
				<td class="td1" style="width: 108px;">
					<input id="checkCopy" type="checkbox" style="float:left;"/>
					<span> </span><a id='lblCopy' class="lbl" style="float:left;"> </a>					
					<span> </span><a id='lblStype' class="lbl"> </a>
				</td>
				<td class="td2" style="width: 108px;"><select id="cmbStype" class="txt c1"> </select></td>
				<td class="td3" style="width: 108px;"><input id="txtOdate" type="text"  class="txt c1"/></td>
				<td class="td4"  style="width: 108px;"><span> </span><a id='lblDatea' class="lbl"> </a></td>
				<td class="td5" style="width: 108px;"><input id="txtDatea" type="text"  class="txt c1"/></td>
						<td>
						<input id="chkIsproj" type="checkbox"/>
						<span> </span><a id='lblIsproj'> </a>
						</td>
				<td class="td7" style="width: 108px;"><span> </span><a id='lblNoa' class="lbl"> </a></td>
				<td class="td8" style="width: 108px;"><input id="txtNoa" type="text" class="txt c1"/></td> 
			</tr>	
			<tr class="tr2">
				<td class="label1"><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
				<td class="column1" ><input id="txtCno"  type="text"  class="txt c1"/></td>
				<td class="column2" ><input id="txtAcomp"  type="text" class="txt c1"/></td>
				<td class="label2"><span> </span><a id='lblFloata' class="lbl"> </a></td>
				<td class="column3" ><select id="cmbCoin" class="txt c1" > </select></td>				 
				<td class="column4" ><input id="txtFloata"  type="text"  class="txt c1" style="text-align: right;"/></td>				 
				<td class="label3"><span> </span><a id='lblContract' class="lbl"> </a></td>
				<td class="column2"><input id="txtContract"  type="text"  class="txt c1"/></td> 
			</tr>
			<tr class="tr3">
				<td class="label1"><span> </span><a id='lblCust' class="lbl btn"> </a></td>
				<td ><input id="txtCustno" type="text" class="txt c1"/></td>
				<td ><input id="txtComp"  type="text" class="txt c1"/></td>
				<td class="label2"><span> </span><a id='lblPaytype' class="lbl"> </a></td>
				<td ><input id="txtPaytype" type="text" class="txt c1" /></td> 
				<td> <select id="combPaytype" class="txt c1" onchange='combPay_chg()'> </select></td> 
				<td class="label3"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
				<td><select id="cmbTrantype" class="txt c1" name="D1" > </select></td> 
			</tr>
			<tr class="tr4">
				<td class="label1"><span> </span><a id='lblSales' class="lbl btn"> </a></td>
				<td ><input id="txtSalesno" type="text" class="txt c1"/></td> 
				<td ><input id="txtSales" type="text" class="txt c1"/></td> 
				<td class="label2"><span> </span><a id='lblTel' class="lbl"> </a></td>
				<td colspan='2'><input id="txtTel"	type="text"  class="txt c1"/></td>
				<td class="label3"><span> </span><a id='lblFax' class="lbl"> </a></td>
				<td ><input id="txtFax"  type="text"  class="txt c1"/></td>
			</tr>
			<tr class="tr5">
				<td class="label1"><span> </span><a id='lblAddr' class="lbl"> </a></td>
				<td ><input id="txtPost" type="text"  class="txt c1"></td>
				<td colspan='4' ><input id="txtAddr" type="text"  class="txt c1" /></td>
				<td colspan='2' style="text-align: center;"><input type="button" id="btnSample" style='font-size: medium;' ></td>
			</tr>
			<tr class="tr6">
				<td class="label1"><span> </span><a id='lblAddr2' class="lbl"> </a></td>
				<td ><input id="txtPost2"  type="text"  class="txt c1"/> </td>
				<td colspan='4' >
					<input id="txtAddr2"  type="text"  class="txt c1" style="width: 412px;"/> 
					<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
				</td>
				<td class="label3"><span> </span><a id='lblPostname' class="lbl"> </a></td>
				<td ><input id="txtPostname"  type="text"  class="txt c1"/></td>
			</tr>
			<tr class="tr7">
				<td class="label1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
				<td colspan='2'><input id="txtMoney" type="text" class="txt c1" style="text-align: right;" /></td> 
				<td class="label2"><span> </span><a id='lblTax' class="lbl"> </a></td>
				<td><input id="txtTax" type="text"  class="txt c1" style="text-align: right;" /></td>
				<td><select id="cmbTaxtype" class="txt c1" onchange='sum()'> </select></td>
				<td class="label3"><span> </span><a id='lblTotal' class="lbl"> </a></td>
				<td ><input id="txtTotal" type="text"  class="txt c1" style='text-align:right;'/>
				</td> 
			</tr>
			<tr class="tr8">
				<td class="label1"><span> </span><a id='lblTotalus' class="lbl"> </a></td>
				<td colspan='2'><input id="txtTotalus"	type="text"  class="txt c1" style="text-align: right;" /></td> 
				<td class="label3"><span> </span><a id='lblWorker' class="lbl"> </a></td>
				<td ><input id="txtWorker"  type="text" class="txt c1" /></td>
				<td ><input id="txtWorker2"  type="text" class="txt c1" /></td>
				<td style="text-align: right;">	<span> </span><a id='lblEnda'> </a></td>
				<td><input id="chkEnda" type="checkbox"/></td>
			</tr>
			<tr class="tr9">
				<td align="right"><span> </span><a id='lblMemo' class="lbl"> </a></td>
				<td  colspan='7' >
					<input id="txtMemo"  type="text" style="width: 99%;"/>
					<input id="txtMemo2"  type="hidden"/>
				</td>
			</tr>
		</table>
		</div>
		</div>
		<div class='dbbs' style="width: 1270px;">
		<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
			  <tr style='color:White; background:#003366;' >
				<td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
				<td align="center" style="width:10%;"><a id='lblProductno'> </a></td>
				<td align="center" style="width:20%;"><a id='lblUno'> </a></td>
				<td align="center" style="width:4%;"><a id='lblUnit'> </a></td>
				<td align="center" style="width:5%;"><a id='lblMount'> </a></td>
				<!--<td align="center"><a id='lblWeights'></a></td>-->
				<td align="center" style="width:6%;"><a id='lblPrices'> </a></td>
				<td align="center" style="width:8%;"><a id='lblTotals'> </a></td>
				<td align="center" style="width:12%;"><a id='lblMemos'> </a></td>
				<td align="center" style="width:3%;"><a id='lblEnda_s'> </a></td>
				<td align="center" style="width:3%;"><a id='lblVccrecord'> </a></td>
			</tr>
			<tr  style='background:#cad3ff;'>
				<td><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
				<td style="text-align:center">
					<input id="txtProductno.*" type="text" class="txt" style="width:80%;" />
					<input class="btn"  id="btnProduct.*" type="button" value='.' style=" font-weight: bold;" />
					<input id="txtNo3.*" type="text" class="txt c3" style="display:none;"/></td>
				<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
				<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
				<td><input id="txtMount.*" type="text"  class="txt c1" style="text-align:right;"/></td>
				<!--<td style="width:8%;"><input id="txtWeight.*" type="text"  class="txt c2" style="text-align:right;"/></td>-->
				<td><input id="txtPrice.*" type="text" class="txt c1" style="text-align:right;"/></td>
				<td><input id="txtTotal.*" type="text" class="txt c1" style="text-align:right;"/></td>
				<td>
					<input id="txtMemo.*" type="text" class="txt c1"/>
					<input class="txt" id="txtOrdeno.*" type="text"style="width:65%;" />
					<input class="txt" id="txtNo2.*" type="text" style="width:20%;" />
					<input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" />
				</td>
				<td align="center"><input id="chkEnda.*" type="checkbox"/></td>
				<td align="center"><input class="btn"  id="btnVccrecord.*" type="button" value='.' style=" font-weight: bold;" /></td>
			</tr>
		</table>
		</div>
		<input id="q_sys" type="hidden" />
</body>
</html>
