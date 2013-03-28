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
        var q_name = "get";
        var q_readonly = ['txtNoa','txtWorker'];
        var q_readonlys = [];
        var bbmNum = [['txtTotal', 10, 1, 1]];  // 允許 key 小數
        var bbsNum = [['textSize1', 10, 3, 1],['textSize2', 10, 2, 1],['textSize3', 10, 3, 1],['textSize4', 10, 2, 1],['txtRadius', 10, 3, 1],['txtWidth', 10, 2, 1],['txtDime', 10, 3, 1],['txtLengthb', 10, 2, 1],['txtMount', 10, 0, 1],['txtGweight', 10, 2, 1],['txtWeight', 10, 1, 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'Datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
        aPop = new Array(['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
        ['txtStoreno','lblStore','store','noa,store','txtStoreno,txtStore','store_b.aspx'],
        ['txtUno_', 'btnUno_', 'uccc', 'noa,productno,product,spec,radius,width,dime,lengthb,emount,gweight,mweight,memo', 'txtUno_,txtProductno_,txtProduct_,txtSpec_,txtRadius_,txtWidth_,txtDime_,txtLengthb_,txtMount_,txtGweight_,txtWeight_,txtMemo_', 'uccc_b.aspx'],
        ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],
        ['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
        ['txtCardealno', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx']);
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  // 計算 合適  brwCount 
             q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)  /// q_sqlCount=最前面 top=筆數， q_init 為載入 q_sys.xml 與 q_LIST

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
            bbmMask = [['txtDatea', r_picd], ['txtCucdate', r_picd]];
            q_mask(bbmMask);
            q_cmbParse("cmbTypea", q_getPara('get.typea'));
            q_cmbParse("cmbKind", q_getPara('getst.kind'));
            q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
            // 需在 main_form() 後執行，才會載入 系統參數
            /* 若非本會計年度則無法存檔 */
			$('#txtDatea').focusout(function () {
				if($(this).val().substr( 0,3)!= r_accy){
			        	$('#btnOk').attr('disabled','disabled');
			        	alert(q_getMsg('lblDatea') + '非本會計年度。');
				}else{
			       		$('#btnOk').removeAttr('disabled');
				}
			});

            //變動尺寸欄位
            $('#cmbKind').change(function () {
            	size_change();
		     });

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
		
		
        function q_boxClose( s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
            var ret; 
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
                case 'tgg':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtTggno,txtComp,txtTel,txtPost,txtAddr,txtPay,cmbTrantype', 'noa,comp,tel,post_fact,addr_fact,pay,trantype');
                    break;

                case 'ucc':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtProductno_' + b_seq + ',txtProduct_' + b_seq, ret, 'noa,product');
                    break;

                case 'store':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtStoreno,txtStore', ret, 'noa,store');
                    break;

                case 'station':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtStationno,txtStation', ret, 'noa,station');
                    break;

                case 'ordes':
                    if (q_cur > 0 && q_cur < 4) {
                        b_ret = getb_ret();
                        if (!b_ret || b_ret.length == 0)
                            return;
                        var i, j = 0;
                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtSize,txtDime,txtWidth,txtLengthb,txtUnit,txtOrdeno,txtNo2', b_ret.length, b_ret
                                                           , 'productno,product,spec,size,dime,width,lengthb,unit,noa,no2'
                                                           , 'txtProductno,txtProduct,txtSpec');   /// 最後 aEmpField 不可以有【數字欄位】
                        bbsAssign();

                        for (i = 0; i < ret.length; i++) {
                            k = ret[i];  ///ret[i]  儲存 tbbs 指標
                            if (!b_ret[i]['unit'] || b_ret[i]['unit'].toUpperCase() == 'KG') {
                                $('#txtMount_' + k).val(b_ret[i]['notv']);
                                $('#txtWeight_' + k).val(divide0(b_ret[i]['weight'] * b_ret[i]['notv'], b_ret[i]['mount']));
                            }
                            else {
                                $('#txtWeight_' + k).val(b_ret[i]['notv']);
                                $('#txtMount_' + k).val(divide0(b_ret[i]['mount'] * b_ret[i]['notv'], b_ret[i]['weight']));
                            }

                        }  /// for i
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
            	case 'ucc_style':
            		theory_st(q_name,b_seq,'txtGweight');
            		break;
                case 'ucc':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtProductno_' + b_seq + ',txtProduct_' + b_seq + ',txtUnit_' + b_seq, 'noa,product,unit');
                    break;

                case 'store':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtStoreno,txtStore', 'noa,store');
                    break;

                case 'station':  ////  直接 key in 編號，帶入 form
                    q_changeFill(t_name, 'txtStationno,txtStation', 'noa,station');
                    break;

                case q_name: if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
//        function btnquat() {
//            var t_custno = trim($('#txtCustno').val());
//            var t_where='';
//            if (t_custno.length > 0) {
//                t_where = "enda='N' && " + (t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "");  ////  sql AND 語法，請用 &&  
//                t_where =  t_where ;
//            }
//            else {
//                alert(q_getMsg('msgCustEmp'));
//                return;
//            }

//            q_box('ordes_b.aspx', 'ordes;' + t_where , "95%", "650px", "報價視窗");
//        }

        function btnOk() {
			$('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
            }
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();
			var t_noa = trim($('#txtNoa').val());
			
            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('A' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('get_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
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
	                 
	                 //將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
	                 $('#textSize1_' + j).change(function () {
	                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
	                     q_bodyId($(this).attr('id'));
	                     b_seq = t_IdSeq;
	                     
	                   	if ($('#cmbKind').find("option:selected").text().indexOf('板')>-1)
		            	{	
		            		q_tr('txtDime_'+b_seq ,q_float('textSize1_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize1_' + b_seq).val());
		            	}else{
		            		q_tr('txtRadius_'+b_seq ,q_float('textSize1_'+b_seq));//短徑$('#txtRadius_'+b_seq).val($('#textSize1_' + b_seq).val());	
		            	}
	            		
	                     var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
						q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
	                 });
	                 $('#textSize2_' + j).change(function () {
	                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
	                     q_bodyId($(this).attr('id'));
	                     b_seq = t_IdSeq;
	                     
	                    if ($('#cmbKind').find("option:selected").text().indexOf('板')>-1)
		            	{	
		            		q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//寬度$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
		            	}else{
		            		q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//長徑$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
		            	}
	                     
	                     var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
						q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
	                 });
	                 $('#textSize3_' + j).change(function () {
	                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
	                     q_bodyId($(this).attr('id'));
	                     b_seq = t_IdSeq;
				         	
	                     if ($('#cmbKind').find("option:selected").text().indexOf('板')>-1)
		            	{	
		            		q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize3_' + b_seq).val());	
		            	}else{
		            		q_tr('txtDime_'+b_seq ,q_float('textSize3_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize3_' + b_seq).val());		
		            	}
	                     
	                     var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
						q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
	                 });
	                 $('#textSize4_' + j).change(function () {
	                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
	                     q_bodyId($(this).attr('id'));
	                     b_seq = t_IdSeq;
	                     
	                     if ($('#cmbKind').find("option:selected").text().indexOf('板')>-1)
		            	{	
		            		q_tr('txtRadius_'+b_seq ,q_float('textSize4_'+b_seq));//短徑為0 $('#txtRadius_'+b_seq).val($('#textSize4_' + b_seq).val());	
		            	}else{
		            		q_tr('txtLengthb_'+b_seq ,q_float('textSize4_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize4_' + b_seq).val());	
		            	}
	            		
	                     var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
						q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
	                 });
	                 $('#txtMount_' + j).change(function () {
	                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
	                     q_bodyId($(this).attr('id'));
	                     b_seq = t_IdSeq;
	                     var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
						q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
	                 });
					//-------------------------------------------------------------------------------------
				}
            } //j
            _bbsAssign();
            size_change();
        }

        function btnIns() {
            _btnIns();
            $('#cmbKind').val(1);
            size_change();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
         }
         
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtProduct').focus();
            size_change();
        }
        function btnPrint() {
 			q_box('z_getstp.aspx'+ "?;;;;" + r_accy+ ";noa=" + trim($('#txtNoa').val()), '', "800px", "600px", q_getMsg("popPrint"));
        }

        function wrServer( key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0],bbsKey[1],'',2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['productno']) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];
            as['custno'] = abbm2['custno'];
//            t_err ='';
//            if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
//                t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

//            
//            if (t_err) {
//                alert(t_err)
//                return false;
//            }
//            
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {
				t_weight+=dec($('#txtGweight_' + j).val()); // 重量合計
            }  // j
            
            $('#txtTotal').val(round(t_weight, 0));
			if( !emp( $('#txtPrice' ).val()))
                $('#txtTranmoney').val(round(t_weight * dec($('#txtPrice').val()), 0));
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
				q_name=='ina'||q_name=='cut'||q_name=='cnn'||q_name=='cng'||q_name=='vccd'||
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
		function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
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
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
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
                font-size: medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
         .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width:100%;}
		 .dbbs .tbbs tr{height:35px;}
		 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
		
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:20%"><a id='vewDatea'> </a></td>
                <td align="center" style="width:25%"><a id='vewStation'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='station'>~station</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
        	<td class='td1'><span> </span><a id="lblType" class="lbl"> </a></td>
            <td class="td2"><select id="cmbTypea" class="txt c1"> </select></td>
            <td class='td3'><span> </span><a id="lblDatea" class="lbl" > </a></td>
            <td class="td4"><input id="txtDatea" type="text" class="txt c1"/></td>
            <td class='td5'><span> </span><a id="lblNoa" class="lbl" > </a></td>
            <td class="td6"><input id="txtNoa" type="text"  class="txt c1"/></td>
        </tr>
        <tr class="tr2"> 
            <td class='td1'><span> </span><a id="lblStation" class="lbl btn" > </a></td>
            <td class="td2" colspan="3"><input id="txtStationno" type="text" class="txt c2"/><input id="txtStation" type="text"  class="txt c3"/></td>
       		 <td class='td5'><span> </span><a id="lblKind" class="lbl" > </a></td>
            <td class="td6"><select id="cmbKind" class="txt c1"> </select></td>
       </tr>
       <tr class="tr3">
            <td class='td1'><span> </span><a id="lblCustno" class="lbl btn" > </a></td>
            <td class="td2" colspan="3"><input id="txtCustno" type="text" class="txt c2"/><input id="txtComp" type="text"  class="txt c3"/></td>
       		<td class='td3'><span> </span><a id="lblVno" class="lbl"> </a></td>
            <td class="td4"><input id="txtVno" type="text" class="txt c1"/></td>
            <td class="td5"><input id="btnStk" type="button" /></td>
       </tr>
        <tr class="tr4">        
            <td class="td1"><span> </span><a id="lblStore" class="lbl btn"> </a></td>
            <td class="td2" colspan="3"><input id="txtStoreno" type="text" class="txt c2" /><input id="txtStore" type="text" class="txt c3"/></td> 
            <td class='td3'><span> </span><a id="lblWaste" class="lbl"> </a></td>
            <td class="td4"><input id="txtWaste" type="text" class="txt c1"/></td>
            <td class="td5"><input id="btnWaste" type="button" /> </td>
        </tr>
        <tr class="tr5">
        	<td class="td1"><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
        	<td class="td2" colspan="3"><input id="txtCardealno" type="text" class="txt c2"/><input id="txtCardeal" type="text" class="txt c3"/></td>
        	<td class="td3"><span> </span><a id="lblCarno" class="lbl"> </a></td>
        	<td class="td4"><input id="txtCarno" type="text" class="txt c1" /></td>
        </tr>
        <tr class="tr6">
        	<td class="td1"><span> </span><a id="lblTrantype" class="lbl"> </a></td>
        	<td class="td2"><select id="cmbTrantype" class="txt c1"> </select></td>
        	<td class="td3"><span> </span><a id="lblPrice" class="lbl"> </a></td>
        	<td class="td4"><input id="txtPrice" type="text" class="txt c1" /></td>
        	<td class="td5"><span> </span><a id="lblTranmoney" class="lbl"> </a></td>
        	<td class="td6"><input id="txtTranmoney" type="text" class="txt c1" /></td>
        </tr>
        <tr class="tr7"> 
        	<td class="td1"><span> </span><a id="lblTotal" class="lbl"> </a></td>
        	<td class="td2"><input id="txtTotal" type="text" class="txt c1" /></td>
        	<td class='td3'><span> </span><a id="lblWorker" class="lbl"> </a></td>
            <td class="td4"><input id="txtWorker" type="text" class="txt c1"/></td>
        </tr>
        <tr class="tr8">
        <td class='td1'><span> </span><a id="lblMemo" class="lbl" > </a></td>
        <td class="td2" colspan='5'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%; height: 50px;" > </textarea></td></tr>
        </table>
        </div>
		</div>
        <div class='dbbs' >
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:10%;"><a id='lblUno_st'> </a></td>
                <td align="center" style="width:8%;"><a id='lblProductno_st'> </a></td>
                <td align="center" style="width:10%;"><a id='lblProduct_st'> </a></td>
                <!--<td align="center" style="width:10%;"><a id='lblSpec_st'> </a></td>-->
                <!--<td align="center"><a id='lblRadius_s'> </a></td>-->
                <td align="center" id='Size'><a id='lblSize_st'> </a><BR><a id='lblSize_help'> </a></td>
                <td align="center" style="width:6%;"><a id='lblMount_st'> </a></td>
                <td align="center" style="width:6%;"><a id='lblGweight_st'> </a></td>
                <td align="center" style="width:6%;"><a id='lblWeight_st'> </a></td>
                <!--<td align="center" style="width:4%;"><a id='lblType_s'> </a></td>-->
                <td align="center"><a id='lblMemo_st'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td><input id="txtUno.*" type="text" style="width:75%;"/><input class="btn"  id="btnUno.*" type="button" value='...' style="width:15%;"  /></td>
                <td ><input  id="txtProductno.*" type="text" style="width:70%;" /><input class="btn"  id="btnProductno.*" type="button" value='...' style="width:16%;"  /></td>
                <td><input class="txt c1" id="txtProduct.*" type="text" /></td>
                <!--<td><input class="txt c1" id="txtSpec.*" type="text"/></td>-->
                <!--<td style="width:8%;"><input class="txt num c1" id="txtSradius.*" type="text" />
                					  <input class="txt num c1" id="txtLradius.*" type="text" /></td>-->
                <!--<td style="width:16%;"><input class="txt num c7" id="txtDime.*" type="text"/> x
                                    <input class="txt num c7" id="txtWidth.*" type="text"/> x
                                    <input class="txt num c7" id="txtLengthb.*" type="text"/> 
                </td>-->
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
                <td><input class="txt num c1" id="txtMount.*" type="text"/></td>
                <td><input class="txt num c1" id="txtGweight.*" type="text"/></td>
                <td><input class="txt num c1" id="txtWeight.*" type="text" /></td>
                <!--<td><input class="txt c1" id="txtTypea.*" type="text" /></td>-->
                <td><input class="txt c1" id="txtMemo.*" type="text" />
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
