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
		var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtSales','txtOrdbno','txtOrdcno','txtQuatno','textStatus'];
		var q_readonlys = ['txtTotal', 'txtQuatno', 'txtNo2', 'txtNo3','txtC1','txtNotv']; 
		var bbmNum = [['txtTotal', 10,0,1],['txtMoney', 10, 0,1],['txtTax', 10, 0,1]];  // 允許 key 小數
		var bbsNum = [['txtPrice', 12, 3,1], ['txtMount', 9, 2,1],['txtTotal', 10, 0,1],['txtC1', 10, 0,1],['txtNotv', 10, 0,1]];
		var bbmMask = [];
		var bbsMask = [];
		q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'odate';brwCount2 = 11; 
		//ajaxPath = ""; // 只在根目錄執行，才需設定
		aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product,unit,groupano,saleprice', 'txtProductno_,txtProduct_,txtUnit_,cmbType_,txtRadius_,txtLengthb_', 'ucc_b.aspx'],
		['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
		['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx'],
		['txtCustno', 'lblCust', 'cust', 'noa,nick,paytype,trantype,tel,fax,zip_comp,addr_comp,salesno,sales',
				'txtCustno,txtComp,txtPaytype,cmbTrantype,txtTel,txtFax,txtPost,txtAddr,txtSalesno,txtSales', 'cust_b.aspx']);
		$(document).ready(function () {
			bbmKey = ['noa'];
			bbsKey = ['noa', 'no2'];
			q_brwCount();  // 計算 合適  brwCount 
			q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST
			q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
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
			var t1 = 0, t_unit, t_mount, t_weight = 0,t_tmount=0;
			for (var j = 0; j < q_bbsCount; j++) {
				t_unit = $('#txtUnit_' + j).val();
				t_mount = $('#txtLengthb_' + j).val();  
				//總價=數量*單價-折讓
                $('#txtTotal_' + j).val(q_sub(round(q_mul(q_float('txtPrice_' + j),dec(t_mount)), 0),q_float('txtDime_' + j)));
                t1 =q_add( t1, dec($('#txtTotal_' + j).val()));
                //實際數量=數量+贈品
           		$('#txtMount_'+j).val(q_add(q_float('txtLengthb_' + j),q_float('txtWidth_' + j)));
				t_tmount=q_add(t_tmount , dec(q_float('txtMount_' + j)));
				q_tr('txtNotv_'+j ,q_sub( q_float('txtMount_'+j),q_float('txtC1'+j)));
			}  // j

			$('#txtMoney').val(round(t1, 0));
			if( !emp( $('#txtPrice' ).val()))
				$('#txtTranmoney').val(round(q_mul( t_tmount,dec($('#txtPrice').val())), 0));
			
			calTax();
		}

		function mainPost() { // 載入資料完，未 refresh 前
			q_getFormat();
			bbmMask = [['txtOdate', r_picd ],['txtMon', r_picm ]];  
			q_mask(bbmMask);			
			bbsMask = [['txtDatea', r_picd ]];  
			//q_cmbParse("cmbStype", q_getPara('orde.stype_uu')); // 需在 main_form() 後執行，才會載入 系統參數
			q_cmbParse("cmbStype", q_getPara('orde.stype'));  
			//q_cmbParse("cmbCoin", q_getPara('sys.coin'));	 /// q_cmbParse 會加入 fbbm
			q_cmbParse("combPaytype", q_getPara('vcc.paytype'));  // comb 未連結資料庫
			q_cmbParse("cmbTrantype", q_getPara('sys.tran'));
			q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
			q_gt('uccga', '', 0, 0, 0, "");
			q_cmbParse("combworker", 'O@業助O,L@業助L');
			
			var t_where = "where=^^ 1=1 ^^";
			q_gt('custaddr', t_where, 0, 0, 0, "");
			//$('#txtFloata').change(function () {sum();});
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
					q_box("z_credit.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";custno='" + $('#txtCustno').val() + "';"+r_accy+";" + q_cur, 'credit', "95%", "95%", q_getMsg('btnCredit'));
				}
			});
			$('#txtPaytype').change(function(){
				changeMon();
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
							q_box("vcc_uu.aspx?;;;noa='" + noa + "';" + r_accy, 'quat', "95%", "95%", q_getMsg("popVcc"));
							break;
					}
				}
			}
		}
		
		var focus_addr='';
		var z_cno=r_cno,z_acomp=r_comp,z_nick=r_comp.substr(0,2);
		function q_gtPost(t_name) {  /// 資料下載後 ...
			switch (t_name) {
				case 'umms':
						var as = _q_appendData("umms", "", true);
						var z_msg = "", t_paysale = 0,t_tpaysale=0;
						if (as[0] != undefined) {
							for (var i = 0; i < as.length; i++) {
								t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								t_tpaysale+= parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								if (t_paysale != 0)
									z_msg += (as[i].noa+';');
							}
							
							if (z_msg.length > 0) {
								z_msg='已收款：'+FormatNumber(t_tpaysale)+'，收款單號【'+z_msg.substr(0,z_msg.length-1)+ '】。 '
							}
						}else{
							z_msg='未收款。'
						}
						$('#textStatus').val(z_msg);
						break;
				case 'btnModi':
						var as = _q_appendData("umms", "", true);
						if (as[0] != undefined) {
							var z_msg = "", t_paysale = 0;
							for (var i = 0; i < as.length; i++) {
								t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								if (t_paysale != 0)
									z_msg += String.fromCharCode(13) + '收款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
							}
							if (z_msg.length > 0) {
								alert('出貨單已沖帳:' + z_msg);
								Unlock(1);
								return;
							}
						}
						
						_btnModi();
						Unlock(1);
						$('#txtOdate').focus();
						
						if(!emp($('#txtCustno').val())){
							var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
							q_gt('custaddr', t_where, 0, 0, 0, "");
						}
						
						break;
				case 'btnDele':
						var as = _q_appendData("umms", "", true);
						if (as[0] != undefined) {
							var z_msg = "", t_paysale = 0;
							for (var i = 0; i < as.length; i++) {
								t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
								if (t_paysale != 0)
									z_msg += String.fromCharCode(13) + '收款單號【' + as[i].noa + '】 ' + FormatNumber(t_paysale);
							}
							if (z_msg.length > 0) {
								alert('出貨單已沖帳:' + z_msg);
								Unlock(1);
								return;
							}
						}
						_btnDele();
						Unlock(1);
						break;
				case 'getmaxnoa'://找編號最大值
					var as = _q_appendData("orde", "", true);
					var maxnumber=0;//目前最大值
					var autonumber='0000';//流水編號
					if (as[0] != undefined) {
						for ( var i = 0; i < as.length; i++) {
							if(maxnumber<parseInt(as[i].noa.substring(as[i].noa.length-autonumber.length,as[i].noa.length)))
								maxnumber=as[i].noa.substring(as[i].noa.length-autonumber.length,as[i].noa.length)
						}
					}
					
					maxnumber=autonumber+(parseInt(maxnumber)+1);
					maxnumber=maxnumber.substring(maxnumber.length-autonumber.length,maxnumber.length);
					
					wrServer(replaceAll($('#combworker').val()+ $('#txtOdate').val().substr(0,6), '/', '')+maxnumber);
					//q_gtnoa(q_name, replaceAll($('#combworker').val()+ $('#txtOdate').val().substr(0,6), '/', ''));
					break;
				case 'cno_acomp':
                	var as = _q_appendData("acomp", "", true);
                	if (as[0] != undefined) {
	                	z_cno=as[0].noa;
	                	z_acomp=as[0].acomp;
	                	z_nick=as[0].nick;
	                }
                	break;
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
						//$('#txtFloata').val(as[0].floata);
						//$('#cmbCoin').val(as[0].coin);
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
				case 'uccga'://大類
					var as = _q_appendData("uccga", "", true);
					if (as[0] != undefined) {
						var t_item = " @ ";
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
						}
						q_cmbParse("cmbType",t_item,'s');
						
						refresh(q_recno);						
					}
					break;
				case q_name: if (q_cur == 4)   // 查詢
						q_Seek_gtPost();
					break;
			}  /// end switch
		}
		
		function btnOk() {
			t_err = '';
			t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('btnAcomp')]]);  // 檢查空白 
			if (t_err.length > 0) {
				alert(t_err);
				return;
			}
			changeMon();
			if(q_cur==1)
				$('#txtWorker').val(r_name);
			else
				$('#txtWorker2').val(r_name);
			sum();
			
			if($('#checkTotalus').prop("checked")){
				$('#txtTotalus').val(1);
				$('#chkEnda').prop("checked",false);
			}else{
				$('#txtTotalus').val(0);
			}

			var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
			if (s1.length == 0 || s1 == "AUTO"){   /// 自動產生編號
				q_gt('orde', "where=^^ right(left(noa,6),5)='"+replaceAll($('#txtOdate').val().substr(0,6), '/', '')+"'^^", 0, 0, 0, 'getmaxnoa', r_accy);
			}else
				wrServer(s1);
		}

		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)  // 1-3
				return;
			q_box('orde_uu_s.aspx', q_name + '_s', "500px", "520px", q_getMsg("popSeek"));
		}

		function changeMon(){
			var pati1 = /[0-9]{1,}(天)$/g; //判斷輸入的單位是否為天
			var pati2 = /[0-9]{1,}(月|個月)$/g; //判斷輸入的單位是否為月
			var pati3 = /[0-9]{1,}/g; //判斷是否有數字
			var thisVal = '';
			var thisdatea = $.trim($('#txtOdate').val());
			var txtVal = $.trim($('#txtPaytype').val());
			var newMon = '';
			thisVal = txtVal;
			if(!pati3.test(thisVal)){
				if(thisVal.length == 0){
					thisdatea = (dec(thisdatea.substring(0,3))+1911) +thisdatea.substr(3); 
					var d=new Date(thisdatea);
					d.setMonth(d.getMonth() + 6);
					newMon = (dec(d.getFullYear())-1911)+'/'+padL((1+d.getMonth()),'0',2);
				}else{
					newMon = $.trim(thisdatea).substring(0,6);
				}
			}else{
				if(thisVal.match(pati1) != null){
					thisVal = thisVal.match(pati1)[0];
					thisVal = thisVal.replace(/天/g);
					thisVal = dec(thisVal);
					thisdatea = (dec(thisdatea.substring(0,3))+1911) +thisdatea.substr(3); 
					var d=new Date(thisdatea);
					d.setDate(d.getDate()+thisVal);
					newMon = (dec(d.getFullYear())-1911)+'/'+padL((1+d.getMonth()),'0',2);
				}else if(thisVal.match(pati2) != null){
					thisVal = thisVal.match(pati2)[0];
					thisVal = thisVal.replace(/[月|個月]/g);
					thisVal = dec(thisVal);
					thisdatea = (dec(thisdatea.substring(0,3))+1911) +thisdatea.substr(3); 
					var d=new Date(thisdatea);
					d.setMonth(d.getMonth() + thisVal);
					newMon = (dec(d.getFullYear())-1911)+'/'+padL((1+d.getMonth()),'0',2);
				}else{
					newMon = $.trim(thisdatea).substring(0,6);
				}
			}
			$('#txtMon').val(newMon);
		}

		function combPay_chg() {/// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
			var cmb = document.getElementById("combPaytype");
			if (!q_cur){
				cmb.value = '';
			}else{
				$('#txtPaytype').val(cmb.value);
				changeMon();
			}
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
					
					$('#txtUnit_' + j).focusout(function () { sum(); });
					$('#txtPrice_' + j).focusout(function () { sum(); });
					$('#txtMount_' + j).focusout(function () { sum(); });
					
					$('#txtDime_' + j).focusout(function () { sum(); });
					$('#txtWidth_' + j).focusout(function () { sum(); });
					$('#txtLengthb_' + j).focusout(function () { sum(); });
					
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
					/*
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
					*/
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
			$('#chkIsproj').attr('checked',true);
			$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
			$('#txtCno').val(z_cno);
			$('#txtAcomp').val(z_acomp);
			$('#txtOdate').val(q_date());
			$('#txtOdate').focus();
			$('#cmbTaxtype').val('3');
			
			//0403 如果是葉小姐 代O 劉小姐 代L
			if(r_userno=='06')
				$('#combworker').val('O');
			if(r_userno=='13')
				$('#combworker').val('L');
				
			var t_where = "where=^^ 1=1  ^^";
			q_gt('custaddr', t_where, 0, 0, 0, "");
		}
		function btnModi() {
			if (emp($('#txtNoa').val()))
				return;
			//0207權限小於8, 隔月不能修改刪除
			//0210 因業務離職所以暫時先開放給劉小姐修改
			//0211 只要鎖定銷貨→表示已賣出
			if(r_rank<8 && $('#txtOdate').val().substr(0,6)<q_date().substr(0,6)&&r_userno!='13' && $('#cmbStype').val()=='1'){
				alert("隔月訂單禁止修改!!");
				return;
			}
			
			if(!emp($('#txtQuatno').val())){
				Lock(1, {
					opacity : 0
				});
				
				var t_where = " where=^^ vccno='" + $('#txtQuatno').val() + "'^^";
				q_gt('umms', t_where, 0, 0, 0, 'btnModi', r_accy);
				
			}else{
				_btnModi();
				$('#txtOdate').focus();
				
				if(!emp($('#txtCustno').val())){
					var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
					q_gt('custaddr', t_where, 0, 0, 0, "");
				}	
			}
		}
		function btnPrint() {
			q_box('z_ordep_uu.aspx' + "?;;;noa="+trim($('#txtNoa').val())+";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
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
			as['mon'] = abbm2['mon'];
			as['noa'] = abbm2['noa'];
			as['odate'] = abbm2['odate'];
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
			
			if(!emp($('#txtQuatno').val())){
				var t_where = " where=^^ vccno='" + $('#txtQuatno').val() + "'^^";
				q_gt('umms', t_where, 0, 0, 0, '', r_accy);
			}
			
			$('#combworker').val($('#txtNoa').val().substring(0,1));
				
			if($('#txtTotalus').val()==1)
				$("#checkTotalus").prop("checked",true);
			else
				$("#checkTotalus").prop("checked",false);
		}

		function readonly(t_para, empty) {
			_readonly(t_para, empty);
			if(t_para){
				$('#combAddr').attr('disabled','disabled');
				$('#checkTotalus').attr('disabled','disabled');
			}else{
				$('#combAddr').removeAttr('disabled');
				$('#checkTotalus').removeAttr('disabled');
			}
			if(q_cur==1){
				$('#combworker').removeAttr('disabled');
			}else{
				$('#combworker').attr('disabled','disabled');
			}
			$('.cbtype').attr('disabled','disabled');
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
			//0207權限小於8, 隔月不能修改刪除
			if(r_rank<8 && $('#txtOdate').val().substr(0,6)<q_date().substr(0,6)){
				alert("隔月訂單禁止刪除!!");
				return;
			}
			
			if(!emp($('#txtQuatno').val())){
				Lock(1, {
					opacity : 0
				});
					
				var t_where = " where=^^ vccno='" + $('#txtQuatno').val() + "'^^";
				q_gt('umms', t_where, 0, 0, 0, 'btnDele', r_accy);
			}else{
				_btnDele();
			}
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
					changeMon();
					break;
				case 'txtProductno_':
					$('#txtLengthb_'+b_seq).focus();
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
<!--#include file="../inc/toolbar.inc"-->
	<div id='dmain' style="overflow:hidden;width: 1270px;">
		<div class="dview" id="dview">
			<table class="tview" id="tview">
				<tr>
					<td align="center" style="width:5%"><a id='vewChk'> </a></td>
					<td align="center" style="width:25%"><a id='vewOdate'> </a></td>
					<td align="center" style="width:15%"><a id='vewStype'> </a></td>
					<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
					<td align="center" style="width:25%"><a id='vewComp'> </a></td>
				</tr>
				<tr>
					<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
					<td align="center" id='odate'>~odate</td>
					<td align="center" id='stype=orde.stype'>~stype=orde.stype</td>
					<td align="center" id='noa'>~noa</td>
					<td align="center" id='comp,4' style="text-align: left;" >~comp,4</td>
				</tr>
			</table>
		</div>
		<div class='dbbm'>
			<table class="tbbm"  id="tbbm" style="width: 872px;">
				<tr class="tr1" style="height: 0px">
					<td class="td1" style="width: 108px;"> </td>
					<td class="td2" style="width: 108px;"> </td>
					<td class="td3" style="width: 108px;"> </td>
					<td class="td4" style="width: 108px;"> </td>
					<td class="td5" style="width: 108px;"> </td>
					<td class="td6" style="width: 108px;"> </td>
					<td class="td7" style="width: 108px;"> </td>
					<td class="td7" style="width: 108px;"> </td>
				</tr>
				<tr class="tr1">
					<td class="td1"><span> </span><a id='lblOdate' class="lbl"> </a></td>
					<td class="td2"><input id="txtOdate"  type="text"  class="txt c1"/></td>
					<td class="td3"><span> </span><a id='lblStype' class="lbl"> </a></td>
					<td class="td4"><select id="cmbStype" class="txt c1"> </select></td>
					<td class="td5"><span> </span><a id='lblCworker' class="lbl"> </a></td>
					<td class="td8"><select id="combworker" class="txt c1"> </select></td> 
					<td class="td5"><span> </span><a id='lblNoa' class="lbl"> </a></td> 
					<td class="td6"><input id="txtNoa"   type="text" class="txt c1"/></td>
				</tr>
				<tr class="tr2">
					<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
					<td class="td2"><input id="txtCno"  type="text" class="txt c1"/></td>
					<td class="td3" colspan="2"><input id="txtAcomp" type="text" class="txt c1"/></td>
					<td class="td5"><span> </span><a id='lblPostname' class="lbl"> </a></td>
					<td class="td6"><input id="txtPostname" type="text" class="txt c1"/></td> 
					<td class="td7" ><span> </span><a id='lblMon' class="lbl"> </a></td>
					<td class="td8"><input id="txtMon"  type="text" class="txt c1"/></td>
				</tr>

				<tr class="tr3">
					<td class="td1"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
					<td class="td2"><input id="txtCustno" type="text" class="txt c1"/></td>
					<td class="td3" colspan="2"><input id="txtComp"  type="text" class="txt c1"/></td>
					<td class="td5"><span> </span><a id='lblPaytype' class="lbl"> </a></td>
					<td class="td6"><input id="txtPaytype" type="text" class="txt c1"/></td> 
					<td class="td7"><select id="combPaytype" class="txt c1" onchange='combPay_chg()' > </select></td> 
					<td class="td8" align="center"><input id="btnCredit" type="button" value='' /></td>
				</tr>
				
				<tr class="tr4">
					<td class="td1"><span> </span><a id='lblTel' class="lbl"> </a></td>
					<td class="td2" colspan='3'><input id="txtTel" type="text" class="txt c1"/></td>
					<td class="td3"><span> </span><a id='lblFax' class="lbl"> </a></td>
					<td class="td4"><input id="txtFax" type="text" class="txt c1" /></td>
					<td class="td7" ><span> </span><a id='lblContract' class="lbl"> </a></td>
					<td class="td8"><input id="txtContract"  type="text" class="txt c1"/></td>
				</tr>
				<tr class="tr5">
					<td class="td1"><span> </span><a id='lblAddr' class="lbl"> </a></td>
					<td class="td2"><input id="txtPost" type="text" class="txt c1"/></td>
					<td class="td3" colspan='4' ><input id="txtAddr"  type="text"  class="txt c1"/></td>
					<td class="td7" colspan='2' >
						<a id='lblTotalus' class="lbl" style="float: right;"> </a>
						<input id="checkTotalus" type="checkbox" style="float: right;"/>
						<input id="txtTotalus"  type="hidden" class="txt c1"/>
					</td>
				</tr>
				<tr class="tr6">
					<td class="td1"><span> </span><a id='lblAddr2' class="lbl"> </a></td>
					<td class="td2"><input id="txtPost2"  type="text" class="txt c1"/></td>
					<td class="td3" colspan='4' >
						<input id="txtAddr2"  type="text" class="txt c1" style="width: 412px;"/>
						<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
					</td>
					<td class="td7"><span> </span><a id='lblQuatno' class="lbl"> </a></td>
					<td class="td8"><input id="txtQuatno" type="text" class="txt c1"/></td>
				</tr>
				<tr class="tr7">
					<td class="td1"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
					<td class="td2" colspan="2"><select id="cmbTrantype" class="txt c1" name="D1" > </select></td>
					<td class="td4"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
					<td class="td5" colspan="2">
						<input id="txtSalesno" type="text" class="txt c2"/> 
						<input id="txtSales" type="text" class="txt c3"/>
					</td> 
					<td class="td7"><span> </span><a id="lblApv" class="lbl"> </a></td>
					<td class="td8" ><input id="txtApv" type="text"  class="txt c1" disabled="disabled"/></td>
				</tr>
				<tr class="tr8">
					<td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
					<td class="td2" colspan='2'><input id="txtMoney" type="text" class="txt num c1"/></td> 
					<td class="td4"><span> </span><a id='lblTax' class="lbl"> </a></td>
					<td class="td5"><input id="txtTax" type="text" class="txt num c1"/></td>
					<td class="td6"><select id="cmbTaxtype" class="txt c1"  onchange='sum()' > </select></td>
					<td class="td7"><span> </span><a id='lblTotal' class="lbl"> </a></td>
					<td class="td8"><input id="txtTotal" type="text" class="txt num c1"/></td> 
				</tr>
				
				<tr class="tr10">
					<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
					<td class="td2" colspan='2'><input id="txtWorker" type="text" class="txt c1" /></td>
					<td class="td4"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
					<td class="td6" colspan='2'><input id="txtWorker2" type="text" class="txt c1" /></td> 
					<td class="td7">
						<a id='lblIsproj' class="lbl" > </a>
						<input id="chkIsproj" type="checkbox" style="float: right;"/>
					</td>
					<td class="td8">
						<a id='lblEnda' class="lbl" > </a>
						<input id="chkEnda" type="checkbox" style="float: right;"/>
					</td>
				</tr>
				<tr class="tr11">
					<td class="td1"><span> </span><a id='lblMemo' class='lbl'> </a></td>
					<td class="td2" colspan='7'>
						<textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea>
					</td> 
				</tr>
				<tr class="tr12">
					<td class="td1"><span> </span><a class="lbl">收款情況</a></td>
					<td class="td2" colspan='7'><input id="textStatus" type="text" class="txt c1"/></td> 
				</tr>
			</table>
		</div>
	</div>
	<div class='dbbs' style="width: 1260px;">
		<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'>
			<tr style='color:White; background:#003366;' >
				<td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
				<td align="center" style="width:10%;"><a id='lblProductno'> </a></td>
				<td align="center" style="width:12%;"><a id='lblProduct_s'> </a></td>
				<td align="center" style="width:6%;"><a id='lblTypea_s'> </a></td>
				<td align="center" style="width:4%;"><a id='lblUnit'> </a></td>
				<td align="center" style="width:6%;"><a id='lblMount'> </a></td><!--數量隱藏用lengthb當數量當存檔時要將lengthb+width寫回mount-->
				<td align="center" style="width:6%;"><a id='lblWidth_s'> </a></td><!--贈品-->
				<td align="center" style="width:6%;"><a id='lblPrices'> </a></td>
				<td align="center" style="width:6%;"><a id='lblDime_s'> </a></td> <!--折讓-->
				<td align="center" style="width:6%;"><a id='lblRadius_s'> </a></td><!--建議售價-->
				<td align="center" style="width:8%;"><a id='lblTotal_s'> </a></td>
				<td align="center" style="width:8%;"><a id='lblGemounts'> </a></td>
				<td align="center" style="width:12%;"><a id='lblMemos'> </a></td>
				<!--<td align="center"><a id='lblDateas'> </a></td>-->
				<td align="center" style="width:3%;"><a id='lblEndas'> </a></td>
				<td align="center" style="width:3%;"><a id='lblVccrecord'> </a></td>
			</tr>
			<tr style='background:#cad3ff;'>
				<td><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
				<td>
					<input class="btn"  id="btnProduct.*" type="button" value='.' style="float:left;font-weight: bold;width: 1%" />
					<input class="txt c7"  id="txtProductno.*" maxlength='30'type="text" style="width:75%;" />
					<input class="txt c7"  id="txtNo2.*" type="text" />
				</td>
				<td>	<input class="txt c7" id="txtProduct.*" type="text" /></td>
				<td><select id="cmbType.*" class="txt c1 cbtype"> </select></td>
				<td><input class="txt c7" id="txtUnit.*" type="text"/></td>
				<td>
					<input id="txtLengthb.*" type="text" class="txt num c7"/>
                	<input id="txtMount.*" type="hidden" class="txt num c7"/>
				</td>
				<td><input id="txtWidth.*" type="text" class="txt num c7"/></td>
				<td><input class="txt num c7" id="txtPrice.*" type="text"  /></td>
				<td><input id="txtDime.*" type="text" class="txt num c7"/></td>
				<td><input id="txtRadius.*" type="text" class="txt num c7"/></td>
				<td><input class="txt num c7" id="txtTotal.*" type="text" /></td>
				<td>
					<input class="txt num c1" id="txtC1.*" type="text" />
					<input class="txt num c1" id="txtNotv.*" type="text" />
				</td>
				<td>
					<input class="txt c7" id="txtMemo.*" type="text" />
					<input class="txt" id="txtQuatno.*" type="text" style="width: 70%;" />
					<input class="txt" id="txtNo3.*" type="text"  style="width: 20%;"/>
					<input id="recno.*" type="hidden" />
				</td>
				<!--<td style="width:6%;">
					<input class="txt c7" id="txtDatea.*" type="text"  />
				</td>-->
				<td style="text-align: center;"><input id="chkEnda.*" type="checkbox"/></td>
				<td><input class="btn"  id="btnVccrecord.*" type="button" value='.' style=" font-weight: bold;" /></td>
			</tr>
		</table>
	</div>
	<input id="q_sys" type="hidden" />
</body>
</html>

