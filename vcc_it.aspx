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
        q_tables = 's';
        var q_name = "vcc";
        var q_readonly = ['txtNoa','txtAccno','txtComp', 'txtAcomp', 'txtMoney', 'txtTax', 'txtTotal', 'txtTotalus','txtWorker','txtWorker2','txtSales','txtSales2','txtZipname','textStatus'];
        var q_readonlys = ['txtTotal', 'txtOrdeno', 'txtNo2']; 
        var bbmNum = [['txtPrice', 10, 3,1], ['txtTranmoney', 11, 2,1], ['txtMoney', 15, 0, 1], ['txtTax',15 ,0 , 1], ['txtTotal',15 ,0 , 1], ['txtTotalus',15 ,0 , 1]];
        var bbsNum = [['txtPrice', 12, 3,1], ['txtMount', 9, 2, 1], ['txtTotal',15 ,0 , 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; 
        brwCount = 6; 
        brwCount2 = 12; 
        brwList = []; 
        brwNowPage = 0; 
        brwKey = 'datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
       
		aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,nick', 'txtCustno,txtComp,txtCustno2', 'cust_b.aspx'],
				['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
	            ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
	            ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
	            ['txtSalesno2', 'lblSales2', 'sss', 'noa,namea', 'txtSalesno2,txtSales2', 'sss_b.aspx'],
	            ['txtCustno2', 'lblCust2', 'cust', 'noa,nick', 'txtCustno2,txtComp2', 'cust_b.aspx'],
	            ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,engpro,spec,unit', 'txtProductno_,txtProduct_,txtSpec_,txtMemo_,txtUnit_,txtMount_', 'ucc_b.aspx'],
	            ['txtUno_', '', 'vccs_it', 'uno,productno,product,spec,unit,mspec', '0txtUno_,txtProductno_,txtProduct_,txtSpec_,txtUnit_,txtMemo_,txtMount_', ''],
	            ['txtMemo', '', 'qphr', 'noa,phr', '0,txtMemo', '']
		);
	
        var isinvosystem=false;//購買發票系統
        $(document).ready(function () {
            q_desc = 1;
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount(); 
            q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
            q_gt('ucca', 'stop=1 ', 0, 0, 0, "ucca_invo");//判斷是否有買發票系統
            
            //103/10/23 業務只能看到自己的
            q_gt('sss', "where=^^noa='" + r_userno + "'^^", 0, 0, 0, "sales_vcc");
            
            q_gt('flors_coin', '', 0, 0, 0, "flors_coin");
        });

        //////////////////   end Ready
        function main() {
        	if (dataErr)  
			{
				dataErr = false;
				return;
			}
            mainForm(1); 
        } 
        
        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {
                t_unit = $('#txtUnit_' + j).val();   //  q_float() 傳回 textbox 數值
                //t_mount = (!t_unit || emp(t_unit) || trim(t_unit).toLowerCase() == 'kg' ? q_float('txtWeight_' + j) : q_float('txtMount_' + j));  // 計價量
                t_mount = q_float('txtMount_' + j);
                $('#txtTotal_' + j).val(round(q_mul(q_float('txtPrice_' + j),dec(t_mount)), 0));
                t1 = q_add(t1 , dec(q_float('txtTotal_' + j)));
            }  // j

            $('#txtMoney').val(round(t1, 0));
            if (!emp($('#txtPrice').val()))
                $('#txtTranmoney').val(round(q_mul(t_weight,dec(q_float('txtPrice'))), 0));

            calTax();
            q_tr('txtTotalus' ,round(q_mul(q_float('txtTotal'),q_float('txtFloata')),0));
        }

        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd],['txtMon', r_picm]];   
            q_mask(bbmMask); 
            q_cmbParse("cmbTypea", q_getPara('vcc.typea'));   
            q_cmbParse("cmbStype", q_getPara('vcc.stype')); 
            q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
            //q_cmbParse("cmbCoin", q_getPara('sys.coin')); 
            q_cmbParse("combPay", q_getPara('vcc.paytype')); 
            q_cmbParse("cmbTrantype", q_getPara('sys.tran'));

            
            var t_where = "where=^^ 1=1  group by post,addr^^";
			q_gt('custaddr', t_where, 0, 0, 0, "");
			
            $('#btnOrdes').click(function () {
                var t_custno = trim($('#txtCustno').val());
	            var t_where = '';
	            if (t_custno.length > 0) {
	                t_where = "noa in (select noa from view_orde where enda!='1') && " + (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");
	                if(!emp($('#txtOrdeno').val()))
	                	t_where+=" && charindex(noa,'"+$('#txtOrdeno').val()+"')>0"
	                t_where = t_where;
	            }
	            else {
	                alert(q_getMsg('msgCustEmp'));
	                return;
	            }
	            q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "650px", q_getMsg('popOrde'));
            });

            $('#lblOrdeno').click(function () {
            	if(!emp($('#txtOrdeno').val())) 
            		q_pop('txtOrdeno', "orde_it.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex(noa,'"+$('#txtOrdeno').val()+"')>0;" + r_accy + '_' + r_cno, 'orde', 'noa', '', "95%", "1024px", q_getMsg('lblOrdeno'), true); 
            });
            
            $('#textStatus').click(function () { 
            	if(!emp($('#textStatus2').val()))
            		q_pop('textStatus2', "umm.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex(noa,'"+$('#textStatus2').val()+"')>0;" + r_accy + '_' + r_cno, 'umm', 'noa', '', "95%", "1024px",'收款', true); 
            });
            
            $('#lblAccc').click(function () {
                q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('lblAccc'), true);
            });
            
            $('#lblZipname').click(function () { 
            	q_pop('txtZipname', "quat_it.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex(noa,'"+$('#txtZipname').val()+"')>0;" + r_accy + '_' + r_cno, 'quat', 'noa', '', "95%", "1024px", q_getMsg('lblZipname'), true); 
            });
            
            /*$('#btnFunc').click(function () {
                q_gt('trans', "where=^^datea='100/01/03'^^", 0, 0, 0, "", r_accy);
            });*/
			
            $('#lblInvono').click(function(){
				t_where = '';
				t_invo = $('#txtInvono').val();
                if(t_invo.length > 0){
                	t_where = "noa='" + t_invo + "'";
                	q_box("vcca.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vcca', "95%", "95%", q_getMsg('lblInvono'));
                }
            });
            $('#txtFloata').change(function () {sum();});
            $('#txtPrice').change(function () {sum();});
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
			
			$('#txtDatea').change(function() {
				$('#txtMon').val($('#txtDatea').val().substr(0,6));
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
			
			if(isinvosystem)
				$('.istax').hide();
        }

        function q_funcPost(t_func, result) {  
            if (result.substr(0, 5) == '<Data') {
                var Asss = _q_appendData('sss', '', true);
                var Acar = _q_appendData('car', '', true);
                var Acust = _q_appendData('cust', '', true);
                alert(Asss[0]['namea'] + '^' + Acar[0]['car'] + '^' + Acust[0]['comp']);
            }
            else
                alert(t_func + '\r' + result); /// 如果傳回  string
        }

        function q_boxClose(s2) { 
            var ret;
            switch (b_pop) {
                case 'ordes':
                    if (q_cur > 0 && q_cur < 4) {   
                        b_ret = getb_ret();
                        if (!b_ret || b_ret.length == 0)
                            return;
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2,txtPrice,txtMount,txtMemo', b_ret.length, b_ret
                                                           , 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2,price,mount,memo'
                                                           , 'txtProductno,txtProduct,txtSpec');   /// 最後 aEmpField 不可以有【數字欄位】
						//寫入訂單號碼
						var t_oredeno='';
						for (var i = 0; i < b_ret.length ; i++) {
							if(t_oredeno.indexOf(b_ret[i].noa)==-1)
								t_oredeno=t_oredeno+(t_oredeno.length>0?(','+b_ret[i].noa):b_ret[i].noa);
						}
						//取得訂單備註
						if(t_oredeno.length>0){
							var t_where = "where=^^ charindex(noa,'"+t_oredeno+"')>0 ^^";
							q_gt('orde', t_where, 0, 0, 0, "", r_accy);
						}
						
						$('#txtOrdeno').val(t_oredeno);
						sum();
                    }
                    break;
                case q_name + '_s': 
                    q_boxClose2(s2);
                    break;
            }
            b_pop = '';
        }

		var t_msg='';
		var focus_addr='';
		var z_cno=r_cno,z_acomp=r_comp,z_nick=r_comp.substr(0,2);
		var post_custno='';//傳至cust.aspx
        function q_gtPost(t_name) {  
            var as;
            switch (t_name) {
            	case 'btnOk_checkinvono':
            		var as = _q_appendData("vcca", "", true);
            		if (as[0] == undefined || as[0].vccno==$('#txtNoa').val()) {
	            		if (q_cur == 1)
							$('#txtWorker').val(r_name);
						else
							$('#txtWorker2').val(r_name);
			            sum();
			            var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
			            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
			                q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcc') + $('#txtDatea').val(), '/', ''));
			            else
			                wrServer(s1); 
            		}else{
            			alert('該發票號碼【'+$('#txtInvono').val()+'】已被出貨單【'+as[0].vccno+'】開立!!');
            		}
            		
            		break;
            	case 'ucca_invo':
            		var as = _q_appendData("ucca", "", true);
            		if (as[0] != undefined) {
            			isinvosystem=true;
            			$('.istax').hide();
            		}else{
            			isinvosystem=false;
            		}
            	break;
            	case 'cno_acomp':
                		var as = _q_appendData("acomp", "", true);
                		if (as[0] != undefined) {
	                		z_cno=as[0].noa;
	                		z_acomp=as[0].acomp;
	                		z_nick=as[0].nick;
	                	}
                		break;
                case 'flors_coin':
					var as = _q_appendData("flors", "", true);
					var z_coin='';
					for ( i = 0; i < as.length; i++) {
						z_coin+=','+as[i].coin;
					}
					if(z_coin.length==0) z_coin=' ';
					
					q_cmbParse("cmbCoin", z_coin);
					if(abbm[q_recno])
						$('#cmbCoin').val(abbm[q_recno].coin);
					
					break;
				case 'flors':
					var as = _q_appendData("flors", "", true);
					if (as[0] != undefined) {
						q_tr('txtFloata',as[0].floata);
						sum();
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
							if(as[i].productno==$('#txtProductno_'+(b_seq.length==0?tb_seq:b_seq)).val())
								quat_price=dec(as[i].price);
						}
					}
            		t_msg=t_msg+"最近報價單價："+quat_price+"<BR>";
            		//最新出貨單價
					var t_where = "where=^^ custno='"+$('#txtCustno').val()+"' and noa in (select noa from vccs"+r_accy+" where productno='"+$('#txtProductno_'+(b_seq.length==0?tb_seq:b_seq)).val()+"' and price>0 ) ^^ stop=1";
					q_gt('vcc', t_where , 0, 0, 0, "msg_vcc", r_accy);
            		break;
            	case 'msg_vcc':
					var as  = _q_appendData("vccs", "", true);
					var vcc_price=0;
					if(as[0]!=undefined){
						for ( var i = 0; i < as.length; i++) {
							if(as[i].productno==$('#txtProductno_'+(b_seq.length==0?tb_seq:b_seq)).val())
								vcc_price=dec(as[i].price);
						}
					}
					t_msg=t_msg+"最近出貨單價："+vcc_price;
					$('#txtPrice_'+(b_seq.length==0?tb_seq:b_seq)).val(vcc_price);
					q_msg( $('#txtPrice_'+(b_seq.length==0?tb_seq:b_seq)), t_msg);	
					break;
				case 'acomp_stk':
					var as  = _q_appendData("acomp", "", true);
					var storeno='';
					for ( var i = 0; i < as.length; i++) {
						storeno=storeno+','+as[i].noa;
					}
					storeno=storeno.substr(1,storeno.length);
					var t_where = "where=^^ ['"+q_date()+"','"+storeno+"','') where productno='"+$('#txtProductno_'+(b_seq.length==0?tb_seq:b_seq)).val()+"' ^^";
					q_gt('calstk', t_where , 0, 0, 0, "msg_stk", r_accy);
				break;
            	case 'msg_stk':
            		var as  = _q_appendData("stkucc", "", true);
            		var stkmount=0;
            		t_msg='';
            		for ( var i = 0; i < as.length; i++) {
            			stkmount=stkmount+dec(as[i].mount);
            		}
            		t_msg="庫存量："+stkmount;
            		//平均成本
					var t_where = "where=^^ productno ='"+$('#txtProductno_'+(b_seq.length==0?tb_seq:b_seq)).val()+"' order by datea desc ^^ stop=1";
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
						q_msg( $('#txtMount_'+(b_seq.length==0?tb_seq:b_seq)), t_msg);	
					}else{
						//原料成本
						var t_where = "where=^^ productno ='"+$('#txtProductno_'+(b_seq.length==0?tb_seq:b_seq)).val()+"' order by mon desc ^^ stop=1";
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
					q_msg( $('#txtMount_'+(b_seq.length==0?tb_seq:b_seq)), t_msg);
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
							$('#txtSalesno2').val(as[0].salesno);
							$('#txtSales2').val(as[0].sales);
                       }else{
	                       	if(!popcust){
								q_box("cust.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" , 'cust', "95%", "95%", q_getMsg('popCust'));
								popcust=false;
	                       }
                       }
                       $('#txtCustno2').focus();
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
							$('#txtSalesno2').val(as[0].salesno);
							$('#txtSales2').val(as[0].sales);
                       }
                       
                       $('#txtCustno2').focus();
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
            	case 'orde':
            	var as = _q_appendData("orde", "", true);
            	var t_memo=$('#txtMemo').val();
            		for ( i = 0; i < as.length; i++) {
            			t_memo=t_memo+(t_memo.length>0?'\n':'')+as[i].noa+':'+as[i].memo;
            		}
            		$('#txtMemo').val(t_memo);
            		break;
            	break;
            	case 'cust':
            		var as = _q_appendData("cust", "", true);
            		if(as[0]!=undefined && focus_addr !=''){
            			$('#'+focus_addr).val(as[0].addr_fact);
            			focus_addr = '';
            		}
            		break;
            	case 'btnDele':
                	var as = _q_appendData("umms", "", true);
                    if (as[0] != undefined) {
                    	var z_msg = "",t_paysale=0;
                       	for(var i=0;i<as.length;i++){
                       		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                       		if(t_paysale!=0)
                       			z_msg += String.fromCharCode(13)+'收款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                       	}
                       	if(z_msg.length>0){
                       		alert('已沖帳:'+ z_msg);
                       		Unlock(1);
                       		return;
                       	}
					}
                    _btnDele();
                    Unlock(1);
                	break;
				case 'btnModi':
                	var as = _q_appendData("umms", "", true);
					if (as[0] != undefined) {
						var z_msg = "",t_paysale=0;
						for(var i=0;i<as.length;i++){
							t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
							if(t_paysale!=0)
                        		z_msg += String.fromCharCode(13)+'收款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                       	}
						if(z_msg.length>0){
                       		alert('已沖帳:'+ z_msg);
                       		Unlock(1);
                       		return;
                       	}
					}
                    _btnModi();
					Unlock(1);
					$('#txtDatea').focus();
					
					if(r_rank<4){ //1030213 王小姐 不能讓其他人去修改//1022 開放權限4以上的可以修改
						$('#chkIsgenvcca').attr('disabled','disabled');
						$('#txtInvono').attr('disabled','disabled');
					}
					
            
					if(!emp($('#txtCustno').val())){
						var t_where = "where=^^ noa='" + $('#txtCustno').val() + "' ^^";
						q_gt('custaddr', t_where, 0, 0, 0, "");
					}
                	break;
                case q_name: 
                	if (q_cur == 4) 
                        q_Seek_gtPost();
                    break;
                case 'sss':
                    as = _q_appendData('sss', '', true);
                    break;
                case 'sales_vcc':
                    as = _q_appendData('sss', '', true);
                    if (as[0] != undefined) {
						if (as[0].issales == 'true' && as[0].job.indexOf('經理') < 0 && r_rank <= '5') {//一般業務只能看到自己的出貨單
							q_content = "where=^^salesno='" + r_userno + "'^^";
	                    } else if (as[0].issales == 'true' && as[0].job.indexOf('經理') > -1 && r_rank <= '5') {
	                    	q_content = "where=^^salesno in (select noa from sss where salesgroup= '" + as[0].salesgroup + "') ^^"; //只能看到群組的
	                   }
                    }
					q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                    break;
				case 'umms':
					var as = _q_appendData("umms", "", true);
					var z_msg = "",z_msg2 = "", t_paysale = 0,t_tpaysale=0;
					if (as[0] != undefined) {
						for (var i = 0; i < as.length; i++) {
							t_paysale = parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
							t_tpaysale+= parseFloat(as[i].paysale.length == 0 ? "0" : as[i].paysale);
							if (t_paysale != 0)
								z_msg += (as[i].noa+';');
						}
						
						if (z_msg.length > 0) {
							z_msg='已收款：'+FormatNumber(t_tpaysale)+'，收款單號【'+z_msg.substr(0,z_msg.length-1)+ '】。 ';
							z_msg2=z_msg.substr(0,z_msg.length-1);
						}
					}else{
						z_msg='未收款。';
					}
					$('#textStatus').val(z_msg);
					$('#textStatus2').val(z_msg2);
					break;
            }  /// end switch
        }
        
        function coin_chg() {
			var t_where = "where=^^ ('" + $('#txtDatea').val() + "' between bdate and edate) and coin='"+$('#cmbCoin').find("option:selected").text()+"' ^^";
			q_gt('flors', t_where, 0, 0, 0, "");
		}

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtCustno', q_getMsg('lblCustno')], ['txtCno', q_getMsg('lblAcomp')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            
            //1031119 王小姐 報廢 bbs數量要=0
            if($('#cmbTaxtype').val()=='6'){
            	var t_mount=0;
            	for (var i = 0; i < q_bbsCount ; i++) {
            		t_mount=q_add(t_mount,q_float('txtMount_'+i));
            	}
            	if(t_mount!=0){
            		alert('報廢-出貨數量不等於0!!');
            		return;
            	}
            }
            
            //104/02/12 出貨時倉庫沒打直接帶預設倉庫RAA000
            for (var i = 0; i < q_bbsCount ; i++) {
            	if(emp($('#txtStoreno_'+i).val())){
            		$('#txtStoreno_'+i).val('RAA000');
            		$('#txtStore_'+i).val('英特瑞');
            	}	
            }
            
            if(emp($('#txtMon').val()))
				$('#txtMon').val($('#txtDatea').val().substr(0,6));
				
			//當自動產生發票--檢查發票號碼是否重複
			if($("#chkIsgenvcca").prop("checked")){
				var t_where = "where=^^ noa='" + $('#txtInvono').val() + "' ^^";
				q_gt('vcca', t_where, 0, 0, 0, "btnOk_checkinvono");
			}else{
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
	            sum();
	            var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
	            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
	                q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcc') + $('#txtDatea').val(), '/', ''));
	            else
	                wrServer(s1); 
			}
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('vcc_it_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
            var cmb = document.getElementById("combPay")
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
		
		var tb_seq='';
		
        function bbsAssign() {  /// 表身運算式
            for (var i = 0; i < q_bbsCount ; i++) {   // q_bbsCount 表身總列數
                if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    $('#txtUnit_' + i).focusout(function () { sum(); });
                    //$('#txtWeight_' + i).focusout(function () { sum(); });
                    $('#txtPrice_' + i).focusout(function () {
                    	 sum(); 
                    });
                    
                    $('#txtMount_' + i).focusout(function () { 
                    	if(q_cur==1 ||q_cur==2 )
                    		sum(); 
                    })
                    $('#txtMount_' + i).focusin (function() {
                    	if(q_cur==1 ||q_cur==2 ){
	                    	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                    q_bodyId($(this).attr('id'));
		                    b_seq = t_IdSeq;
		                    tb_seq=b_seq;
	                    	if(!emp($('#txtProductno_'+b_seq).val())){
	                    		//庫存
	                    		if(q_getPara('sys.comp').indexOf('英特瑞')>-1 || q_getPara('sys.comp').indexOf('安美得')>-1){
									//var t_where = "where=^^ 1=1 ^^";
									//q_gt('acomp', t_where , 0, 0, 0, "acomp_stk", r_accy);
									if(!emp($('#txtCustno').val())){
										var t_where = "where=^^ ['"+q_date()+"','"+$('#txtCustno').val()+"','"+$('#txtProductno_'+b_seq).val()+"') ^^";
										q_gt('calstk', t_where , 0, 0, 0, "msg_stk", r_accy);
									}
								}else{
									var t_where = "where=^^ ['"+q_date()+"','','') where productno='"+$('#txtProductno_'+b_seq).val()+"' ^^";
									q_gt('calstk', t_where , 0, 0, 0, "msg_stk", r_accy);
								}
	                    	}
                    	}
                    });
                    $('#txtPrice_' + i).focusin (function() {
                    	if(q_cur==1 ||q_cur==2 ){
	                    	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                    q_bodyId($(this).attr('id'));
		                    b_seq = t_IdSeq;
		                    tb_seq=b_seq;
	                    	if(!emp($('#txtProductno_'+b_seq).val())){
	                    		//金額
								var t_where = "where=^^ noa='"+$('#txtProductno_'+b_seq).val()+"' ^^ stop=1";
								q_gt('ucc', t_where , 0, 0, 0, "msg_ucc", r_accy);
	                    	}
                    	}
                    });
                    
                    $('#btnRecord_' + i).click(function () {
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						t_where = "cust='"+$('#txtCustno').val()+"' and noq='"+$('#txtProductno_'+b_seq).val()+"'";
						q_box("z_vccrecord.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccrecord', "95%", "95%", q_getMsg('lblRecord_s'));
					});
                }
            } //j
            _bbsAssign();
            if(q_getPara('sys.comp').indexOf('英特瑞')>-1 || q_getPara('sys.comp').indexOf('安美得')>-1){
				$('.it').show();
			}else{
				$('.it').hide();
			}
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtCno').val(z_cno);
            $('#txtAcomp').val(z_acomp);
            $('#txtDatea').val(q_date());
            $('#txtMon').val($('#txtDatea').val().substr(0,6));
            $('#cmbTypea').val('1');
            $('#txtDatea').focus();
            
             if(q_getPara('sys.comp').indexOf('英特瑞')>-1 || q_getPara('sys.comp').indexOf('安美得')>-1){
				$('.it').show();
				$('#cmbTaxtype').val('3');
			}else{
				$('.it').hide();
			}
            
            var t_where = "where=^^ 1=1  group by post,addr^^";
			q_gt('custaddr', t_where, 0, 0, 0, "");

        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
                
			if(q_date()>=q_cdn($('#txtDatea').val(),3) && r_rank<9){
				alert('已鎖單!!');
				 return;
			}
			
			Lock(1,{opacity:0});
			var t_where =" where=^^ vccno='"+ $('#txtNoa').val()+"'^^";
			q_gt('umms', t_where, 0, 0, 0, 'btnModi',r_accy);
        }
        function btnPrint() {
			q_box('z_vccp_it.aspx' + "?;;;noa="+trim($('#txtNoa').val())+";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
        }

        function wrServer(key_value) {  
            var i;

            $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2); 
        }

        function bbsSave(as) { 
            if (!as['productno'] && !as['product'] && !as['spec'] && !dec(as['total'])) { 
                as[bbsKey[1]] = ''; 
                return;
            }

            q_nowf();
            as['typea'] = abbm2['typea'];
            as['mon'] = abbm2['mon'];
            as['noa'] = abbm2['noa'];
            as['datea'] = abbm2['datea'];
            as['custno'] = abbm2['custno'];
            if (abbm2['storeno'])
                as['storeno'] = abbm2['storeno'];

            t_err = '';
            if (as['price'] != null && (dec(as['price']) > 99999999 || dec(as['price']) < -99999999))
                t_err = q_getMsg('msgPriceErr') + as['price'] + '\n';
            if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
                t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

            if (t_err) {
                alert(t_err)
                return false;
            }
            return true;
        }
        
        function q_stPost() {
            if (q_cur == 1 || q_cur == 2) {
            	var s2 = xmlString.split(';');
            	abbm[q_recno]['accno'] = s2[0];
            	abbm[q_recno]['invono'] = s2[1];
                //abbm[q_recno]['accno'] = xmlString;   /// 存檔後， server 傳回 xmlString 
                //$('#txtAccno').val(xmlString);   /// 顯示 server 端，產生之傳票號碼
            }
        }
        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
            
            if(q_getPara('sys.comp').indexOf('英特瑞')>-1 || q_getPara('sys.comp').indexOf('安美得')>-1){
				$('.it').show();
			}else{
				$('.it').hide();
			}
			
			var t_where = " where=^^ vccno='" + $('#txtNoa').val() + "'^^";
			q_gt('umms', t_where, 0, 0, 0, '', r_accy);
			
			if(isinvosystem)
				$('.istax').hide();
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            if(t_para){
				$('#combAddr').attr('disabled','disabled');
			}else{
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
            dataErr = !_q_appendData(t_Table);
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
            Lock(1,{opacity:0});
			var t_where =" where=^^ vccno='"+ $('#txtNoa').val()+"'^^";
			q_gt('umms', t_where, 0, 0, 0, 'btnDele',r_accy);
        }

        function btnCancel() {
            _btnCancel();
        }
        var popcust=false;
        var uno_pno='',uno_product='',uno_spec='',uno_unit='',uno_uno=true;
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
		        case 'txtProductno_':
		   			$('#txtMount_'+b_seq).focus();
		        break;
		        case 'txtUno_':
		        	if(uno_uno){
		        		uno_pno=$('#txtProductno_'+b_seq).val();
		        		uno_product=$('#txtProduct_'+b_seq).val();
		        		uno_spec=$('#txtSpec_'+b_seq).val();
		        		uno_unit=$('#txtUnit_'+b_seq).val();
		        		uno_uno=false;
		        	}else{
		        		uno_uno=true;
		        		$('#txtProductno_'+b_seq).val(uno_pno);
		        		$('#txtProduct_'+b_seq).val(uno_product);
		        		$('#txtSpec_'+b_seq).val(uno_spec);
		        		$('#txtUnit_'+b_seq).val(uno_unit);
		        	}
		   			
		        break;
		   	}
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
		
		function calTax(){
			var t_money=0,t_tax=0,t_total=0;
			for (var j = 0; j < q_bbsCount; j++) {
				t_money+=q_float('txtTotal_' + j);
			}
			if(!isinvosystem){
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
                        t_tax = round(q_mul(q_div(t_money,q_add(1,t_taxrate)),t_taxrate), 0);
                        t_total = t_money;
                        t_money = q_sub(t_total,t_tax);
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
			}else{
				if($('#cmbTaxtype').val()=='6'){
					t_money=0	
					t_tax=0
					t_total=0
				}else{
					t_total=t_money;
				}
			}
			$('#txtMoney').val(FormatNumber(t_money));
			$('#txtTax').val(FormatNumber(t_tax));
			$('#txtTotal').val(FormatNumber(t_total));
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
                width: 30%;
                float: left;
            }
            .txt.c3 {
                width: 68%;
                float: left;
            }
            .txt.c4 {
                width: 49%;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
    </style>
</head>
<body>
    <div id="dmain" style="width: 1260px;">
        <!--#include file="../inc/toolbar.inc"-->
        <div class="dview" id="dview" >
           <table class="tview" id="tview">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:5%"><a id='vewType'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='typea=vcc.typea'>~typea=vcc.typea</td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='comp,8' style="text-align: left;">~comp,8</td>
            </tr>
        </table>
        </div>
        <div class='dbbm'>
        <table class="tbbm"  id="tbbm" style="width: 872px;">
            <tr>
               <td class="td1" style="width: 108px;"><span> </span><a id='lblType' class="lbl"> </a></td>
               <td class="td2" style="width: 108px;"><select id="cmbTypea"> </select></td>
               <td class="td3" style="width: 108px;"><a id='lblStype' class="lbl" style="float: left;"> </a><span style="float: left;"> </span><select id="cmbStype"> </select></td>
               <td class="td4" style="width: 108px;"><span> </span><a id='lblDatea' class="lbl"> </a></td>
               <td class="td5" style="width: 108px;"><input id="txtDatea" type="text"  class="txt c1"/></td>
               <td class="td6" style="width: 108px;"> </td>
               <td class="td7" style="width: 108px;"><span> </span><a id='lblNoa' class="lbl"> </a></td>
               <td class="td8" style="width: 108px;"><input id="txtNoa" type="text" class="txt c1" /></td> 
            </tr>
            <tr>
				<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
				<td class="td2" colspan='2'>
					<input id="txtCno" type="text" class="txt c2"/>
					<input id="txtAcomp" type="text" class="txt c3"/>
				</td>
                <td class="td7"><span> </span><a id='lblMon' class="lbl"> </a></td>
                <td class="td8" colspan='2'>
                	<input id="txtMon" type="text" class="txt" style="width: 70px;"/>
                	<span> </span><a id='lblIsgenvcca' class="lbl"> </a>
                	<input id="chkIsgenvcca" type="checkbox" style="float: right;"/>
                </td>        
                <td class="td7"><span> </span><a id='lblInvono' class="lbl btn"> </a></td>
                <td class="td8"><input id="txtInvono" type="text" class="txt c1"/></td> 
            </tr>
            <tr>
				<td class="td1"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
				<td class="td2" colspan='2'>
					<input id="txtCustno" type="text" class="txt c2"/>
					<input id="txtComp" type="text" class="txt c3"/>
				</td>
                <td class="td4"><span> </span><a id='lblPay' class="lbl"> </a></td>
                <td class="td5"><input id="txtPaytype" type="text" class="txt c1"/></td>                 
                <td class="td6"><select id="combPay" style="width: 100%;" onchange='combPay_chg()'> </select></td>
                <td class="td6"align="right"><input id="btnOrdes" type="button"/></td>      
            </tr>
            <tr>
				<td class="td1"><span> </span><a id="lblTel" class="lbl"> </a></td>
				<td class="td2" colspan='2'><input id="txtTel" type="text" class="txt c1"/></td>
				<td class="td1"><span> </span><a id="lblFax" class="lbl"> </a></td>
				<td class="td2" colspan='2'><input id="txtFax" type="text" class="txt c1"/></td>
                <td class="td4"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
                <td class="td5"><select id="cmbTrantype" style="width: 100%;"> </select></td>                 
            </tr>
            <tr>
				<td class="td1"><span> </span><a id="lblAddr" class="lbl"> </a></td>
				<td class="td2"><input id="txtPost" type="text" class="txt c1"/></td>
				<td class="td3" colspan='4'><input id="txtAddr" type="text" class="txt c1"/></td>
               <td class="td7"><span> </span><a id='lblOrdeno' class="lbl btn"> </a></td>
                <td class="td8"><input id="txtOrdeno" type="text" class="txt c1"/></td> 
            </tr>
            <tr>
				<td class="td1"><span> </span><a id='lblAddr2' class="lbl"> </a></td>
				<td class="td2"><input id="txtPost2"  type="text" class="txt c1"/></td>
				<td class="td3" colspan='4' >
					<input id="txtAddr2"  type="text" class="txt c1" style="width: 412px;"/>
					<select id="combAddr" style="width: 20px" onchange='combAddr_chg()'> </select>
				</td>
				<td class="td7"><span> </span><a id='lblZipname' class="lbl btn"> </a></td>
                <td class="td8"><input id="txtZipname" type="text" class="txt c1"/></td> 
			</tr>
            <tr>
                <td class="td4"><span> </span><a id='lblSales' class="lbl btn"> </a></td>
                <td class="td5"><input id="txtSalesno" type="text" class="txt c1"/></td>                 
                <td class="td6"><input id="txtSales" type="text" class="txt c1"/></td>
                <td class="td3"><span> </span><a id="lblSales2" class="lbl btn"> </a></td>
				<td class="td4" colspan='2'>
					<input id="txtSalesno2" type="text" class="txt c2"/>
					<input id="txtSales2" type="text" class="txt c3"/>
				</td>
                <td class="td7"><span> </span><a id='lblAccc' class="lbl btn"> </a></td>
                <td class="td8"><input id="txtAccno" type="text" class="txt c1"/></td> 
            </tr>
            <tr>
				<td class="td1"><span> </span><a id="lblCust2" class="lbl btn"> </a></td>
				<td class="td2" colspan='2'>
					<input id="txtCustno2" type="text" class="txt c2"/>
					<input id="txtComp2" type="text" class="txt c3"/>
				</td>
				<td class="td4"><span> </span><a id='lblFloata' class="lbl"> </a></td>
                <td class="td5"><select id="cmbCoin" style="width: 100%;" onchange='coin_chg()'> </select></td>                 
                <td class="td6"><input id="txtFloata" type="text" class="txt num c1"/></td>
				 <td class="td7"><span> </span><a id='lblPrice' class="lbl"> </a></td>
                <td class="td8"><input id="txtPrice" type="text" class="txt num c1"/></td> 
            </tr>
            <tr>
				<td class="td1"><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
				<td class="td2" colspan='2'>
					<input id="txtCardealno" type="text" class="txt c2"/>
					<input id="txtCardeal" type="text" class="txt c3"/>
				</td>
                <td class="td4"><span> </span><a id='lblCarno' class="lbl"> </a></td>
                <td class="td5" colspan='2'><input id="txtCarno" type="text" class="txt c1"/></td>
                <td class="td7"><span> </span><a id='lblTranmoney' class="lbl"> </a></td>
                <td class="td8"><input id="txtTranmoney" type="text" class="txt num c1"/></td> 
            </tr>
			<tr>
				<td class="td1"><span> </span><a id="lblMoney" class="lbl"> </a></td>
				<td class="td2" colspan='2'><input id="txtMoney" type="text" class="txt num c1"/></td>
                <td class="td4"><span> </span><a id='lblTax' class="lbl"> </a></td>
                <td class="td5" colspan='2'>
                	<input id="txtTax" type="text" class="txt num c1 istax" style="width: 49%;"/>
                	<select id="cmbTaxtype" style="width: 49%;" onchange="calTax();"> </select>
				</td>                 
                <td class="td7"><span> </span><a id='lblTotal' class="lbl istax"> </a></td>
                <td class="td8"><input id="txtTotal" type="text" class="txt num c1 istax"/></td> 
            </tr>
            <tr>
				<td class="td1"><span> </span><a id="lblTotalus" class="lbl"> </a></td>
				<td class="td2" colspan='2'><input id="txtTotalus" type="text" class="txt num c1"/></td>
                <td class="td4"><span> </span><a id="lblWorker" class="lbl"> </a></td>
                <td class="td5"><input id="txtWorker" type="text" class="txt c1"/></td>             
                <td class="td6"><input id="txtWorker2" type="text" class="txt c1"/></td>
                <td class="td7"><span> </span><a id='lblZipcode' class="lbl"> </a></td>
                <td class="td8"><input id="txtZipcode" type="text" class="txt c1"/></td> 
            </tr>
            <tr>
				<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
				<td class="td2" colspan='7'>
					<input id="txtMemo" type="text" class="txt c1"/>
				</td>
            </tr>
            <tr>
				<td class="td1"><span> </span><a class="lbl">收款情況</a></td>
				<td class="td2" colspan='7'>
					<input id="textStatus" type="text" class="txt c1"/>
					<input id="textStatus2" type="hidden" class="txt c1"/>
				</td>
            </tr>
        </table>
        </div>
        </div>
        <div class='dbbs' style="width: 1270px;">
        <table id="tbbs" class='tbbs'>
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;width:" /> </td>
				<td align="center" class="it"><a id='lblUno_s'> </a></td>
                <td align="center"><a id='lblProductno_s'> </a></td>
                <td align="center"><a id='lblProduct_s'> </a></td>
                <td align="center"><a id='lblUnit_s'> </a></td>
                <td align="center"><a id='lblMount_s'> </a></td>
                <td align="center"><a id='lblPrice_s'> </a></td>
                <td align="center"><a id='lblTotal_s'> </a></td>
                <td align="center"><a id='lblStore_s'> </a></td>
                <td align="center"><a id='lblMemo_s'> </a></td>
                <td align="center"><a id='lblRecord_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td style="width:8%;" class="it"><input id="txtUno.*" type="text" class="txt c1" /></td>
                <td style="width:10%">
                	<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;" />
                	<input class="txt"  id="txtProductno.*" type="text" style="width:75%;" />
                </td>
                <td style="width:15%;">
                	<input id="txtProduct.*" type="text" class="txt c1" />
                	<input id="txtSpec.*" type="text" class="txt c1 it" />
                </td>
                <td style="width:4%;"><input id="txtUnit.*" type="text" class="txt c1"/></td>
                <td style="width:5%;"><input id="txtMount.*" type="text" class="txt num c1"/></td>
                <td style="width:6%;"><input id="txtPrice.*" type="text" class="txt num c1"/></td>
                <td style="width:7%;"><input id="txtTotal.*" type="text" class="txt num c1"/></td>
                <td style="width:8%;">
                	<input id="txtStoreno.*" type="text" class="txt c1" style="width: 75%"/>
                	<input class="btn"  id="btnStoreno.*" type="button" value='.' style=" font-weight: bold;" />
                	<input id="txtStore.*" type="text" class="txt c1"/>
                </td>
                <td style="width:10%;"><input id="txtMemo.*" type="text" class="txt c1"/>
                	<input id="txtOrdeno.*" type="text"  class="txt" style="width:70%;"/>
                	<input id="txtNo2.*" type="text" class="txt" style="width:20%;"/>
                	<input id="txtNoq.*" type="hidden" />
                </td>
                <td style="width:2%;" align="center"><input class="btn"  id="btnRecord.*" type="button" value='.' style=" font-weight: bold;" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>

