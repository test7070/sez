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
        var q_name = "vcc";
        var decbbs = [ 'money','total', 'weight', 'mount', 'price', 'sprice', 'dime', 'width', 'lengthb', 'weight2'];
        var decbbm = ['payed', 'unpay', 'usunpay', 'uspayed', 'ustotal', 'discount', 'money', 'tax', 'total', 'weight', 'floata', 'mount', 'price', 'tranmoney','totalus'];
        var q_readonly = ['txtNoa']; 
        var q_readonlys= [];
        var bbmNum = [['txtTotalus', 10, 4, 1],['txtPrice', 10, 3, 1],['txtTranmoney', 10, 0, 1],['txtMoney', 10, 0, 1],['txtTotal', 10, 0, 1],['txtWeight', 10, 0, 1]];  // ���\ key �p��
        var bbsNum = [['textSize1', 10, 3, 1],['textSize2', 10, 2, 1],['textSize3', 10, 3, 1],['textSize4', 10, 2, 1],['txtRadius', 10, 3, 1],['txtWidth', 10, 2, 1],['txtDime', 10, 3, 1],['txtLengthb', 10, 2, 1],['txtMount', 10, 2, 1],['txtWeight', 10, 1, 1],['txtPrice', 10, 2, 1],['txtTotal', 10, 0, 1],['txtGweight', 10, 1, 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'datea';
        //ajaxPath = ""; 
		 aPop = new Array( ['txtCustno', 'lblCust', 'cust', 'noa,comp,tel,zip_invo,addr_invo,paytype', 'txtCustno,txtComp,txtTel,txtPost,txtAddr,txtPaytype', 'cust_b.aspx'],
		 ['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx'],
		 ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],
		 ['txtCarno', 'lblCar', 'cardeal', 'noa,comp', 'txtCarno,txtCar', 'cardeal_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  
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
            bbmMask = [['txtDatea', r_picd ]];
            q_mask(bbmMask);
            q_cmbParse("cmbTypea", q_getPara('vcc.typea'));  
            //q_cmbParse("cmbStype", q_getPara('rc2.stype'));   
            q_cmbParse("cmbCoin", q_getPara('sys.coin'));      
             q_cmbParse("combPaytype", q_getPara('rc2.paytype'));  
            q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
            q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
            q_cmbParse("cmbKind", q_getPara('rc2st.kind')); 
            /* 若非本會計年度則無法存檔 */
			$('#txtDatea').focusout(function () {
				if($(this).val().substr( 0,3)!= r_accy){
			        	$('#btnOk').attr('disabled','disabled');
			        	alert(q_getMsg('lblDatea') + '非本會計年度。');
				}else{
			       		$('#btnOk').removeAttr('disabled');
				}
			});
             $('#lblAccc').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('btnAccc'), true);
		        });
		        $('#lblOrdc').click(function () {
		            lblOrdc();
		        });
		       $('#cmbKind').change(function () {
            	size_change();
		     });

        }

        function q_boxClose( s2) { ///   q_boxClose 2/4 
            var ret; 
            switch (b_pop) {  
                case 'tgg':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtTggno,txtComp,txtTel,txtPost,txtAddr,txtPaytype,cmbTrantype', ret, 'noa,comp,tel,post_fact,addr_fact,paytype,trantype'); 
                    break;

                case 'ucc':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill( 'txtProductno_' + b_seq+',txtProduct_' + b_seq , ret, 'noa,product'); 
                    break;

                case 'acomp':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4)  q_browFill('txtCno,txtAcomp' , ret , 'noa,acomp'); 
                    break;

                /*case 'store':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill( 'txtStoreno_' + b_seq+',txtStore_' + b_seq , ret, 'noa,store'); 
                    break;*/

                /*case 'sss':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtSalesno,txtSales', ret, 'noa,namea');
                    break;*/

                case 'car':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4)  q_browFill('txtCarno,txtCar',ret , 'noa,car'); 
                    break;

                case 'ordcs':
                    if (q_cur > 0 && q_cur < 4) {
                        b_ret = getb_ret();
                        if (!b_ret || b_ret.length == 0)
                            return;
                        var i, j = 0;
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtRadius,txtOrdeno,txtNo2,txtPrice,txtMount,txtWeight,txtTotal,txtMemo', b_ret.length, b_ret
                                                           , 'productno,product,spec,size,dime,width,lengthb,radius,noa,no2,price,mount,weight,total,memo'
                                                           , 'txtProductno,txtProduct,txtSpec');   /// 最後 aEmpField 不可以有【數字欄位】
                        bbsAssign();
						size_change();
                        /*for (i = 0; i < ret.length; i++) {
                            k = ret[i];  ///ret[i]  儲存 tbbs 指標
                            if (!b_ret[i]['unit'] || b_ret[i]['unit'].toUpperCase() == 'KG') {
                                $('#txtMount_' + k).val(b_ret[i]['notv']);
                                $('#txtWeight_' + k).val(divide0(b_ret[i]['weight'] * b_ret[i]['notv'], b_ret[i]['mount']));
                            }
                            else {
                                $('#txtWeight_' + k).val(b_ret[i]['notv']);
                                $('#txtMount_' + k).val(divide0(b_ret[i]['mount'] * b_ret[i]['notv'], b_ret[i]['weight']));
                            }

                        }*/  /// for i
                    }
                    break;
                
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  /// 資料下載後 ...
            switch (t_name) {
                case 'tgg':   ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtTggno,txtComp,txtTel,txtPost,txtAddr,txtPaytype,cmbTrantype', 'noa,comp,tel,post_fact,addr_fact,paytype,trantype');
                    break;

                case 'acomp':   ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtCno,txtAcomp', 'noa,acomp');
                    break;

                /*case 'store':   ////  直接 key in 編號，帶入 form
                    //q_changeFill(t_name, 'txtStoreno,txtStore', 'noa,store');
                    q_changeFill(t_name, 'txtStoreno_' + b_seq + ',txtStore_' + b_seq, 'noa,store');
                    break;*/

                case 'car':   ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtCarno,txtCar', 'noa,car');
                    break;

                /*case 'sss':   ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtSalesno,txtSales', 'noa,namea');
                    break;*/

                case 'ucc':   ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtProductno_' + b_seq+ ',txtProduct_' + b_seq+ ',txtUnit_' + b_seq, 'noa,product,unit');
                    break;
				case 'ucc_style':
            			theory_st(q_name,b_seq,'txtWeight');
            		break;
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
            		t_where = "enda='N' && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "")+"&& " + (t_ordeno.length > 0 ? q_sqlPara("noa", t_ordeno) : "")+" && kind='"+$('#cmbKind').val()+"'";  ////  sql AND �y�k�A�Х� &&
            	else
                	t_where = "enda='N' && " + (t_tggno.length > 0 ? q_sqlPara("tggno", t_tggno) : "")+" && kind='"+$('#cmbKind').val()+"'";  ////  sql AND �y�k�A�Х� &&
                t_where = t_where;
            }
            else {
                alert(q_getMsg('msgTggEmp'));
                return;
            }
            q_box('ordcsst_b.aspx', 'ordcs;' + t_where, "95%", "650px", q_getMsg('popOrdcs'));
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtTggno', q_getMsg('lblTggno')], ['txtCno', q_getMsg('btnAcomp')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            $('#txtWorker' ).val(  r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('I' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }
		
		function q_stPost() {
		        if (!(q_cur == 1 || q_cur == 2))
		            return false;
		        abbm[q_recno]['accno'] = xmlString;
		        $('#txtAccno').val(xmlString);
		    }
		
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('vcc_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function combPaytype_chg() {   /// �u�� comb �}�Y�A�~�ݭn�g onChange()   �A��l cmb �s����Ʈw
            var cmb = document.getElementById("combPaytype")
            if (!q_cur) 
                cmb.value = '';
            else
                $('#txtPaytype').val(cmb.value);
            cmb.value = '';
        }

        function bbsAssign() {  /// 表身運算式
            _bbsAssign();
            for (var j = 0; j < ( q_bbsCount==0 ? 1 : q_bbsCount); j++) {
                $('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });
                $('#btnProductno_' + j).click(function () {
                    t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
                    pop('ucc', '_'+b_seq);
                 });
                 $('#txtProductno_' + j).change(function () {
                     t_IdSeq = -1; /// 要先給  才能使用 q_bodyId()
                     q_bodyId($(this).attr('id'));
                     b_seq = t_IdSeq;
                     q_change($(this), 'ucc', 'noa', 'noa,product');  /// 接 q_gtPost()
                 });

                 $('#btnStore_' + j).click(function () {
                    t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                    q_bodyId($(this).attr('id'));
                    b_seq = t_IdSeq;
                    pop('store', '_'+b_seq);
                 });
                 $('#txtStoreno_' + j).change(function () {
                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                     q_bodyId($(this).attr('id'));
                     b_seq = t_IdSeq;
                     q_change($(this), 'store', 'noa', 'noa,store');  /// 接 q_gtPost()
                 });
                 
                 //將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
		                 $('#textSize1_' + j).change(function () {
		                     t_IdSeq = -1;  
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     
		                    if ($('#cmbKind').find("option:selected").text().indexOf('板')>-1)
		            		{	
		            			q_tr('txtDime_'+b_seq ,q_float('textSize1_'+b_seq));//�p��$('#txtDime_'+b_seq).val($('#textSize1_' + b_seq).val());
		            		}else{
		            			q_tr('txtRadius_'+b_seq ,q_float('textSize1_'+b_seq));//�u�|$('#txtRadius_'+b_seq).val($('#textSize1_' + b_seq).val());	
		            		}
		            		
		                     var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
							q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
		                 });
		                 $('#textSize2_' + j).change(function () {
		                     t_IdSeq = -1;  
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     
		                    if ($('#cmbKind').find("option:selected").text().indexOf('板')>-1)
		            		{	
		            			q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//�e��$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
		            		}else{
		            			q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//��|$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
		            		}
		                     
		                     var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
							q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
		                 });
		                 $('#textSize3_' + j).change(function () {
		                     t_IdSeq = -1;  
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
					         	
		                     if ($('#cmbKind').find("option:selected").text().indexOf('板')>-1)
		            		{	
		            			q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));//$('#txtLengthb_'+b_seq).val($('#textSize3_' + b_seq).val());	
		            		}else{
		            			q_tr('txtDime_'+b_seq ,q_float('textSize3_'+b_seq));//$('#txtDime_'+b_seq).val($('#textSize3_' + b_seq).val());		
		            		}
		                     
		                     var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
							q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
		                 });
		                 $('#textSize4_' + j).change(function () {
		                     t_IdSeq = -1;  
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     
		                     if ($('#cmbKind').find("option:selected").text().indexOf('板')>-1)
		            		{	
		            			q_tr('txtRadius_'+b_seq ,q_float('textSize4_'+b_seq));// $('#txtRadius_'+b_seq).val($('#textSize4_' + b_seq).val());	
		            		}else{
		            			q_tr('txtLengthb_'+b_seq ,q_float('textSize4_'+b_seq));//$('#txtLengthb_'+b_seq).val($('#textSize4_' + b_seq).val());	
		            		}
		            		
		                     var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
							q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
		                 });
                //-------------------------------------------------
                $('#txtUnit_' + j).focusout(function () { sum(); });
                $('#txtWeight_' + j).focusout(function () { sum(); });
                $('#txtPrice_' + j).focusout(function () { sum(); });
                $('#txtMount_' + j).focusout(function () { sum(); });

            } //j
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtCno').val('1');
            $('#txtAcomp').val( r_comp.substr( 0,2));
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
            $('#cmbKind').val(1);
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
            _btnOk( null, bbmKey[0], bbsKey[1], '', 2);  // key_value
        }

        function bbsSave(as) {   
            if (!as['productno'] && !as['product'] && !as['spec'] && !dec( as['total'])) {  //不存檔條件
                as[bbsKey[1]] = '';
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
                t_mount = (!t_unit || emp(t_unit) || trim( t_unit).toLowerCase() == 'kg' ?  $('#txtWeight_' + j).val() : $('#txtMount_' + j).val());
                t_weight = t_weight + dec($('#txtWeight_' + j).val());
                $('#txtTotal_' + j).val(round( $('#txtPrice_' + j).val() * dec( t_mount)*t_float, 0));
                t1 = t1 + dec($('#txtTotal_' + j).val());
            }  // j

            $('#txtMoney').val(round(t1, 0));
            if( !emp( $('#txtPrice' ).val()))
                $('#txtTranmoney').val(round(t_weight * dec($('#txtPrice').val()), 0));

            $('#txtWeight').val(round(t_weight, 0));
            //$('#txtTotal').val(t1 + dec($('#txtTax').val()));
            calTax();

        }

        function refresh(recno) {
            _refresh(recno);
            size_change();
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            if (t_para) {
            	for (var j = 0; j < q_bbsCount; j++) {
		            $('#textSize1_'+j).attr('disabled', 'disabled');
		            $('#textSize2_'+j).attr('disabled', 'disabled');
		            $('#textSize3_'+j).attr('disabled', 'disabled');
		            $('#textSize4_'+j).attr('disabled', 'disabled');
		    	}
		    }else {
		    	for (var j = 0; j < q_bbsCount; j++) {
		        	$('#textSize1_'+j).removeAttr('disabled');
		        	$('#textSize2_'+j).removeAttr('disabled');
		        	$('#textSize3_'+j).removeAttr('disabled');
		        	$('#textSize4_'+j).removeAttr('disabled');
		        }
			}
        }

        function btnMinus(id) {
            _btnMinus(id);
            sum();
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield);
            if (q_tables == 's')
                bbsAssign(); 
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
		  if($('#cmbKind').find("option:selected").text().indexOf('板')>-1)
            	{
            		$('#lblSize_help').text("厚度x寬度x長度");
	            	for (var j = 0; j < q_bbsCount; j++) {
			           $('#textSize4_'+j).hide();
			           $('#x3_'+j).hide();
			           //$('#textSize1_'+j).css('width','30%');
			         	//$('#textSize2_'+j).css('width','30%');
			         	//$('#textSize3_'+j).css('width','30%');
			         	$('#Size').css('width','222px');
			         	q_tr('textSize1_'+ j ,q_float('txtDime_'+j));
			         	q_tr('textSize2_'+ j ,q_float('txtWidth_'+j));
			         	q_tr('textSize3_'+ j ,q_float('txtLengthb_'+j));
			           //$('#textSize1_'+j).val($('#txtDime_'+j).val());
			         	//$('#textSize2_'+j).val($('#txtWidth_'+j).val());
			         	//$('#textSize3_'+j).val($('#txtLengthb_'+j).val());
			         	$('#textSize4_'+j).val(0);
			         	$('#txtRadius_'+j).val(0)
			         }
			     }
		         else
		         {
		         	$('#lblSize_help').text("短徑x長徑x厚度x長度");
			         for (var j = 0; j < q_bbsCount; j++) {
			         	$('#textSize4_'+j).show();
			         	$('#x3_'+j).show();
			         	//$('#textSize1_'+j).css('width','22%');
			         	//$('#textSize2_'+j).css('width','22%');
			         	//$('#textSize3_'+j).css('width','22%');
			         	$('#Size').css('width','297px');
			         	q_tr('textSize1_'+ j ,q_float('txtRadius_'+j));
			         	q_tr('textSize2_'+ j ,q_float('txtWidth_'+j));
			         	q_tr('textSize3_'+ j ,q_float('txtDime_'+j));
			         	q_tr('textSize4_'+ j ,q_float('txtLengthb_'+j));
			         	//$('#textSize1_'+j).val($('#txtRadius_'+j).val());
			         	//$('#textSize2_'+j).val($('#txtWidth_'+j).val());
			         	//$('#textSize3_'+j).val($('#txtDime_'+j).val());
			         	//$('#textSize4_'+j).val($('#txtLengthb_'+j).val());
			         }
			     }
		}
		
		function theory_st(q_name,id,txtweight) { //id 為BBS的id,txtweight為要bbs寫入的欄位
			var calc="";
			//var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+id).val()+"' ^^"; 
			//q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
			var as = _q_appendData("ucc", "", true);
			if(as[0]==undefined)
			{
				alert('請輸入正確材質');
				return;
			}else{
				if(as[0].styleno=='')
				{
					alert('該品號尚未輸入樣式');
					return;
				}
			}
			//判斷表身參考theory:40
			if(q_name=='uccb'||q_name=='uccc'||q_name=='cubu'||q_name=='ins'||q_name=='rc2s'||
				q_name=='ina'||q_name=='cut'||q_name=='cnn'||q_name=='cng'||q_name=='vcc'||
				q_name=='rc2'||q_name=='ordc'||q_name=='ordb'||q_name=='get') 
			{
		        calc=as[0].calc3;//庫存
			}else{//內外銷與其他
				var cmb = document.getElementById("cmbStype");
				if (!cmb) {
					alert('cmbStype 不存在');
					return;
				}
				//qsys....orde.stype
				if($('#cmbStype').val()==3)
				    calc=as[0].calc2;	//外銷
				else
					calc=as[0].calc;	//內銷與其他
		
			}
			//空值判斷
			if(emp($('#txtDime_'+id).val()))
				$('#txtDime_'+id).val(0);
			if(emp($('#txtWidth_'+id).val()))
				$('#txtWidth_'+id).val(0);
			if(emp($('#txtLengthb_'+id).val()))
				$('#txtLengthb_'+id).val(0);
			if(emp($('#txtRadius_'+id).val()))
				$('#txtRadius_'+id).val(0);
			if(emp($('#txtMount_'+id).val()))
				$('#txtMount_'+id).val(0);

			eval('var result=' +calc.replace(/DIME/g,$('#txtDime_'+id).val()).replace(/WIDTH/g,$('#txtWidth_'+id).val()).replace(/LENGTH/g,$('#txtLengthb_'+id).val()).replace(/RADIUS/g,$('#txtRadius_'+id).val()));
		    //厚度=DIME 寬度=WIDTH 長度=LENGTH 外徑 =RADIUS
			q_tr(txtweight+'_'+id ,result*q_float('txtMount_'+id));//$('#'+txtweight+'_'+id).val(result*dec($('#txtMount_'+id).val()));
			
			var weight_total=0;
			for (var j = 0; j < q_bbsCount; j++) {
				weight_total+=dec($('#'+txtweight+'_'+j).val());
            }
			q_tr('txtTotal',weight_total);//$('#txtTotal').val(weight_total);
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
                width: 22%;
                
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
         .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width: 100%;}
		 .dbbs .tbbs tr{height:35px;}
		 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:5%"><a id='vewTypea'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='typea=vcc.typea'>~typea=vcc.typea</td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='custno comp,4'>~custno ~comp,4</td>
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
                <td class="td7"><span> </span><a id='lblInvono' class="lbl"></a></td>
                <td class="td8"><input id="txtInvono"  type="text" class="txt c1"/></td> 
            </tr>
			<tr class="tr3">
                <td class="td1"><span> </span><a id='lblCust' class="lbl btn"></a></td>
						<td class="td2">
						<input type="text" id="txtCustno" style="float:left;width:30%;"/>
						<input type="text" id="txtComp" style="float:left;width:70%;"/>
						</td>
                <td class="td4"><span> </span><a id='lblPaytype' class="lbl"></a></td>
                <td class="td5" colspan='2'><input id="txtPaytype" type="text" class="txt c3"/> <select id="combPaytype" class="txt c2" onchange='combPaytype_chg()'></select></td> 
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
                <td class="td1"><span> </span><a id='lblCar' class="lbl btn"></td>
                <td class="td2" colspan='2'><input id="txtCarno" type="text"  class="txt c2"/><input id="txtCar"  type="text" class="txt c3"/></td>
                <td class="td4"><span> </span><a id='lblCarno2' class="lbl"></a></td>
                <td class="td5" colspan='2'><input id="txtCarno2"    type="text" class="txt c2"/></td> 
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
                <td class="td2" colspan='5' ><input id="txtMemo"  type="text" class="txt c6"/></td> 
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
                <td align="center" style="width:8%;"><a id='lblProductno_st'> </a></td>
                <td align="center" style="width:10%;"><a id='lblProduct_st'> </a></td>
                <!--<td align="center" style="width:10%;"><a id='lblSpec_st'> </a></td>-->
                <td align="center" id='Size'><a id='lblSize_st'> </a><BR><a id='lblSize_help'> </a></td>
                <td align="center" style="width:5%;"><a id='lblMount_st'></a></td>
                <td align="center" style="width:5%;"><a id='lblWeight_st'></a></td>
                <td align="center" style="width:5%;"><a id='lblPrices_st'></a></td>
                <td align="center" style="width:7%;"><a id='lblTotals_st'></a></td>
                <td align="center"><a id='lblMemos_st'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td ><input  id="txtUno.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtProductno.*" type="text" style="width:70%;" /><input class="btn"  id="btnProductno.*" type="button" value='...' style="width:16%;"  /></td>
                <td ><input class="txt c1" id="txtProduct.*" type="text" /></td>
                <!--<td><input class="txt c1" id="txtSpec.*" type="text"/></td>-->
                <td><input class="txt num c8" id="textSize1.*" type="text"/><div id="x1" style="float: left"> x</div>
                		<input class="txt num c8" id="textSize2.*" type="text"/><div id="x2" style="float: left"> x</div>
                        <input class="txt num c8" id="textSize3.*" type="text"/><div id="x3.*" style="float: left"> x</div>
                         <input class="txt num c8" id="textSize4.*" type="text"/>
                           <!--上為虛擬下為實際-->
                         <input id="txtRadius.*" type="hidden"/>
                		<input  id="txtWidth.*" type="hidden"/>
                        <input  id="txtDime.*" type="hidden"/>
                         <input id="txtLengthb.*" type="hidden"/>
                         <input class="txt c1" id="txtSpec.*" type="text"/>
                </td>
                <td><input id="txtMount.*" type="text" class="txt num c1" /></td>
                <td><input id="txtWeight.*" type="text" class="txt num c1" /></td>
                <td><input id="txtPrice.*" type="text"  class="txt num c1" /></td>
                <td><input id="txtTotal.*" type="text" class="txt num c1" />
                        <input id="txtGweight.*" type="text" class="txt num c1" /></td>
                <td><input id="txtMemo.*" type="text" class="txt c1"/>
	                <input id="txtOrdeno.*" type="text" style="width:65%;" />
	                <input id="txtNo2.*" type="text" style="width:26%;" />
	                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" />
                </td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
