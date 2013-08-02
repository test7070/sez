<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title> </title>
    <script src="../script/jquery.min.js" type="text/javascript"> </script>
    <script src='../script/qj2.js' type="text/javascript"> </script>
    <script src='qset.js' type="text/javascript"> </script>
    <script src='../script/qj_mess.js' type="text/javascript"> </script>
    <script src="../script/qbox.js" type="text/javascript"> </script>
    <script src='../script/mask.js' type="text/javascript"> </script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        q_tables = 's';
        var q_name = "rc2";
        var decbbs = [ 'money','total', 'weight', 'mount', 'price', 'sprice', 'dime', 'width', 'lengthb', 'weight2'];
        var decbbm = ['payed', 'unpay', 'usunpay', 'uspayed', 'ustotal', 'discount', 'money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'tranmoney','totalus'];
        var q_readonly = ['txtNoa','txtWorker']; 
        var q_readonlys= [];
        var bbmNum = [['txtTotalus', 10, 4, 1],['txtPrice', 10, 3, 1],['txtTranmoney', 10, 0, 1],
			          ['txtMoney', 10, 0, 1],['txtTotal', 10, 0, 1],
			          ['txtWeight', 10, 0, 1]
			         ];  // 允許 key 小數
        var bbsNum = [['textSize1', 10, 3, 1],['textSize2', 10, 2, 1],['textSize3', 10, 3, 1],
			          ['textSize4', 10, 2, 1],['txtRadius', 10, 3, 1],
			          ['txtWidth', 10, 2, 1],['txtDime', 10, 3, 1],['txtLengthb', 10, 2, 1],
			          ['txtMount', 10, 2, 1],['txtWeight', 10, 1, 1],['txtPrice', 10, 2, 1],
			          ['txtTotal', 10, 0, 1],['txtGweight', 10, 1, 1]
        			 ];
        var bbmMask = [];
        var bbsMask = [['txtStyle','A']];
        q_desc = 1;
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
		 aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp,paytype', 'txtTggno,txtTgg,txtPaytype', 'tgg_b.aspx'],
		 ['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx'],
		 ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],
		 ['txtUno_', 'btnUno_', 'uccc', 'uno', 'txtUno_', 'uccc_seek_b.aspx','95%','60%'],
		 ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  
			q_gt('style','',0,0,0,'');
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

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

        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd ],['txtMon', r_picm ]];
            q_mask(bbmMask);
            q_cmbParse("cmbTypea", q_getPara('rc2.typea'));   // 需在 main_form() 後執行，才會載入 系統參數
            //q_cmbParse("cmbStype", q_getPara('rc2.stype'));   
            q_cmbParse("cmbCoin", q_getPara('sys.coin'));      /// q_cmbParse 會加入 fbbm
             q_cmbParse("combPaytype", q_getPara('rc2.paytype'));  // comb 未連結資料庫
            q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
            q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
            q_cmbParse("cmbKind", q_getPara('sys.stktype')); 
             $('#lblAccc').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('btnAccc'), true);
		        });
		        $('#lblOrdc').click(function () {
		            lblOrdc();
		        });
		       $('#cmbKind').change(function () {
            	size_change();
		     });
            $('#lblInvono').click(function(){
				t_where = '';
				t_invo = $('#txtInvono').val();
                if(t_invo.length > 0){
                	t_where = "noa='" + t_invo + "'";
                	q_box("invoice.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'invo', "95%", "95%", q_getMsg('popInvo'));
                }
            });
            $('#lblLcno').click(function(){
				t_where = '';
				t_lcno = $('#txtLcno').val();
                if(t_lcno.length > 0){
                	t_where = "lcno='" + t_lcno + "'";
                	q_box("lcs.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'lcs', "95%", "95%", q_getMsg('popLcs'));
                }
            });
            $('#txtFloata').change(function () {sum();});
			$('#txtTotal').change(function () {sum();});
        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、廠商視窗、訂單視窗  關閉時執行
            var ret; 
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
                   
                case 'ordcs':
                    if (q_cur > 0 && q_cur < 4) {
                        b_ret = getb_ret();
                        if (!b_ret || b_ret.length == 0)
                            return;
                        var i, j = 0;
                        $('#txtOrdeno').val(b_ret[0].noa);
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtRadius,txtOrdeno,txtNo2,txtPrice,txtMount,txtWeight,txtTotal,txtMemo', b_ret.length, b_ret
                                                           , 'uno,productno,product,spec,size,dime,width,lengthb,radius,noa,no2,price,mount,weight,total,memo'
                                                           , 'txtProductno,txtProduct,txtSpec');   /// 最後 aEmpField 不可以有【數字欄位】
                        bbsAssign();
						size_change();
                        for (i = 0; i < ret.length; i++) {
                            k = ret[i];  ///ret[i]  儲存 tbbs 指標
                            if (!b_ret[i]['unit'] || b_ret[i]['unit'].toUpperCase() == 'KG') {
                                $('#txtMount_' + k).val(b_ret[i]['notv']);
                                $('#txtWeight_' + k).val(divide0(b_ret[i]['weight'] * b_ret[i]['notv'], b_ret[i]['mount']));
                            }
                            else {
                                $('#txtWeight_' + k).val(b_ret[i]['notv2']);
                                $('#txtMount_' + k).val(divide0(b_ret[i]['mount'] * b_ret[i]['notv2'], b_ret[i]['weight']));
                            }
                        }  /// for i
                        sum();
                    }
                    break;
                
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }

		var StyleList = '';
        function q_gtPost(t_name) {  /// 資料下載後 ...
            switch (t_name) {
            	case 'style' :
            			var as = _q_appendData("style", "", true);
            			StyleList = new Array();
            			StyleList = as;
                case q_name: if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
        function lblOrdc() {
            var t_tggno = trim($('#txtTggno').val());
            var t_ordeno = trim($('#txtOrdeno').val());
            var t_where='';
            if (t_tggno.length > 0) {
            	if (t_ordeno.length > 0) 
            		t_where = "enda=0 && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "")+"&& " + (t_ordeno.length > 0 ? q_sqlPara("noa", t_ordeno) : "")+" && kind='"+$('#cmbKind').val()+"'";  ////  sql AND 語法，請用 &&
            	else
                	/*t_where = "enda=0 && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "")+" && kind='"+$('#cmbKind').val()+"'";  ////  sql AND 語法，請用 &&*/
                	t_where = "enda=0 && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "");  ////  sql AND 語法，請用 &&
                t_where = t_where;
            }
            else {
                alert(q_getMsg('msgtggEmp'));
                return;
            }
            q_box("ordcsst_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+r_accy, 'ordcs', "95%", "95%", q_getMsg('popOrdcs'));
        }

        function btnOk() {
			$('#txtMon').val($.trim($('#txtMon').val()));
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
					alert(q_getMsg('lblMon')+'錯誤。');   
					return;
				} 
		    t_err = q_chkEmpField([
			    	['txtNoa', q_getMsg('lblNoa')],
			    	['txtTggno', q_getMsg('lblTgg')],
			    	['txtCno', q_getMsg('btnAcomp')]
		    ]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            $('#txtWorker' ).val(  r_name)
            //sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('I' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }
		
		function q_stPost() {
			//t_accno + ";" + t_payed + ";" + (t_total - t_payed);
		        if (!(q_cur == 1 || q_cur == 2))
		            return false;
				var s1 = xmlString.split(';');
		        abbm[q_recno]['accno'] = s1[0];
		        $('#txtAccno').val(s1[0]);
		    }
		
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('rc2_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function combPaytype_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
            var cmb = document.getElementById("combPaytype")
            if (!q_cur) 
                cmb.value = '';
            else
                $('#txtPaytype').val(cmb.value);
            cmb.value = '';
        }
        
		function getTheory(b_seq){
			t_Radius = $('#txtRadius_'+b_seq).val();
			t_Width = $('#txtWidth_'+b_seq).val();
			t_Dime = $('#txtDime_'+b_seq).val();
			t_Lengthb = $('#txtLengthb_'+b_seq).val();
			t_Mount = $('#txtMount_'+b_seq).val();
			t_Style = $('#txtStyle_'+b_seq).val();
			return theory_st(StyleList, t_Radius, t_Width, t_Dime, t_Lengthb, t_Mount, t_Style);
		}
        
		var btnCert_Seq = -1; ///用來給q_box開啟cert時判斷位置
		function bbsAssign() {  /// 表身運算式
            _bbsAssign();
            $('.btnCert').val($('#lblCert_st').text());
            for (var j = 0; j < ( q_bbsCount==0 ? 1 : q_bbsCount); j++) {
                $('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });
				$('#txtStyle_' + j).blur(function(){
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				    q_bodyId($(this).attr('id'));
				    b_seq = t_IdSeq;
					ProductAddStyle(b_seq);
				});
				$('#btnCert_' + j).click(function(){
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					btnCert_Seq = b_seq;
					t_where = '';
					t_uno = $('#txtUno_' + b_seq).val();
					if(t_uno.length > 0){
						t_where = "noa='" + t_uno + "'";
						q_box("cert_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'cert', "95%", "95%", q_getMsg('popCert'));
					}
				});
				//將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
				$('#textSize1_' + j).change(function () {
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					if ($('#cmbKind').val().substr(0,1)=='A'){	
						q_tr('txtDime_'+b_seq ,q_float('textSize1_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize1_' + b_seq).val());
					}else if( $('#cmbKind').val().substr(0,1)=='B'){
						q_tr('txtRadius_'+b_seq ,q_float('textSize1_'+b_seq));//短徑$('#txtRadius_'+b_seq).val($('#textSize1_' + b_seq).val());	
					}
					q_tr('txtWeight_'+b_seq ,getTheory(b_seq));
				});
				$('#textSize2_' + j).change(function () {
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					if ($('#cmbKind').val().substr(0,1)=='A'){	
						q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//寬度$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
					}else if($('#cmbKind').val().substr(0,1)=='B'){
						q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//長徑$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
					}
					q_tr('txtWeight_'+b_seq ,getTheory(b_seq));
				});
				$('#textSize3_' + j).change(function () {
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					if ($('#cmbKind').val().substr(0,1)=='A'){	
						q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize3_' + b_seq).val());	
					}else if($('#cmbKind').val().substr(0,1)=='B'){
						q_tr('txtDime_'+b_seq ,q_float('textSize3_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize3_' + b_seq).val());		
					}else{//鋼筋、胚
						q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));
					}
					q_tr('txtWeight_'+b_seq ,getTheory(b_seq));
				});
				$('#textSize4_' + j).change(function () {
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					if ($('#cmbKind').val().substr(0,1)=='A'){	
						q_tr('txtRadius_'+b_seq ,q_float('textSize4_'+b_seq));//短徑為0 $('#txtRadius_'+b_seq).val($('#textSize4_' + b_seq).val());	
					}else if( $('#cmbKind').val().substr(0,1)=='B'){
						q_tr('txtLengthb_'+b_seq ,q_float('textSize4_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize4_' + b_seq).val());	
					}
					q_tr('txtWeight_'+b_seq ,getTheory(b_seq));
				});
				$('#txtMount_' + j).change(function () {
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					q_tr('txtWeight_'+b_seq ,getTheory(b_seq));
				});
                //-------------------------------------------------
                $('#txtUnit_' + j).focusout(function () { sum(); });
                $('#txtWeight_' + j).focusout(function () { sum(); });
                $('#txtPrice_' + j).focusout(function () { sum(); });
                $('#txtMount_' + j).focusout(function () { sum(); });
                $('#txtTotal_' + j).focusout(function () { sum(); });

            } //j
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
            size_change();
        }

        function btnModi() {
            if( emp( $('#txtNoa').val()))
                return;

            _btnModi();
            $('#txtDatea').focus();
            size_change();
        }


        function btnPrint() {
 			q_box('z_rc2stp.aspx', '', "800px", "600px", q_getMsg("popPrint"));
        }

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk( key_value, bbmKey[0], bbsKey[1], '', 2);  // key_value
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['productno'] && !as['product'] && !as['spec'] && !dec( as['total'])) {  //不存檔條件
                as[bbsKey[1]] = '';   /// noq 為空，不存檔
                return;
            }

            q_nowf();
            as['type'] = abbm2['type'];
            as['mon'] = abbm2['mon'];
            as['noa'] = abbm2['noa'];
            as['datea'] = abbm2['datea'];
            as['tggno'] = abbm2['tggno'];
            as['kind'] = abbm2['kind'];
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

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            var t_float = dec($('#txtFloata').val());
            t_float = (emp(t_float) ? 1 : t_float);
            for (var j = 0; j < q_bbsCount; j++) {
                t_unit = $('#txtUnit_' + j).val();
                t_mount = (!t_unit || emp(t_unit) || trim( t_unit).toLowerCase() == 'kg' ?  $('#txtWeight_' + j).val() : $('#txtMount_' + j).val());  // 計價量
                t_weight = t_weight + dec($('#txtWeight_' + j).val()); // 重量合計
                $('#txtTotal_' + j).val(round( $('#txtPrice_' + j).val() * dec( t_mount), 0));
                t1 = t1 + dec($('#txtTotal_' + j).val());
            }  // j

            $('#txtMoney').val(round(t1, 0));
            if( !emp( $('#txtPrice' ).val()))
                $('#txtTranmoney').val(round(t_weight * dec($('#txtPrice').val()), 0));

            $('#txtWeight').val(round(t_weight, 0));
            calTax();
			q_tr('txtTotalus' ,q_float('txtTotal')*q_float('txtFloata'));
        }

        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
            size_change();
			$('input[id*="txtProduct_"]').each(function(){
				t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				q_bodyId($(this).attr('id'));
				b_seq = t_IdSeq;
				OldValue = $(this).val();
				nowStyle = $('#txtStyle_'+b_seq).val();
				if(!emp(nowStyle) && (StyleList[0] != undefined)){
					for(var i = 0;i < StyleList.length;i++){
	               		if(StyleList[i].noa.toUpperCase() == nowStyle){
	              			styleProduct = StyleList[i].product;
							if(OldValue.substr(OldValue.length-styleProduct.length) == styleProduct){
								OldValue = OldValue.substr(0,OldValue.length-styleProduct.length);
							}
	               		}
	               	}
	            }
				$(this).attr('OldValue',OldValue);
			});
        }
		function q_popPost(s1) {
                switch (s1) {
                    case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function(){
		                	$(this).attr('OldValue',$(this).val());
		                });
		                ProductAddStyle(b_seq);
		                $('#txtStyle_' + b_seq).focus();
		                break;
                }
            }
						
		function ProductAddStyle(id){
			var Styleno = $('#txtStyle_' + id).val();
			var StyleName = '';
			var ProductVal = $('#txtProduct_' + id).attr('OldValue');
			ProductVal = (emp(ProductVal)?(emp($('#txtProductno_' + id).val())?'':$('#txtProduct_' + id).val()):ProductVal);
			if(!emp(Styleno) && (StyleList[0] != undefined)){
				for(var i = 0;i < StyleList.length;i++){
	              		if(StyleList[i].noa.toUpperCase() == Styleno){
	             			styleProduct = StyleList[i].product;
							if(ProductVal.substr(ProductVal.length-styleProduct.length) == styleProduct){
								ProductVal = ProductVal.substr(0,ProductVal.length-styleProduct.length);
							}
							ProductVal = ProductVal+styleProduct;
						}
				}
	        }
			$('#txtProduct_' + id).val(ProductVal);
		}

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
			size_change();
        }

        function btnMinus(id) {
            _btnMinus(id);
            sum();
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield);
            size_change();
            if (q_tables == 's')
                bbsAssign();  /// 表身運算式 
        }

        function q_appendData(t_Table) {
            dataErr = !_q_appendData(t_Table);
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
        
        function size_change () {
        	if(q_cur==1 || q_cur==2){
				$('input[id*="textSize"]').removeAttr('disabled');
			}else{
				$('input[id*="textSize"]').attr('disabled', 'disabled');
			}
			if($('#cmbKind').val().substr(0,1)=='A'){
				$('#lblSize_help').text("厚度x寬度x長度");
	        	for (var j = 0; j < q_bbsCount; j++) {
	            	$('#textSize1_'+j).show();
	            	$('#textSize2_'+j).show();
	            	$('#textSize3_'+j).show();
			        $('#textSize4_'+j).hide();
			        $('#x1_'+j).show();
			        $('#x2_'+j).show();
			        $('#x3_'+j).hide();
			        $('#Size').css('width','222px');
			        q_tr('textSize1_'+ j ,q_float('txtDime_'+j));
			        q_tr('textSize2_'+ j ,q_float('txtWidth_'+j));
			        q_tr('textSize3_'+ j ,q_float('txtLengthb_'+j));
			        $('#textSize4_'+j).val(0);
			        $('#txtRadius_'+j).val(0)
				}
			}else if( $('#cmbKind').val().substr(0,1)=='B'){
				$('#lblSize_help').text("短徑x長徑x厚度x長度");
			    for (var j = 0; j < q_bbsCount; j++) {
			    	$('#textSize1_'+j).show();
	            	$('#textSize2_'+j).show();
	            	$('#textSize3_'+j).show();
			        $('#textSize4_'+j).show();
			        $('#x1_'+j).show();
			        $('#x2_'+j).show();
			        $('#x3_'+j).show();
			        $('#Size').css('width','297px');
			        q_tr('textSize1_'+ j ,q_float('txtRadius_'+j));
			        q_tr('textSize2_'+ j ,q_float('txtWidth_'+j));
			        q_tr('textSize3_'+ j ,q_float('txtDime_'+j));
			        q_tr('textSize4_'+ j ,q_float('txtLengthb_'+j));
				}
			}else{//鋼筋和鋼胚
				$('#lblSize_help').text("長度");
	            for (var j = 0; j < q_bbsCount; j++) {
	            	$('#textSize1_'+j).hide();
	            	$('#textSize2_'+j).hide();
	            	$('#textSize3_'+j).show();
			        $('#textSize4_'+j).hide();
			        $('#x1_'+j).hide();
			        $('#x2_'+j).hide();
			        $('#x3_'+j).hide();
			        $('#Size').css('width','70px');
			        $('#textSize1_'+j).val(0);
			        $('#txtDime_'+j).val(0)
			        $('#textSize2_'+j).val(0);
			        $('#txtWidth_'+j).val(0)
			        q_tr('textSize3_'+ j ,q_float('txtLengthb_'+j));
			        $('#textSize4_'+j).val(0);
			        $('#txtRadius_'+j).val(0)
				}
			}
		}
    </script>
    <style type="text/css">
		#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 98%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 98%;
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
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 15%;
                float: left;
            }
            .txt.c5 {
                width: 85%;
                float: left;
            }
            .txt.c6 {
                width: 100%;
                float: left;
            }
            .txt.c7 {
            	float:left;
                width: 90%;
                
            }
            .txt.c8 {
            	float:left;
                width: 65px;
                
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
                font-size:medium;
            }
            .tbbm textarea {
            	font-size: medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
         .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width: 1500px;}
		 .dbbs .tbbs tr{height:35px;}
		 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
    </style>
