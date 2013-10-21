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
		q_desc = 1;
		q_tables = 's';
		var q_name = "orde";
		var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtTotalus', 'txtSales','txtOrdbno','txtOrdcno'];
		var q_readonlys = ['txtTotal', 'txtQuatno', 'txtNo2', 'txtNo3','txtC1','txtNotv']; 
		var bbmNum = [['txtTotal', 0,0,10],['txtMoney', 0, 0,10]];  // 允許 key 小數
		var bbsNum = [['txtPrice', 12, 3], ['txtMount', 9, 2]];
		var bbmMask = [];
		var bbsMask = [];
		q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'odate';
		//ajaxPath = ""; // 只在根目錄執行，才需設定
		aPop = new Array(['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucaucc_b.aspx'],
		['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
		['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx'],
		['txtCustno', 'lblCust', 'cust', 'noa,comp,paytype,trantype,tel,fax,zip_comp,addr_fact',
				'txtCustno,txtComp,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr', 'cust_b.aspx']);
		$(document).ready(function () {
			bbmKey = ['noa'];
			bbsKey = ['noa', 'no2'];
			q_brwCount();  // 計算 合適  brwCount 
			q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
				
			$('#txtOdate').focus();
		});
		//////////////////   end Ready
		function main() {
			if (dataErr)  /// 載入資料錯誤
			{
				dataErr = false;
				return;
			}
			mainForm(1); // 1=最後一筆  0=第一筆
		}  ///  end Main()
		
		function sum() {
			var t1 = 0, t_unit, t_mount, t_weight = 0;
			for (var j = 0; j < q_bbsCount; j++) {
				t_unit = $('#txtUnit_' + j).val();
				//t_mount = (!t_unit || emp(t_unit) || trim( t_unit).toLowerCase() == 'kg' ?  $('#txtWeight_' + j).val() : $('#txtMount_' + j).val());  // 計價量
				t_mount = $('#txtMount_' + j).val();  // 計價量
				//t_weight = t_weight + dec( $('#txtWeight_' + j).val()) ; // 重量合計
				$('#txtTotal_' + j).val(round(q_mul(dec($('#txtPrice_' + j).val()),dec(t_mount)), 0));
				
				q_tr('txtNotv_'+j ,q_sub( q_float('txtMount_'+j),q_float('txtC1'+j)));
				t1 =q_add( t1, dec($('#txtTotal_' + j).val()));
			}  // j

			$('#txtMoney').val(round(t1, 0));
			if( !emp( $('#txtPrice' ).val()))
				$('#txtTranmoney').val(round(q_mul( t_weight,dec($('#txtPrice').val())), 0));

			// $('#txtWeight').val(round(t_weight, 0));
			q_tr('txtTotal',q_add( t1,dec($('#txtTax').val())));
			q_tr('txtTotalus',q_mul( q_float('txtTotal'),q_float('txtFloata')));

			calTax();
		}

		function mainPost() { // 載入資料完，未 refresh 前
			q_getFormat();
			bbmMask = [['txtOdate', r_picd ]];  
			q_mask(bbmMask);			
			bbsMask = [['txtDatea', r_picd ]];  
			q_cmbParse("cmbStype", q_getPara('orde.stype')); // 需在 main_form() 後執行，才會載入 系統參數  
			q_cmbParse("cmbCoin", q_getPara('sys.coin'));	 /// q_cmbParse 會加入 fbbm
			q_cmbParse("combPaytype", q_getPara('vcc.paytype'));  // comb 未連結資料庫
			q_cmbParse("cmbTrantype", q_getPara('orde.trantype'));
			q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
			
			var t_where = "where=^^ 1=1  group by post,addr^^";
			q_gt('custaddr', t_where, 0, 0, 0, "");
			 
			$('#btnOrdei').hide();//外銷訂單按鈕隱藏
			
			$('#cmbStype').change(function () {
				if($('#cmbStype').find("option:selected").text() == '外銷')
					$('#btnOrdei').show();
				else
					$('#btnOrdei').hide();
			});
			
			$('#btnOrdei').click(function () {
				q_box("ordei.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "';"+r_accy+";" + q_cur, 'ordei', "95%", "95%", q_getMsg('popOrdei'));
			});
			$('#btnQuat').click(function(){
				btnQuat();
			});
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
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}
			});
			
			$('#btnCredit').click(function(){
				if(!emp($('#txtCustno').val())){
					q_box("z_credit.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";custno='" + $('#txtCustno').val() + "';"+r_accy+";" + q_cur, 'ordei', "95%", "95%", q_getMsg('btnCredit'));
				}
			});
		}

		function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、訂單視窗  關閉時執行
			var ret; 
			switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
				case 'quats':
					if (q_cur > 0 && q_cur < 4) {
						b_ret = getb_ret();
						if (!b_ret || b_ret.length == 0)
							return;
						//取得報價的第一筆匯率等資料
						var t_where = "where=^^ noa='" + b_ret[0].noa + "' ^^";
						q_gt('quat', t_where, 0, 0, 0, "", r_accy);
						
						var i, j = 0;
						ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtUnit,txtPrice,txtMount,txtQuatno,txtNo3', b_ret.length, b_ret
															, 'productno,product,spec,unit,price,mount,noa,no3'
															, 'txtProductno,txtProduct,txtSpec');   /// 最後 aEmpField 不可以有【數字欄位】
															sum();
						bbsAssign();
					}
					break;
				
				case q_name + '_s':
					q_boxClose2(s2); ///   q_boxClose 3/4
					break;
			}   /// end Switch
			b_pop = '';
		}
		function browTicketForm(obj) {
			//資料欄位名稱不可有'_'否則會有問題
			if (($(obj).attr('readonly') == 'readonly') || ($(obj).attr('id').substring(0, 3) == 'lbl')) {
				if ($(obj).attr('id').substring(0, 3) == 'lbl')
					obj = $('#txt' + $(obj).attr('id').substring(3));
				var noa = $.trim($(obj).val());
				var openName = $(obj).attr('id').split('_')[0].substring(3).toLowerCase();
				if (noa.length > 0) {
					switch (openName) {
						case 'ordbno':
							q_box("ordb.aspx?;;;noa='" + noa + "';" + r_accy, 'ordb', "95%", "95%", q_getMsg("popOrdb"));
							break;
						case 'ordcno':
							q_box("ordc.aspx?;;;noa='" + noa + "';" + r_accy, 'ordc', "95%", "95%", q_getMsg("popOrdc"));
							break;
						case 'quatno':
							q_box("quat.aspx?;;;noa='" + noa + "';" + r_accy, 'quat', "95%", "95%", q_getMsg("popQuat"));
							break;
					}
				}
			}
		}
		
		var focus_addr='';
		function q_gtPost(t_name) {  /// 資料下載後 ...
			switch (t_name) {
				case 'msg_ucc':
            		var as  = _q_appendData("ucc", "", true);
            		t_msg='';
            		if(as[0]!=undefined){
            			t_msg="銷售單價："+dec(as[0].saleprice)+"<BR>";
            		}
            		//客戶售價
            		var t_where = "where=^^ custno='"+$('#txtCustno').val()+"' and datea<'"+q_date()+"' ^^ stop=1";
					q_gt('quat', t_where , 0, 0, 0, "msg_quat", r_accy);
            		break;
            	case 'msg_quat':
            		var as  = _q_appendData("quats", "", true);
            		var quat_price=0;
					if(as[0]!=undefined){
						for ( var i = 0; i < as.length; i++) {
							if(as[0].productno==$('#txtProductno_'+b_seq).val())
								quat_price=dec(as[i].price);
						}
					}
            		t_msg=t_msg+"最近報價單價："+quat_price+"<BR>";
            		//最新出貨單價
					var t_where = "where=^^ custno='"+$('#txtCustno').val()+"' and noa in (select noa from vccs"+r_accy+" where productno='"+$('#txtProductno_'+b_seq).val()+"' and price>0 ) ^^ stop=1";
					q_gt('vcc', t_where , 0, 0, 0, "msg_vcc", r_accy);
            		break;
            	case 'msg_vcc':
					var as  = _q_appendData("vccs", "", true);
					var vcc_price=0;
					if(as[0]!=undefined){
						for ( var i = 0; i < as.length; i++) {
							if(as[0].productno==$('#txtProductno_'+b_seq).val())
								vcc_price=dec(as[i].price);
						}
					}
					t_msg=t_msg+"最近出貨單價："+vcc_price;
					q_msg( $('#txtPrice_'+b_seq), t_msg);	
					break;
            	case 'msg_stk':
            		var as  = _q_appendData("stkucc", "", true);
            		var stkmount=0;
            		t_msg='';
            		for ( var i = 0; i < as.length; i++) {
            			stkmount=q_add(stkmount,dec(as[i].mount));
            		}
            		t_msg="庫存量："+stkmount;
            		//平均成本
					var t_where = "where=^^ productno ='"+$('#txtProductno_'+b_seq).val()+"' order by datea desc ^^ stop=1";
					q_gt('wcost', t_where , 0, 0, 0, "msg_wcost", r_accy);
            		break;
				case 'msg_wcost':
					var as  = _q_appendData("wcost", "", true);
					var wcost_price;
					if(as[0]!=undefined){
						if(dec(as[0].mount)==0){
							wcost_price=0;
						}else{
							wcost_price=round(q_div(q_add(q_add(q_add(dec(as[0].costa),dec(as[0].costb)),dec(as[0].costc)),dec(as[0].costd)),dec(as[0].mount)),0)
							//wcost_price=round((dec(as[0].costa)+dec(as[0].costb)+dec(as[0].costc)+dec(as[0].costd))/dec(as[0].mount),0);
						}
					}
					if(wcost_price!=undefined){
						t_msg=t_msg+"<BR>平均成本："+wcost_price;
						q_msg( $('#txtMount_'+b_seq), t_msg);	
					}else{
						//原料成本
						var t_where = "where=^^ productno ='"+$('#txtProductno_'+b_seq).val()+"' order by mon desc ^^ stop=1";
						q_gt('costs', t_where , 0, 0, 0, "msg_costs", r_accy);
					}
					break;
				case 'msg_costs':
					var as  = _q_appendData("costs", "", true);
					var costs_price;
					if(as[0]!=undefined){
						costs_price=as[0].price;
					}
					if(costs_price!=undefined){
						t_msg=t_msg+"<BR>平均成本："+costs_price;
					}
					q_msg( $('#txtMount_'+b_seq), t_msg);
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
				case 'quat':
					var as = _q_appendData("quat", "", true);
					if(as[0]!=undefined ){
						$('#txtFloata').val(as[0].floata);
						$('#cmbCoin').val(as[0].coin);
						$('#txtPaytype').val(as[0].paytype);
						$('#txtSalesno').val(as[0].salesno);
						$('#txtSales').val(as[0].sales);
						$('#txtContract').val(as[0].contract);
						$('#cmbTrantype').val(as[0].trantype);
						$('#txtTel').val(as[0].tel);
						$('#txtFax').val(as[0].fax);
						$('#txtPost').val(as[0].post);
						$('#txtAddr').val(as[0].fax);
						$('#txtPost2').val(as[0].post2);
						$('#txtAddr2').val(as[0].fax);
						$('#cmbTaxtype').val(as[0].tel);
						sum();
					}
					break;
				case 'cust':
					var as = _q_appendData("cust", "", true);
					if(as[0]!=undefined && focus_addr !=''){
						$('#'+focus_addr).val(as[0].addr_fact);
						focus_addr = '';
					}
					break;
				case q_name: if (q_cur == 4)   // 查詢
						q_Seek_gtPost();
					break;
			}  /// end switch
		}
		
		function btnQuat() {
			var t_custno = trim($('#txtCustno').val());
			var t_where='';
			if (t_custno.length > 0) {
				//t_where = "enda='N' && " + (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");  ////  sql AND 語法，請用 &&  
				t_where = (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");  ////  sql AND 語法，請用 &&  
				t_where =  t_where ;
			}
			else {
				alert(q_getMsg('msgCustEmp'));
				return;
			}
			q_box("quatst_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'quats', "95%", "95%", q_getMsg('popQuats'));
			//q_box('quatst_b.aspx', 'view_quats;' + t_where, "95%", "650px", q_getMsg('popQuat'));
		}

		function btnOk() {
			t_err = '';
			t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('btnAcomp')]]);  // 檢查空白 
			if (t_err.length > 0) {
				alert(t_err);
				return;
			}
			if(q_cur==1)
				$('#txtWorker').val(r_name);
			else
				$('#txtWorker2').val(r_name);
			sum();

			var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
			if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
				q_gtnoa(q_name, replaceAll(q_getPara('sys.key_orde') + $('#txtOdate').val(), '/', ''));
			else
				wrServer(s1);
		}

		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)  // 1-3
				return;
			q_box('orde_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
		}

		function combPaytype_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
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

		function bbsAssign() {  /// 表身運算式
			for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
				if (!$('#btnMinus_' + j).hasClass('isAssign')) {
					$('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });
					$('#btnProductno_' + j).click(function () {
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						pop('ucc');
					});
					$('#txtProductno_' + j).change(function () {
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						q_change($(this), 'ucc', 'noa', 'noa,product,unit');  /// 接 q_gtPost()
					});
					
					$('#txtUnit_' + j).focusout(function () { sum(); });
					// $('#txtWeight_' + j).focusout(function () { sum(); });
					$('#txtPrice_' + j).focusout(function () { sum(); });
					$('#txtMount_' + j).focusout(function () { sum(); });
					$('#txtTotal_' + j).focusout(function () { sum(); });
					
					$('#txtMount_' + j).focusin (function() {
	                    if(q_cur==1 ||q_cur==2 ){
		                   	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                   q_bodyId($(this).attr('id'));
			                   b_seq = t_IdSeq;
		                   	if(!emp($('#txtProductno_'+b_seq).val())){
		                   		//庫存
								var t_where = "where=^^ ['"+q_date()+"','','') where productno='"+$('#txtProductno_'+b_seq).val()+"' ^^";
								q_gt('calstk', t_where , 0, 0, 0, "msg_stk", r_accy);
		                   	}
	                    }
					});
					$('#txtPrice_' + j).focusin (function() {
						if(q_cur==1 ||q_cur==2 ){
		                   	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
		                   	if(!emp($('#txtProductno_'+b_seq).val())){
		                    	//金額
								var t_where = "where=^^ noa='"+$('#txtProductno_'+b_seq).val()+"' ^^ stop=1";
								q_gt('ucc', t_where , 0, 0, 0, "msg_ucc", r_accy);
		                    }
	                    }
					});
					
					$('#btnBorn_' + j).click(function () {
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						t_where = "noa='"+$('#txtNoa').val()+"' and no2='"+$('#txtNo2_'+b_seq).val()+"'";
						q_box("z_born.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'born', "95%", "95%", q_getMsg('lblBorn'));
					});
					$('#btnNeed_' + j).click(function () {
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						t_where = "noa='"+$('#txtNoa').val()+"' and no2='"+$('#txtNo2_'+b_seq).val()+"'";
						q_box("z_vccneed.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'Need', "95%", "95%", q_getMsg('lblNeed'));
					});
					
					$('#btnVccrecord_' + j).click(function () {
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						t_where = "cust='"+$('#txtCustno').val()+"' and noq='"+$('#txtProductno_'+b_seq).val()+"'";
						q_box("z_vccrecord.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccrecord', "95%", "95%", q_getMsg('lblRecord_s'));
					});
				}
			} //j
			_bbsAssign();
		}

		function btnIns() {
			_btnIns();
			$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
			$('#txtCno').val('1');
			$('#txtAcomp').val(r_comp.substr(0, 2));
			$('#txtOdate').val(q_date());
			$('#txtOdate').focus();
			
			var t_where = "where=^^ 1=1  group by post,addr^^";
			q_gt('custaddr', t_where, 0, 0, 0, "");
		}
		function btnModi() {
			if (emp($('#txtNoa').val()))
				return;
			_btnModi();
			$('#txtOdate').focus();
			
			if(!emp($('#txtCustno').val())){
				var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
				q_gt('custaddr', t_where, 0, 0, 0, "");
			}
		}
		function btnPrint() {
			q_box('z_ordep.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
		}
		
		function wrServer( key_value) {
			var i;
			$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
			xmlSql = '';
			if (q_cur == 2)   /// popSave
				xmlSql = q_preXml();

			_btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
		}

		function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
			if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) {  //不存檔條件
				as[bbsKey[1]] = '';   /// no2 為空，不存檔
				return;
			}
			q_nowf();
			as['type'] = abbm2['type'];
			as['mon'] = abbm2['mon'];
			as['noa'] = abbm2['noa'];
			as['odate'] = abbm2['odate'];
			
			if (!emp(abbm2['datea']))  /// 預交日
				as['datea'] = abbm2['datea'];

			as['custno'] = abbm2['custno'];
			as['comp'] = abbm2['comp'];

			if (!as['enda'])
				as['enda'] = 'N';
			t_err ='';
			if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
				t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';

			if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
				t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

			
			if (t_err) {
				alert(t_err);
				return false;
			}
			
			return true;
		}
		
		///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
		function refresh(recno) {
			_refresh(recno);
			$('input[id*="txt"]').click(function(){
				browTicketForm($(this).get(0));
			});
			if($('#cmbStype').find("option:selected").text() == '外銷')
				$('#btnOrdei').show();
			else
				$('#btnOrdei').hide();
		}

		function readonly(t_para, empty) {
			_readonly(t_para, empty);
			if(t_para){
				$('#btnOrdei').removeAttr('disabled');
				$('#combAddr').attr('disabled','disabled');
			}else{
				$('#btnOrdei').attr('disabled','disabled');
				$('#combAddr').removeAttr('disabled');
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

		function btnSeek(){
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
		
		function q_popPost(s1) {
		    	switch (s1) {
			        case 'txtCustno':
		    			if(!emp($('#txtCustno').val())){
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
							q_gt('custaddr', t_where, 0, 0, 0, "");
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
				float: left;
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
<!--#include file="../inc/toolbar.inc"-->
	<div id='dmain' style="overflow:hidden;">
		<div class="dview" id="dview">
			<table class="tview" id="tview">
				<tr>
					<td align="center" style="width:5%"><a id='vewChk'> </a></td>
					<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
					<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
					<td align="center" style="width:40%"><a id='vewComp'> </a></td>
				</tr>
				<tr>
					<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
					<td align="center" id='odate'>~odate</td>
					<td align="center" id='noa'>~noa</td>
					<td align="center" id='custno comp,4'>~custno ~comp,4</td>
				</tr>
			</table>
		</div>
		<div class='dbbm'>
			<table class="tbbm"  id="tbbm" style="width: 872px;">
				<tr class="tr1">
					<td class="td1" style="width: 108px;"><span> </span><a id='lblStype' class="lbl"> </a></td>
					<td class="td2" style="width: 108px;"><select id="cmbStype" class="txt c1"> </select></td>
					<td class="td3" style="width: 108px;"><input id="btnOrdei" type="button" /></td>
					<td class="td4" style="width: 108px;"><span> </span><a id='lblOdate' class="lbl"> </a></td>
					<td class="td5" style="width: 108px;"><input id="txtOdate"  type="text"  class="txt c1"/></td>
					<td class="td6" style="width: 108px;"> </td>
					<td class="td7" style="width: 108px;"><span> </span><a id='lblNoa' class="lbl"> </a></td>
					<td class="td8" style="width: 108px;"><input id="txtNoa"   type="text" class="txt c1"/></td> 
				</tr>
				<tr class="tr2">
					<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
					<td class="td2" colspan="2"><input id="txtCno"  type="text" class="txt c4"/>
					<input id="txtAcomp" type="text" class="txt c5"/></td>
					<td class="td4"><span> </span><a id='lblFloata' class="lbl"> </a></td>
					<td class="td5"><select id="cmbCoin"class="txt c1"> </select></td>				
					<td class="td6"><input id="txtFloata" type="text" class="txt c1" /></td>
					<td align="center" class="td7" colspan="2" >
						<input id="btnQuat" type="button" value='' />
						<input id="btnCredit" type="button" value='' />
					</td>				 
				</tr>
				<tr class="tr3">
					<td class="td1"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
					<td class="td2" colspan="2"><input id="txtCustno" type="text" class="txt c4"/>
					<input id="txtComp"  type="text" class="txt c5"/></td>
					<td class="td4"><span> </span><a id='lblPaytype' class="lbl"> </a></td>
					<td class="td5"><input id="txtPaytype" type="text" class="txt c1"/></td> 
					<td class="td6"><select id="combPaytype" class="txt c1" onchange='combPaytype_chg()' > </select></td> 
					<td class="td7"><span> </span><a id='lblContract' class="lbl"> </a></td>
					<td class="td8"><input id="txtContract"  type="text" class="txt c1"/></td> 
				</tr>
				<tr class="tr4">
					<td class="td1"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
					<td class="td2" colspan="2"><input id="txtSalesno" type="text" class="txt c4"/> 
					<input id="txtSales" type="text" class="txt c5"/></td> 
					<td class="td4"><span> </span><a id='lblTel' class="lbl"> </a></td>
					<td class="td5" colspan='2'><input id="txtTel" type="text" class="txt c1"/></td>
					<td class="td7"><span> </span><a id='lblOrdbno' class="lbl"> </a></td>
					<td class="td8"><input id="txtOrdbno" type="text" class="txt c1"/></td> 
				</tr>
				<tr class="tr5">
					<td class="td1"><span> </span><a id='lblFax' class="lbl"> </a></td>
					<td class="td2" colspan="2"><input id="txtFax" type="text" class="txt c1" /></td>
					<td class="td4"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
					<td class="td5" colspan="2"><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
					<td class="td7"><span> </span><a id='lblOrdcno' class="lbl"> </a></td>
					<td class="td8"><input id="txtOrdcno" type="text" class="txt c1"/></td>
				</tr>
				<tr class="tr6">
					<td class="td1"><span> </span><a id='lblAddr' class="lbl"> </a></td>
					<td class="td2"><input id="txtPost" type="text" class="txt c1"/></td>
					<td class="td3"colspan='4' ><input id="txtAddr"  type="text"  class="txt c1"/></td>
					 <td class="td1"><span> </span><a id='lblTotalus' class="lbl"> </a></td>
					<td class="td2" ><input id="txtTotalus" type="text" class="txt num c1"/></td> 
				</tr>
				<tr class="tr7">
					<td class="td1"><span> </span><a id='lblAddr2' class="lbl"> </a></td>
					<td class="td2"><input id="txtPost2"  type="text" class="txt c1"/></td>
					<td class="td3" colspan='4' >
						<input id="txtAddr2"  type="text" class="txt c1" style="width: 412px;"/>
						<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
					</td>
					<td class="td7"><span> </span><a id='lblEnda' class="lbl"> </a></td>
					<td class="td8"><input id="chkEnda" type="checkbox"/></td> 
				</tr>
				<tr class="tr8">
					<td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
					<td class="td2" colspan='2'><input id="txtMoney" type="text" class="txt c1" style="text-align: center;"/></td> 
					<td class="td4"><span> </span><a id='lblTax' class="lbl"> </a></td>
					<td class="td5"><input id="txtTax" type="text" class="txt num c1"/></td>
					<td class="td6"><select id="cmbTaxtype" class="txt c1"  onchange='sum()' > </select></td>
					<td class="td7"><span> </span><a id='lblTotal' class="lbl"> </a></td>
					<td class="td8"><input id="txtTotal" type="text" class="txt num c1"/></td> 
				</tr>
				<tr class="tr10">
					<td class="td1"><span> </span><a id="lblApv" class="lbl"> </a></td>
					<td class="td2" colspan='2'><input id="txtApv" type="text"  class="txt c1" disabled="disabled"/></td>
					<td class="td3"><span> </span><a id='lblWorker' class="lbl"> </a></td>
					<td class="td4"><input id="txtWorker" type="text" class="txt c1" /></td>
					<td class="td5"><input id="txtWorker2" type="text" class="txt c1" /></td> 
				</tr>
				<tr class="tr11">
					<td class="td1"><span> </span><a id='lblMemo' class='lbl'> </a></td>
					<td class="td2" colspan='7'>
						<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
					</td> 
				</tr>
			</table>
		</div>
	</div>
	<div class='dbbs' >
		<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'>
			<tr style='color:White; background:#003366;' >
				<td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
				<td align="center"><a id='lblProductno'> </a></td>
				<td align="center"><a id='lblProduct_s'> </a></td>
				<td align="center"><a id='lblUnit'> </a></td>
				<td align="center"><a id='lblMount'> </a></td>
				<td align="center"><a id='lblPrices'> </a></td>
				<td align="center"><a id='lblTotal_s'> </a></td>
				<td align="center"><a id='lblGemounts'> </a></td>
				<td align="center"><a id='lblMemos'> </a></td>
				<td align="center"><a id='lblDateas'> </a></td>
				<td align="center"><a id='lblEndas'> </a></td>
				<td align="center"><a id='lblBorn'> </a></td>
				<td align="center"><a id='lblNeed'> </a></td>
				<td align="center"><a id='lblVccrecord'> </a></td>
			</tr>
			<tr style='background:#cad3ff;'>
				<td style="width:1%;">
					<input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" />
				</td>
				<td style="width:10%; text-align:center">
					<input class="txt c6"  id="txtProductno.*" maxlength='30'type="text" style="width:98%;" />
					<input class="btn"  id="btnProduct.*" type="button" value='...' style=" font-weight: bold;" />
					<input class="txt c6"  id="txtNo2.*" type="text" />
				</td>
				<td style="width:12%;">
					<input class="txt c7" id="txtProduct.*" type="text" />
				</td>
				<td style="width:4%;">
					<input class="txt c7" id="txtUnit.*" type="text"/>
				</td>
				<td style="width:6%;">
					<input class="txt num c7" id="txtMount.*" type="text" />
				</td>
				<td style="width:6%;">
					<input class="txt num c7" id="txtPrice.*" type="text"  />
				</td>
				<td style="width:8%;">
					<input class="txt num c7" id="txtTotal.*" type="text" />
				</td>
				<td style="width:8%;">
					<input class="txt num c1" id="txtC1.*" type="text" />
					<input class="txt num c1" id="txtNotv.*" type="text" />
				</td>
				<td style="width:12%;">
					<input class="txt c7" id="txtMemo.*" type="text" />
					<input class="txt" id="txtQuatno.*" type="text" style="width: 70%;" />
					<input class="txt" id="txtNo3.*" type="text"  style="width: 20%;"/>
					<input id="recno.*" type="hidden" />
				</td>
				<td style="width:6%;">
					<input class="txt c7" id="txtDatea.*" type="text"  />
				</td>
				<td style="width:3%;" align="center">
					<input id="chkEnda.*" type="checkbox"/>
				</td>
				<td style="width:3%;" align="center">
					<input class="btn"  id="btnBorn.*" type="button" value='.' style=" font-weight: bold;" />
				</td>
				<td style="width:3%;" align="center">
					<input class="btn"  id="btnNeed.*" type="button" value='.' style=" font-weight: bold;" />
				</td>
				<td style="width:3%;" align="center">
					<input class="btn"  id="btnVccrecord.*" type="button" value='.' style=" font-weight: bold;" />
				</td>
			</tr>
		</table>
	</div>
	<input id="q_sys" type="hidden" />
</body>
</html>

