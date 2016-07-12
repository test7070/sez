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

			q_tables = 's';
			var q_name = "tran";
			var q_readonly = ['txtNoa','textTotal','textTotal2','txtWeight','txtWorker', 'txtWorker2'];
			var q_readonlys = ['txtTotal','txtTotal2'];
			var bbmNum = [];//['txtMount',10,3,1],['txtWeight',10,3,1],['txtTotal',10,0,1]
			var bbsNum = [['txtInmount',10,3,1],['txtPton',10,3,1],['txtPrice',10,3,1],['txtTotal',10,0,1],['txtOutmount',10,3,1],['txtPton2',10,3,1],['txtPrice2',10,3,1],['txtPrice3',10,3,1],['txtDiscount',10,3,1],['txtTotal2',10,0,1]
			,['txtBmiles',15,2,1],['txtEmiles',15,2,1],['txtMiles',15,2,1],['txtGps',15,2,1]];
			var bbmMask = [];
			var bbsMask = [['txtDtime','99:99'],['txtCaseno2','A']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			aPop = new Array(
				['txtDriverno', 'lblDriverno', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'],
				['txtCarno', 'lblCarno', 'car2', 'a.noa', 'txtCarno', 'car2_b.aspx'],
				['txtCustno_', 'btnCustno_', 'cust', 'noa,comp,nick', 'txtCustno_,txtComp_,txtNick_', 'cust_b.aspx'],
				['txtUccno_', 'btnUccno_', 'ucc', 'noa,product', 'txtUccno_,txtProduct_', 'ucc_b.aspx'],
				['txtStraddrno_','btnStraddrno_','addr2','noa,addr','txtStraddrno_,txtStraddr_','addr2_b.aspx'],
				['txtEndaddrno_','btnEndaddrno_','addr2','noa,addr','txtEndaddrno_,txtEndaddr_','addr2_b.aspx'],
				['txtBoatno_', 'btnBoatno_', 'boat', 'noa,boat', 'txtBoatno_,txtBoat_', 'boat_b.aspx']
			);
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				//q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
				q_gt('calctype2', '', 0, 0, 0, 'transInit1');
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function sum(){
				var t_total=0,t_total2=0;
				for(var i=0;i<q_bbsCount;i++){
					t_total = q_add(t_total,dec($('#txtTotal_'+i).val()));
					t_total2 = q_add(t_total2,dec($('#txtTotal2_'+i).val()));
				}
				$('#textTotal').val(t_total);
				$('#textTotal2').val(t_total2);
			}
			
			function mainPost() {
				q_getFormat();
				bbmMask = [];
                q_mask(bbmMask);
				
				q_cmbParse("cmbCstype",' ,領,交,送','s');
				q_cmbParse("cmbCasetype", "20'',40''",'s');
				
				$('#cmbCalctype').change(function() {
					refreshbbs();
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
			
			var calctypes;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'transInit1':
                        calctypes = _q_appendData("calctypes", "", true);
                        var t_item = "";
                        if(calctypes[0]!=undefined){
                            for ( i = 0; i < calctypes.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + calctypes[i].noa + calctypes[i].noq + '@' + calctypes[i].typea;
                            }
                            q_cmbParse("cmbCalctype", t_item);
                        }
                        if(abbm[q_recno]!=undefined)
                            $("#cmbCalctype").val(abbm[q_recno].calctype);  
                       
                        q_gt('carteam', '', 0, 0, 0, 'transInit2');
                        break;
                    case 'transInit2':
                        var as = _q_appendData("carteam", "", true);
                        var t_item = "";
                        if(as[0]!=undefined){
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                            }
                            q_cmbParse("cmbCarteamno", t_item);
                        }
                        if(abbm[q_recno]!=undefined)
                            $("#cmbCarteamno").val(abbm[q_recno].carteamno);  
                            
                        q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                        break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
				if(t_name.substr(0,14)=='getPrice_cust_'){
					var n=replaceAll(t_name,'getPrice_cust_','');
					var t_price = 0;
					var as = _q_appendData("addrs", "", true);
					if(as[0]!=undefined){
						t_price = as[0].custprice;
					}
					$('#txtPrice_'+n).val(t_price);
							
					var t_straddrno = $.trim($('#txtStraddrno_'+n).val());
					var t_endaddrno = $.trim($('#txtEndaddrno_'+n).val());
					var t_productno = $.trim($('#txtUccno_'+n).val());
					var t_date = $.trim($('#txtDatea').val());
					var t_unit = $.trim($('#txtUnit2_'+n).val());
					
					var t_calctype=$('#cmbCalctype').val();
					var isoutside="false";
					for ( i = 0; i < calctypes.length; i++) {
						if(t_calctype==calctypes[i].noa + calctypes[i].noq){
							isoutside=calctypes[i].isoutside;
						}
					}
										
					if(isoutside!="false"){//外車
						t_where = "b.straddrno='"+t_straddrno+"' and b.endaddrno='"+t_endaddrno+"' and b.productno='"+t_productno+"' and a.datea<='"+t_date+"' and a.driverunit2='"+t_unit+"'";
						q_gt('addr_tb', "where=^^"+t_where+"^^", 0, 0, 0, 'getPrice_driver2_'+n);
					}else{
						t_where = "b.straddrno='"+t_straddrno+"' and b.endaddrno='"+t_endaddrno+"' and b.productno='"+t_productno+"' and a.datea<='"+t_date+"' and a.driverunit='"+t_unit+"'";
						q_gt('addr_tb', "where=^^"+t_where+"^^", 0, 0, 0, 'getPrice_driver_'+n);
					}
				}else if (t_name.substr(0,17)=='getPrice_driver2_'){
					var n=replaceAll(t_name,'getPrice_driver2_','');
					var t_price = 0;
					var as = _q_appendData("addrs", "", true);
					if(as[0]!=undefined){
						t_price = as[0].driverprice2;
					}
					$('#txtPrice2_'+n).val(0);
					$('#txtPrice3_'+n).val(t_price);
					sum();
				}else if (t_name.substr(0,16)=='getPrice_driver_'){
					var n=replaceAll(t_name,'getPrice_driver_','');
					var t_price = 0;
					var as = _q_appendData("addrs", "", true);
					if(as[0]!=undefined){
						t_price = as[0].driverprice;
					}
					$('#txtPrice2_'+n).val(t_price);
					$('#txtPrice3_'+n).val(0);
                        
					sum();
				}
			}

			function q_popPost(s1) {
				switch(s1) {
                    case 'txtStraddrno_':
                        priceChange(b_seq);
                        break;
                    case 'txtEndaddrno_':
                        priceChange(b_seq);
                        break;
                    case 'txtUccno_':
                        priceChange(b_seq);
                        break;
					case 'txtCustno_':
                        priceChange(b_seq);
                        break;
                    default:
                        break;
                }
			}

			function btnOk() {
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				for(var j=0;j<q_bbsCount;j++){
					$('#txtCarno_'+j).val($('#txtCarno').val());
					$('#txtDriverno_'+j).val($('#txtDriverno').val());
					$('#txtDriver_'+j).val($('#txtDriver').val());
				}
				
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtOdate').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tran') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
			}

			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtStraddrno_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						$('#txtEndaddrno_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						$('#txtUccno_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						$('#txtCustno_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
						});
						
						$('#txtPrice_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_price = q_float('txtPrice_'+b_seq);
							var t_mount = q_add(q_float('txtInmount_'+b_seq),q_float('txtPton_'+b_seq));
							var t_total = round(q_mul(t_price,t_mount),0);
							$('#txtMount_'+b_seq).val(q_trv(t_mount));
							$('#txtTotal_'+b_seq).val(q_trv(t_total));
							sum();
						});
						$('#txtInmount_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_price = q_float('txtPrice_'+b_seq);
							var t_mount = q_add(q_float('txtInmount_'+b_seq),q_float('txtPton_'+b_seq));
							var t_total = round(q_mul(t_price,t_mount),0);
							$('#txtMount_'+b_seq).val(q_trv(t_mount));
							$('#txtTotal_'+b_seq).val(q_trv(t_total));
							sum();
						});
						$('#txtPton_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_price = q_float('txtPrice_'+b_seq);
							var t_mount = q_add(q_float('txtInmount_'+b_seq),q_float('txtPton_'+b_seq));
							var t_total = round(q_mul(t_price,t_mount),0);
							$('#txtMount_'+b_seq).val(q_trv(t_mount));
							$('#txtTotal_'+b_seq).val(q_trv(t_total));
							sum();
						});
						$('#txtPrice2_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if($('#txtDiscount_'+b_seq).val().length==0){
								$('#txtDiscount_'+b_seq).val(1);
							}
							var t_price2 = q_float('txtPrice2_'+b_seq);
							var t_price3 = q_float('txtPrice3_'+b_seq);
							var t_mount2 = q_add(q_float('txtOutmount_'+b_seq),q_float('txtPton2_'+b_seq));
							var t_total2 = round(q_mul(q_mul(q_add(t_price2,t_price3),t_mount2),q_float('txtDiscount_'+b_seq)),0);
							$('#txtMount2_'+b_seq).val(q_trv(t_mount2));
							$('#txtTotal2_'+b_seq).val(q_trv(t_total2));
							sum();
						});
						$('#txtPrice3_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if($('#txtDiscount_'+b_seq).val().length==0){
								$('#txtDiscount_'+b_seq).val(1);
							}
							var t_price2 = q_float('txtPrice2_'+b_seq);
							var t_price3 = q_float('txtPrice3_'+b_seq);
							var t_mount2 = q_add(q_float('txtOutmount_'+b_seq),q_float('txtPton2_'+b_seq));
							var t_total2 = round(q_mul(q_mul(q_add(t_price2,t_price3),t_mount2),q_float('txtDiscount_'+b_seq)),0);
							$('#txtMount2_'+b_seq).val(q_trv(t_mount2));
							$('#txtTotal2_'+b_seq).val(q_trv(t_total2));
							sum();
						});
						$('#txtDiscount_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							var t_price2 = q_float('txtPrice2_'+b_seq);
							var t_price3 = q_float('txtPrice3_'+b_seq);
							var t_mount2 = q_add(q_float('txtOutmount_'+b_seq),q_float('txtPton2_'+b_seq));
							var t_total2 = round(q_mul(q_mul(q_add(t_price2,t_price3),t_mount2),q_float('txtDiscount_'+b_seq)),0);
							$('#txtMount2_'+b_seq).val(q_trv(t_mount2));
							$('#txtTotal2_'+b_seq).val(q_trv(t_total2));
							sum();
						});
						
						$('#txtOutmount_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if($('#txtDiscount_'+b_seq).val().length==0){
								$('#txtDiscount_'+b_seq).val(1);
							}
							var t_price2 = q_float('txtPrice2_'+b_seq);
							var t_price3 = q_float('txtPrice3_'+b_seq);
							var t_mount2 = q_add(q_float('txtOutmount_'+b_seq),q_float('txtPton2_'+b_seq));
							var t_total2 = round(q_mul(q_mul(q_add(t_price2,t_price3),t_mount2),q_float('txtDiscount_'+b_seq)),0);
							$('#txtMount2_'+b_seq).val(q_trv(t_mount2));
							$('#txtTotal2_'+b_seq).val(q_trv(t_total2));
							sum();
						});
						$('#txtPton2_'+j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if($('#txtDiscount_'+b_seq).val().length==0){
								$('#txtDiscount_'+b_seq).val(1);
							}
							var t_price2 = q_float('txtPrice2_'+b_seq);
							var t_price3 = q_float('txtPrice3_'+b_seq);
							var t_mount2 = q_add(q_float('txtOutmount_'+b_seq),q_float('txtPton2_'+b_seq));
							var t_total2 = round(q_mul(q_mul(q_add(t_price2,t_price3),t_mount2),q_float('txtDiscount_'+b_seq)),0);
							$('#txtMount2_'+b_seq).val(q_trv(t_mount2));
							$('#txtTotal2_'+b_seq).val(q_trv(t_total2));
							sum();
						});
					}
				}
				_bbsAssign();
				refreshbbs();
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtOdate').val(q_date());
				$('#txtDatea').val(q_date()).focus();
				refreshbbs();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
			}

			function btnPrint() {
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				//新增 trans 應付
				var t_accy = (!emp(r_accy)?r_accy:q_date().substring(0,3));
				var t_noa = $.trim($('#txtNoa').val());
				q_func('qtxt.query','tran.txt,transave,'+encodeURI(t_accy) + ';' + encodeURI(t_noa));
			}

			function bbsSave(as) {
				if (!as['custno'] && !as['comp'] && !as['straddrno'] && !as['straddr'] && !as['endaddrno'] && !as['endaddr'] && !as['uccno'] && !as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['date'] = abbm2['date'];
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				refreshbbs();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				refreshbbs();
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
			
			function refreshbbs() {
				var t_calctype=$('#cmbCalctype').val();
				var isoutside="false";
				for ( i = 0; i < calctypes.length; i++) {
					if(t_calctype==calctypes[i].noa + calctypes[i].noq){
						isoutside=calctypes[i].isoutside;
					}
				}
				if(isoutside!="false"){
					$('.price2').hide();
					$('.price3').show();
				}else{
					$('.price2').show();
					$('.price3').hide();
				}
				sum();
			}
			
			function priceChange(n) {
				var t_custno = $.trim($('#txtCustno_'+n).val());
				var t_straddrno = $.trim($('#txtStraddrno_'+n).val());
				var t_endaddrno = $.trim($('#txtEndaddrno_'+n).val());
				var t_productno = $.trim($('#txtUccno_'+n).val());
				var t_date = $.trim($('#txtDatea').val());
				var t_unit = $.trim($('#txtUnit_'+n).val());
                    
				var t_where = "a.custno='"+t_custno+"' and b.straddrno='"+t_straddrno+"' and b.endaddrno='"+t_endaddrno+"' and b.productno='"+t_productno+"' and a.datea<='"+t_date+"' and a.custunit='"+t_unit+"'";
				q_gt('addr_tb', "where=^^"+t_where+"^^", 0, 0, 0, 'getPrice_cust_'+n);
				
				sum();
			}
		</script>
		<style type="text/css">
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
				width: auto;
			}
			.dbbs {
				width: 100%;
			}
			.tbbs {
				FONT-SIZE: medium;
				COLOR: blue;
				TEXT-ALIGN: left;
				BORDER: 1PX LIGHTGREY SOLID;
				width: 100%;
				height: 98%;
			}
			.tbbs a {
				font-size: medium;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 25%;
				float: left;
			}
			.txt.c3 {
				width: 75%;
				float: left;
			}
			.txt.c4 {
				width: 5%;
				margin-right:2px;
				float: left;
			}
			.txt.c5 {
				width: 80%;
				float: left;
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
		<div id="dmain" >
			<div class="dview" id="dview">
				<table class="tview" id="tview" border="1" cellpadding="2" cellspacing="0" style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id="vewChk"> </a></td>
						<td align="center" style="width:20%"><a id="vewNoa"> </a></td>
						<td align="center" style="width:20%"><a id="vewDatea"> </a></td>
						<td align="center" style="width:20%"><a id="vewDriver"> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='driver'>~driver</td>

					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm" border="0" cellpadding="2" cellspacing="0">
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblOdate" class="lbl" > </a></td>
						<td><input id="txtOdate" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td><input id="txtDatea" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblCalctype" class="lbl"> </a></td>
                        <td><select id="cmbCalctype" class="txt c1"> </select></td>
                        <td><span> </span><a id="lblCarteam" class="lbl"> </a></td>
                        <td><select id="cmbCarteamno" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDriverno" class="lbl btn" > </a></td>
						<td colspan="3">
							<input id="txtDriverno" type="text" class="txt c2"/>
							<input id="txtDriver" type="text" class="txt c3"/>
						</td>
						<td><span> </span><a id="lblCarno" class="lbl btn" > </a></td>
						<td><input id="txtCarno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTotal_yp" class="lbl" > </a></td>
						<td><input id="textTotal" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblTotal2_yp" class="lbl" > </a></td>
						<td><input id="textTotal2" type="text" class="txt c1 num" /></td>
					</tr>
					<!--<tr>
						<td><span> </span><a id="lblMount" class="lbl" > </a></td>
						<td><input id="txtMount" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblTotal" class="lbl" > </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblWeight" class="lbl" > </a></td>
						<td><input id="txtWeight" type="text" class="txt c1 num" /></td>
					</tr>-->
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>

			<div class="dbbs" style="width: 3100px;">
				<table id="tbbs" class="tbbs" border="1" cellpadding="2" cellspacing="1" >
					<tr style="color:White; background:#003366;" >
						<td align="center" style="width: 1%;"><input class="btn" id="btnPlus" type="button" value="+" style="font-weight: bold;" /></td>
						<td align="center" style="width: 120px;"><a id='lblCustno_s'> </a></td>
						<td align="center" style="width: 50px;"><a id='lblCstype_s'> </a></td>
						<td align="center" style="width: 110px;"><a id='lblStraddr_s_yp'> </a></td>
						<td align="center" style="width: 110px;"><a id='lblEndaddr_s_yp'> </a></td>
						<td align="center" style="width: 120px;"><a id='lblUcc_s'> </a></td>
						<td align="center" style="width: 40px;"><a id='lblFill_s'> </a></td>
						<td align="center" style="width: 40px;"><a id='lblIo_s'> </a></td>
						
						<td align="center" style="width: 100px;"><a id='lblInmount_s'> </a></td>
						<td align="center" style="width: 70px;"><a id='lblUnit_s'> </a></td>
						<td align="center" style="width: 100px;"><a id='lblPton_s'> </a></td>
						<td align="center" style="width: 100px;"><a id='lblPrice_s_yp'> </a></td>
						<td align="center" style="width: 110px;"><a id='lblTotal_s_yp'> </a></td>
						
						<td align="center" style="width: 100px;"><a id='lblOutmount_s'> </a></td>
						<td align="center" style="width: 70px;"><a id='lblUnit2_s'> </a></td>
						<td align="center" style="width: 100px;"><a id='lblPton2_s'> </a></td>
						<td align="center" style="width: 100px;" class="price2"><a id='lblPrice2_s'> </a></td>
						<td align="center" style="width: 100px;" class="price3"><a id='lblPrice3_s'> </a></td>
						<td align="center" style="width: 100px;"><a id='lblDiscount_s'> </a></td>
						<td align="center" style="width: 110px;"><a id='lblTotal2_s'> </a></td>
						
						<td align="center" style="width: 150px;"><a id='lblCaseno_s'> </a></td>
						<td align="center" style="width: 50px;"><a id='lblCasetype_s'> </a></td>
						<td align="center" style="width: 110px;"><a id='lblBoat_s'> </a></td>
						<td align="center" style="width: 100px;"><a id='lblShip_s'> </a></td>
						<td align="center" style="width: 120px;"><a id='lblPo_s'> </a></td>
						<td align="center" style="width: 120px;"><a id='lblCustorde_s'> </a></td>
						<td align="center" style="width: 100px;"><a id='lblBmiles_s'> </a></td>
						<td align="center" style="width: 100px;"><a id='lblEmiles_s'> </a></td>
						<td align="center" style="width: 100px;"><a id='lblMiles_s'> </a></td>
						<td align="center" style="width: 100px;"><a id='lblGps_s'> </a></td>
						<td align="center" ><a id='lblMemo_s'> </a></td>
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center"><input class="btn" id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
						<td>
							<input type="button" class="txt c4" id="btnCustno.*" />
							<input type="text" class="txt c5" id="txtCustno.*" />
							<input type="text" class="txt c1" id="txtComp.*" />
							<input type="text" class="txt c1" style="display:none;" id="txtNick.*" />
							<input type="text" id="txtNoq.*" style="display:none"/>
							<input type="text" id="txtCarno.*" style="display:none"/>
							<input type="text" id="txtDriverno.*" style="display:none"/>
							<input type="text" id="txtDriver.*" style="display:none"/>
						</td>
						<td><select id="cmbCstype.*" class="txt c1" style="font-size: medium;"> </select></td>
						<td>
							<input type="button" class="txt c4" id="btnStraddrno.*" />
							<input type="text" class="txt c5" id="txtStraddrno.*" />
							<input type="text" class="txt c1" id="txtStraddr.*" />
						</td>
						<td>
							<input type="button" class="txt c4" id="btnEndaddrno.*" />
							<input type="text" class="txt c5" id="txtEndaddrno.*" />
							<input type="text" class="txt c1" id="txtEndaddr.*" />
						</td>
						<td>
							<input type="button" class="txt c4" id="btnUccno.*" />
							<input type="text" class="txt c5" id="txtUccno.*" />
							<input type="text" class="txt c1" id="txtProduct.*" />
						</td>
						<td><input type="text" class="txt c1" id="txtFill.*" /></td>
						<td><input type="text" class="txt c1" id="txtIo.*" /></td>
						<td>
							<input type="text" class="txt num c1" id="txtInmount.*" />
							<input type="text" class="txt num c1" id="txtMount.*" style="display: none;" />
						</td>
						<td><input type="text" class="txt c1" id="txtUnit.*" /></td>
						<td><input type="text" class="txt num c1" id="txtPton.*" /></td>
						<td><input type="text" class="txt num c1" id="txtPrice.*" /></td>
						<td><input type="text" class="txt num c1" id="txtTotal.*" /></td>
						
						<td>
							<input type="text" class="txt num c1" id="txtOutmount.*" />
							<input type="text" class="txt num c1" id="txtMount2.*" style="display: none;" />
						</td>
						<td><input type="text" class="txt c1" id="txtUnit2.*" /></td>
						<td class="price2"><input type="text" class="txt num c1" id="txtPton2.*" /></td>
						<td class="price3"><input type="text" class="txt num c1" id="txtPrice2.*" /></td>
						<td><input type="text" class="txt num c1" id="txtPrice3.*" /></td>
						<td><input type="text" class="txt num c1" id="txtDiscount.*" /></td>
						<td><input type="text" class="txt num c1" id="txtTotal2.*" /></td>
						
						<td>
							<input type="text" class="txt c1" id="txtCaseno.*" />
							<input type="text" class="txt c1" id="txtCaseno2.*" />
						</td>
						<td><select id="cmbCasetype.*" class="txt c1" style="font-size: medium;"> </select></td>
						<td>
							<input type="button" class="txt c4" id="btnBoatno.*" />
							<input type="text" class="txt c5" id="txtBoatno.*" />
							<input type="text" class="txt c1" id="txtBoat.*" />
						</td>
						<td><input type="text" class="txt c1" id="txtShip.*" /></td>
						<td><input type="text" class="txt c1" id="txtPo.*" /></td>
						<td><input type="text" class="txt c1" id="txtCustorde.*" /></td>
						<td><input type="text" class="txt num c1" id="txtBmiles.*" /></td>
						<td><input type="text" class="txt num c1" id="txtEmiles.*" /></td>
						<td><input type="text" class="txt num c1" id="txtMiles.*" /></td>
						<td><input type="text" class="txt num c1" id="txtGps.*" /></td>
						<td><input type="text" class="txt c1" id="txtMemo.*" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>