</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:5%"><a id='vewTypea'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewTgg'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='typea=rc2.typea'>~typea=rc2.typea</td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='tggno tgg,4'>~tggno ~tgg,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
			<tr class="tr1">
               <td class='td1' ><span> </span><a id='lblType' class="lbl"></a></td>
               <td class='td2' ><input id="txtType" type="text"  style='width:0%;'/>
               							<select id="cmbTypea" class="txt c3"></select></td>
               <td class="td3" ><span> </span><a id='lblStype' class="lbl"></a></td>
               <!--<td class="td4"><select id="cmbStype" class="txt c3"></select></td>
               <td class='td5'><span> </span><a id="lblKind" class="lbl"> </a></td>-->
            	<td class="td4"><select id="cmbKind" class="txt c1"> </select></td>
               <td class="td5" ><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td6" ><input id="txtNoa" type="text"class="txt c1"/></td> 
               <td class="td7"><span> </span><a id='lblOrdc' class="lbl btn"></td>
                <td class="td8"><input id="txtOrdeno"  type="text"  class="txt c1"/></td> 
            </tr>
            <tr class="tr2">
               <td class="td1"><span> </span><a id='lblAcomp' class="lbl btn"></td>
               <td class="td2" colspan='2' ><input id="txtCno"  type="text" class="txt c2"/><input id="txtAcomp" type="text" class="txt c3"/></td>
                <td class="td4"><span> </span><a id='lblFloata' class="lbl"></a></td>
                <td class="td5" colspan='2'><select id="cmbCoin" class="txt c2" ></select><input id="txtFloata"   type="text" class="txt num c2" /></td>
                <td class="td7"><span> </span><a id='lblInvono' class="lbl btn"></a></td>
                <td class="td8"><input id="txtInvono"  type="text" class="txt c1"/></td> 
            </tr>
			<tr class="tr3">
                <td class="td1"><span> </span><a id='lblTgg' class="lbl btn"></td>
                <td class="td2" colspan='2'><input id="txtTggno" type="text" class="txt c2" /><input id="txtTgg"  type="text" class="txt c3"/></td>
                <td class="td4"><span> </span><a id='lblPaytype' class="lbl"></a></td>
                <td class="td5" colspan='2'><input id="txtPaytype" type="text" class="txt c3"/> <select id="combPaytype" class="txt c2" onchange='combPaytype_chg()'></select></td> 
                <td class="td6"><span> </span><a id='lblLcno' class="lbl btn"></a></td>
                <td class="td7"><input id="txtLcno"  type="text" class="txt c1"/></td> 
            </tr>
            <tr class="tr4">
                <td class="td1"><span> </span><a id='lblTel' class="lbl"></a></td>
                <td class="td2"><input id="txtTel" type="text" class="txt c1"/></td>
                <td class="td3"><span> </span><a id='lblTrantype' class="lbl"></a></td>
                <td class="td4"><select id="cmbTrantype" class="txt c3"></select></td>
                <td class="td5"><span> </span><a id='lblDatea' class="lbl"></a></td>
               <td class="td6" ><input id="txtDatea" type="text"  class="txt c1"/></td>
                <td class="td7" ><span> </span><a id='lblMon' class="lbl"></a></td>
                <td class="td8"><input id="txtMon" type="text"  class="txt c1"/></td> 
            </tr>
            <tr class="tr5">
                <td class="td1"><span> </span><a id='lblAddr' class="lbl"></a></td>
                <td class="td2" colspan='5' ><input id="txtPost"  type="text"  class="txt c4"/><input id="txtAddr"  type="text" class="txt c5"/></td>
                <td class="td7"><span> </span><a id='lblPrice' class="lbl"></a></td>
                <td class="td8"><input id="txtPrice"  type="text" class="txt num c1" /></td> 
            </tr>
            <tr class="tr6">
                <td class="td1"><span> </span><a id='lblCardeal' class="lbl btn"></td>
                <td class="td2" colspan='2'><input id="txtCardealno" type="text"  class="txt c2"/><input id="txtCar"  type="text" class="txt c3"/></td>
                <td class="td4"><span> </span><a id='lblCarno' class="lbl"></a></td>
                <td class="td5" colspan='2'><input id="txtCarno"    type="text" class="txt c2"/></td> 
                <td class="td7"><span> </span><a id='lblTranmoney' class="lbl"></a></td>
                <td class="td8"><input id="txtTranmoney" type="text" class="txt num c1" /></td> 
            </tr>
            <tr class="tr7">
                <td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
                <td class="td2" colspan='2'><input id="txtMoney" type="text" class="txt num c1" /></td> 
                <td class="td4" ><span> </span><a id='lblTax' class="lbl"></a></td>
                <td class="td5"><input id="txtTax" type="text" class="txt num c1" /></td>
                <td class="td6"><select id="cmbTaxtype" class="txt c1" onchange="calTax()"></select></td>
                <td class="td7"><span> </span><a id='lblTotal' class="lbl"></a></td>
                <td class="td8"><input id="txtTotal" type="text" class="txt num c1" />
                </td> 
            </tr>
            <tr class="tr8">
                <td class="td1"><span> </span><a id='lblTotalus' class="lbl"></a></td>
                <td class="td2" colspan='2'><input id="txtTotalus" type="text" class="txt num c1" /></td> 
                <td class="td4"><span> </span><a id='lblWeight' class="lbl"></a></td>
                <td class="td5" colspan='2' ><input id="txtWeight" type="text" class="txt num c1" /></td>
                <td class="td7"><span> </span><a id='lblAccc' class="lbl btn"></a></td>
                <td class="td8"><input id="txtAccno" type="text" class="txt c1"/></td> 
            </tr>
            <tr class="tr9">
                <td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
                <td class="td2" colspan='5' ><input id="txtMemo"  type="text" class="txt c7"/></td> 
                <td class="td7"><span> </span><a id='lblWorker' class="lbl"></a></td>
                <td class="td8"><input id="txtWorker"  type="text" class="txt c1"/></td> 
            </tr>
        </table>
        </div>
        </div>
        <div class='dbbs' >
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
           <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:10%;"><a id="lblUno_st" > </a></td>
                <td align="center" style="width:10%;"><a id='lblProductno_st'> </a></td>
                <td align="center" style="width:30px;"><a id='lblStyle_st'> </a></td>
                <td align="center" style="width:12%;"><a id='lblProduct_st'> </a></td>
                <td align="center" id='Size'><a id='lblSize_help'> </a><BR><a id='lblSize_st'> </a></td>
                <td align="center" style="width:10%;"><a id='lblSizea_st'></a></td>
                <td align="center" style="width:5%;"><a id='lblMount_st'></a></td>
                <td align="center" style="width:5%;"><a id='lblWeight_st'></a></td>
                <td align="center" style="width:5%;"><a id='lblPrices_st'></a></td>
                <td align="center" style="width:7%;"><a id='lblTotals_st'></a></td>
                <td align="center" style="width:5%;"><a id='lblCert_st'></a></td>
                <td align="center"><a id='lblMemos_st'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtUno.*" type="text" style="width:80%;" />
                	<input class="btn" id="btnUno.*" type="button" value='.' style="width:1%;"/></td>
                <td ><input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" /><input  id="txtProductno.*" type="text" style="width:83%;" />
                	<input id="txtClass.*" type="text"  style="width: 83%;"/>
                </td>
                <td ><input class="txt c6" id="txtStyle.*" style="text-align:center;" type="text" /></td>
                <td ><input class="txt c1" id="txtProduct.*" type="text" /></td>
                <!--<td><input class="txt c1" id="txtSpec.*" type="text"/></td>-->
                <td><input class="txt num c8" id="textSize1.*" type="text" disabled="disabled"/><div id="x1.*" style="float: left"> x</div>
                		<input class="txt num c8" id="textSize2.*" type="text" disabled="disabled"/><div id="x2.*" style="float: left"> x</div>
                        <input class="txt num c8" id="textSize3.*" type="text" disabled="disabled"/><div id="x3.*" style="float: left"> x</div>
                         <input class="txt num c8" id="textSize4.*" type="text" disabled="disabled"/>
                         <!--上為虛擬下為實際-->
                         <input id="txtRadius.*" type="hidden"/>
                		<input  id="txtWidth.*" type="hidden"/>
                        <input  id="txtDime.*" type="hidden"/>
                         <input id="txtLengthb.*" type="hidden"/>
                         <input class="txt c1" id="txtSpec.*" type="text"/>
                </td>
                <td><input id="txtSize.*" type="text" class="txt c1" /></td>
                <td><input id="txtMount.*" type="text" class="txt num c1" /></td>
                <td><input id="txtWeight.*" type="text" class="txt num c1" /></td>
                <td><input id="txtPrice.*" type="text"  class="txt num c1" /></td>
                <td><input id="txtTotal.*" type="text" class="txt num c1" />
                        <input id="txtGweight.*" type="text" class="txt num c1" /></td>
                <td><input id="btnCert.*" class="btnCert" type="button"/></td>
                <td><input id="txtMemo.*" type="text" class="txt c1"/>
	                <input id="txtOrdeno.*" type="text" style="float:left;width:65%;" />
	                <input id="txtNo2.*" type="text" style="float:left;width:26%;" />
	                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" />
                </td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
