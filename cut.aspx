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
        var q_name = "cut";
        var q_readonly = ['txtProductno','txtProduct','txtSpec','txtDime','txtWidth','txtLengthb','txtRadius','txtOweight','txtEweight','txtTotalout','txtTheyout'];
        var q_readonlys = [];
        var bbmNum = [];  
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx'],
        ['txtUno', 'lblUno', 'uccc', 'noa,productno,product,spec,dime,width,lengthb,radius,weight,eweight', 'txtUno,txtProductno,txtProduct,txtSpec,txtDime,txtWidth,txtLengthb,txtRadius,txtOweight,txtEweight', 'uccc_seek_b.aspx','95%','60%'],
        ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],['txtCustno_', 'btnCust_', 'cust', 'noa,comp', 'txtCustno_,txtCust_', 'cust_b.aspx'],['txtMechno', 'lblMech', 'mech', 'noa,mech', 'txtMechno,txtMech', 'mech_b.aspx']);
        //['txtProductno', 'lblProduct', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx']
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();   
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy )
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
        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask); 
             q_cmbParse("cmbTypea", q_getPara('cut.typea'));
             q_cmbParse("cmbType2", q_getPara('cut.type2'));
              q_cmbParse("cmbKind", q_getPara('cut.kind'));

             //重新計算理論重 
            $('#cmbTypea').change(function () {
				for(var j = 0; j < q_bbsCount; j++) {
		                     theory(j);
		        }
		        cut_save_db();
		     });
		     $('#cmbType2').change(function () {
				for(var j = 0; j < q_bbsCount; j++) {
		                     theory(j);
		        }
		        cut_save_db();
		     });
		     $('#txtGweight').change(function () {
				for(var j = 0; j < q_bbsCount; j++) {
		                     theory(j);
		        }
		        cut_save_db();
		     });
		     //變動尺寸欄位
	            $('#cmbKind').change(function () {
	            	size_change();
			     });
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 
            var ret;
            switch (b_pop) {   
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'ordes':
            		ordes=_q_appendData("ordes", "", true);
            		if(ordes[0]==undefined)
            			alert("訂單不存在");
            		break;
            	case 'ucc':
            		ucc= _q_appendData("ucc", "", true);
            		break;
            	case 'uccb':
            		i_uno=1;
            		uccb= _q_appendData("uccb", "", true);
            		//取得餘料編號
            		if(uccb[uccb.length-1]!=undefined)
            		{
            			if(uccb[uccb.length-1].noa.indexOf('-')>-1)	//取-之後的數字
            			{
            				i_uno=parseInt(uccb[uccb.length-1].noa.slice(uccb[uccb.length-1].noa.indexOf('-')+1).toString(10))+1;
            			}	
            		}
            		//判斷已有領用
            		if(uccb[0]!=undefined)
            		{
            			for(var i=0;i<uccb.length;i++)
	            		{
	            			if($('#txtUno').val()==uccb[i].noa)
	            			{
	            				uccb_gweight=uccb[i].gweight;
	            			}
	            		}
            		}
            		
            		break;
                case q_name: 
	                if(q_cur == 1)
	                	cuts= _q_appendData("cut", "", true);
	                if (q_cur == 4)   
	                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
		var i_uno=1;	//餘料編號初始值
        function btnOk() {
        	$('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
            }
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            
            //參考cut_save
            if(emp($('#txtUno').val())&&dec($('#txtGweight').val())>0)
            {
            	alert("批號不可為空白");
                return;
            }
            
            if(dec($('#txtTheyout').val())>dec($('#txtGweight').val()))
            {
            	alert("產出實際重 > 領料重");
                return;
            }
            
            if(	dec($('#txtTheyout').val())>0 && dec($('#txtGweight').val())>0
            	&&((Math.abs(dec($('#txtTheyout').val())-dec($('#txtGweight').val())))/dec($('#txtGweight').val()))>0.05)
            {
            	alert("產出實際重、領料重，差異過大");
                return;
            }
            
            if(emp($('#txtTggno').val())&&$('#cmbTypea').find("option:selected").text().indexOf('委')>-1)
            {
            	alert("委外廠商不可為空白");
                return;
            }else{
            	 if(emp($('#txtMechno').val())&&!($('#cmbTypea').find("option:selected").text().indexOf('委')>-1||!emp($('#txtTggno').val())))
            	{
            		alert("機台不可為空白");
                	return;
            	}
            }
            
            if(q_cur >0 &&dec($('#txtPrice').val())>0)
            	$('#txtTranmoney').val(dec($('#txtPrice').val())*dec($('#txtTheyout').val()))
            
            if($('#cmbTypea').find("option:selected").text().indexOf('條')>-1)
            {
            	if(cuts[0]!=undefined && cuts[0].typea==$('#cmbTypea').val()&&dec($('#txtTheyout').val())==0)
            	{
	            	alert("不可重覆分條");
	                return;
	            }
            }
            
            if(dec($('#txtTheyout').val())!=0&&dec($('#txtGweight').val())==0)
            {
            	alert("領料重為零");
                return;
            }
            
            if(dec($('#txtTheyout').val())!=0&&dec($('#txtGmount').val())==0)
            {
            	alert("領料數為零");
                return;
            }
            
            if($('#cmbTypea').find("option:selected").text()=='分條')//cut_save為切條
            {
            	var t_weight=0;
				for(var j = 0; j < q_bbsCount; j++) {
					t_weight+=dec($('#txtWeight_'+j).val())
				}
				if(t_weight!=dec($('#txtGweight').val()))
				{
					alert("領料重量不等於入庫總重量");
                	return;
				}	
            }
            if($('#cmbTypea').find("option:selected").text().indexOf('委')==-1)
            {
	            for(var j = 0; j < q_bbsCount; j++) {
	            	if(emp($('#txtBno_'+j).val())&&$('#txtXbutt_'+j).val()>='X')
	            	{
	            		$('#txtBno_'+j).val($('#txtXbutt_'+j).val()+'001');
	            	}
	            	if(emp($('#txtStyle_'+j).val())&&!emp($('#txtBno_'+j).val()))
	            	{
	            		alert("無型別,請檢查");
	                	return;
	            	}
	            	if($('#txtStyle_'+j).val()=='c'&&trim($('#txtBno_'+j).val()).length>12)
	            	{
	            		alert("批號異常，清空批號再重新產生，並確認是否已有領料");
	                	return;
	            	}
	            }
            }
            
            for(var j = 0; j < q_bbsCount; j++) {
            	if(!emp($('#txtOrdeno_'+j).val())&&emp($('#txtNo2_'+j).val()))
	            {
	            	alert("訂序為空");
	                return;
	            }
				if(dec($('#txtWeight_'+j).val())>0 && emp($('#txtDatea').val()))
				{
					alert("表身有重量,日期為空");
	                return;
				}
				if(dec($('#txtWeight_'+j).val())>0 && emp($('#txtWidth_'+j).val()))
				{
					alert("表身重量或寬度小於零");
	                return;
				}
				if($('#cmbTypea').find("option:selected").text().indexOf('委')>-1&&$('#txtXbutt_'+j).val()>='X')
				{
					$('#txtBno_'+j).val($('#txtXbutt_'+j).val()+'001');
				}
				if(dec($('#txtDime_'+j).val())==dec($('#txtWidth_'+j).val())&&dec($('#txtWidth_'+j).val())>0)
				{
					alert("表身尺寸異常");
	                return;
				}
            }
            //判斷已領用
			if(uccb_gweight>0)//dec($('#txtGweight').val())>uccb_gweight
	       	{
	           	alert("已有領用");
	        	return;
	        }
			
            //------------參考cut_save
            
            //--------------自動產生餘料編號
			for(var j = 0; j < q_bbsCount; j++) {
				var tmp_uno=trim($('#txtUno').val());
				if(!($('#txtUno').val().indexOf('-')>-1))
					tmp_uno=tmp_uno+'-';
					
				if(!emp($('#txtWeight_'+j).val())&&emp($('#txtBno_'+j).val())) //有入庫重自動產生餘料編號
				{
					$('#txtBno_'+j).val(tmp_uno+i_uno.toString(16).toUpperCase());
					i_uno++;
				}
			}
            //------------------------------------------
			//判斷餘料編號是否重複
			for(var i = 0; i < q_bbsCount; i++) {
				for(var j = 0; j < q_bbsCount; j++) {
					if(i!=j&&!emp($('#txtBno_'+i).val())&&!emp($('#txtBno_'+j).val())&&$('#txtBno_'+i).val()==$('#txtBno_'+j).val())
					{
						alert("表身餘料編號重複");
	                	return;
					}
				}
			}
			//----------------------------
            $('#txtWorker').val(r_name);
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('cut_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   
        }

        function bbsAssign() {  
        	for(var j = 0; j < q_bbsCount; j++) {
            	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
            		//將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
					$('#textSize1_' + j).change(function () {
			            t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			            q_bodyId($(this).attr('id'));
			            b_seq = t_IdSeq;
			                     
			            if ($('#cmbKind').val().substr(0,1)=='A')
			            {	
			            	q_tr('txtDime_'+b_seq ,q_float('textSize1_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize1_' + b_seq).val());
			            }else if( $('#cmbKind').val().substr(0,1)=='B'){
			            	q_tr('txtRadius_'+b_seq ,q_float('textSize1_'+b_seq));//短徑$('#txtRadius_'+b_seq).val($('#textSize1_' + b_seq).val());	
			            }
			            		
			            theory(b_seq);
		                cut_save_db();
		                sum();
		            });
		            $('#textSize2_' + j).change(function () {
		            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                q_bodyId($(this).attr('id'));
		                b_seq = t_IdSeq;
		                     
		                if ($('#cmbKind').val().substr(0,1)=='A')
		            	{	
		            		q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//寬度$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
		            	}else if($('#cmbKind').val().substr(0,1)=='B'){
		            		q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//長徑$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
		            	}
		                     
						theory(b_seq);
		                cut_save_db();
		                sum();
					});
		            $('#textSize3_' + j).change(function () {
		            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                q_bodyId($(this).attr('id'));
		                b_seq = t_IdSeq;
					         	
		                if ($('#cmbKind').val().substr(0,1)=='A')
		            	{	
		            		q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize3_' + b_seq).val());	
						}else if( $('#cmbKind').val().substr(0,1)=='B'){
		            		q_tr('txtDime_'+b_seq ,q_float('textSize3_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize3_' + b_seq).val());		
						}else{//鋼筋、胚
		            		q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));
						}
		                     
		                theory(b_seq);
		                cut_save_db();
		                sum();
					});
		            $('#textSize4_' + j).change(function () {
		            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                q_bodyId($(this).attr('id'));
		                b_seq = t_IdSeq;
		                     
		                if ($('#cmbKind').val().substr(0,1)=='A')
		            	{	
		            		q_tr('txtRadius_'+b_seq ,q_float('textSize4_'+b_seq));//短徑為0 $('#txtRadius_'+b_seq).val($('#textSize4_' + b_seq).val());	
						}else if($('#cmbKind').val().substr(0,1)=='B'){
		            		q_tr('txtLengthb_'+b_seq ,q_float('textSize4_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize4_' + b_seq).val());	
						}
		            		
		                theory(b_seq);
		                cut_save_db();
		                sum();
					});
            		//計算理論重
            		$('#txtRadius_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     theory(b_seq);
		                     cut_save_db();
		                     sum();
		              });
		              $('#txtDivide_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     theory(b_seq);
		                     cut_save_db();
		                     sum();
		              });
		              $('#txtWidth_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     theory(b_seq);
		                     cut_save_db();
		                     sum();
		              });
		              $('#txtMount_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     theory(b_seq);
		                     cut_save_db();
		                     sum();
		              });
		              $('#txtDime_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     theory(b_seq);
		                     cut_save_db();
		                     sum();
		              });
		              $('#txtLengthb_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     theory(b_seq);
		                     cut_save_db();
		                     sum();
		              });
		              //判斷訂單是否存在
		              $('#txtOrdeno_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     if(!emp($('#txtOrdeno_' + b_seq))&&!emp($('#txtOrdeno_' + b_seq)))
		                     {
		                     	var t_where = "where=^^ noa = '"+ $('#txtOrdeno_'+b_seq).val()+"' and no2 = '"+$('#txtNo2_'+b_seq).val()+"' ^^"; 
								q_gt('ordes', t_where , 0, 0, 0, "", r_accy);
							}
		              });
		              $('#txtNo2_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     if(!emp($('#txtOrdeno_' + b_seq))&&!emp($('#txtOrdeno_' + b_seq)))
		                     {
		                     	var t_where = "where=^^ noa = '"+ $('#txtOrdeno_'+b_seq).val()+"' and no2 = '"+$('#txtNo2_'+b_seq).val()+"' ^^"; 
								q_gt('ordes', t_where , 0, 0, 0, "", r_accy);
							}
		              });
        		}
        	}
            _bbsAssign();
            size_change();
        }

        function btnIns() {
            _btnIns();
            $('#cmbKind').val(q_getPara('vcc.kind'));
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
            //取得品名的密度-計算理論重
            var t_where = "where=^^ noa = '"+ $('#txtProductno').val()+"' ^^"; 
			q_gt('ucc', t_where , 0, 0, 0, "", r_accy);
			//取得餘料編號
			t_where = "where=^^ noa like '%"+ $('#txtUno').val()+"%' ^^"; 
			q_gt('uccb', t_where , 0, 0, 0, "", r_accy);
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['custno'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['datea'] = abbm2['datea'];

            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            var t_totalout=0;
            for (var j = 0; j < q_bbsCount; j++) {
				t_totalout+=dec($('#txtTheory_'+j).val());
            }  // j
			$('#txtTotalout').val(t_totalout);
        }

        function refresh(recno) {
            _refresh(recno);
            size_change();
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
        	if (dec($('#txtGweight').val())>0)
        	{
        		alert("已有領料禁止刪除");
                return;
             }
            _btnDele();
        }

        function btnCancel() {
            _btnCancel();
        }
        
        
        function theory(id) {	
        	var t_density=7.85;//預設
            if(dec($('#txtRadius_'+id).val())==0 &&$('#cmbTypea').val()=='3')	//非管類
            {
            	if($('#cmbType2').find("option:selected").text().indexOf('條')>-1 || $('#cmbType2').find("option:selected").text().indexOf('貼膜')>-1 || $('#cmbTypea').find("option:selected").text().indexOf('條')>-1)
            	{
            		if(dec($('#txtWidth').val())>0)
            		{
            			if(dec($('#txtGweight').val())>0)
            			{//加工重量=原重量/原寬度*加寬*數量
            				if(dec($('#txtDivide_'+id).val())>0)
            					$('#txtTheory_'+id).val(dec($('#txtGweight').val())/dec($('#txtWidth').val())*dec($('#txtWidth_'+id).val())*dec($('#txtMount_'+id).val())*dec($('#txtDivide_'+id).val()));
            				else
            					$('#txtTheory_'+id).val(dec($('#txtGweight').val())/dec($('#txtWidth').val())*dec($('#txtWidth_'+id).val())*dec($('#txtMount_'+id).val())*1);
            			}else{
            				if(dec($('#txtDivide_'+id).val())>0)
            					$('#txtTheory_'+id).val(dec($('#txtEweight').val())/dec($('#txtWidth').val())*dec($('#txtWidth_'+id).val())*dec($('#txtMount_'+id).val())*dec($('#txtDivide_'+id).val()));
            				else
            					$('#txtTheory_'+id).val(dec($('#txtEweight').val())/dec($('#txtWidth').val())*dec($('#txtWidth_'+id).val())*dec($('#txtMount_'+id).val())*1);
            			}
            		}
            	}else{
            		//根據BBM的品名NO找UCC的密度
            		if(ucc[0]!=undefined)
            		{
            			t_density=ucc[0].density;
            		}

            		//標準重量=比重*原厚度*原寬度/1000*原長度/1000 &&加工重量=標準重量*數量
            		if(dec($('#txtDivide_'+id).val())>0)
            			$('#txtTheory_'+id).val(t_density*dec($('#txtDime_'+id).val())*(dec($('#txtWidth_'+id).val())/1000)*(dec($('#txtLengthb_'+id).val()) /1000)*dec($('#txtMount_'+id).val())*dec($('#txtDivide_'+id).val()));
            		else
            			$('#txtTheory_'+id).val(t_density*dec($('#txtDime_'+id).val())*(dec($('#txtWidth_'+id).val())/1000)*(dec($('#txtLengthb_'+id).val()) /1000)*dec($('#txtMount_'+id).val())*1);
            	}
            }
            if(dec($('#txtRadius_'+id).val())!=0)
            {
            	$('#txtWeight_'+id).val($('#txtTheory_'+id).val());
            }
            
        }
        var ordes=[];//ordes資料內容
        var ucc=[];	//ucc資料內容
        var uccb=[];	//uccb資料內容
        var uccb_gweight=0;
        var cuts=[];	//cut資料內容
        function cut_save_db() {	
       			//取得品名的密度-計算理論重
	            var t_where = "where=^^ noa = '"+ $('#txtProductno').val()+"' ^^"; 
				q_gt('ucc', t_where , 0, 0, 0, "", r_accy);
				//取得餘料編號
				t_where = "where=^^ noa like '%"+ $('#txtUno').val()+"%' ^^"; 
				q_gt('uccb', t_where , 0, 0, 0, "", r_accy);
				if(q_cur == 1)
				{
					//取得是否重複分條
					t_where = "where=^^ uno = '"+ $('#txtUno').val()+"' ^^"; 
					q_gt('cut', t_where , 0, 0, 0, "", r_accy);
				}else{
					cuts=[];
				}
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
	function size_change () {
			if(q_cur==1 || q_cur==2){
				$('input[id*="textSize"]').removeAttr('disabled');
			}else{
				$('input[id*="textSize"]').attr('disabled', 'disabled');
			}
			if( $('#cmbKind').val().substr(0,1)=='A'){
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
                width: 18%;
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
                width: 80%;
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
                width: 98%;
                float: left;
            }
            .txt.c3 {
                width: 38%;
                float: left;
            }
            .txt.c4 {
                width: 60%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c8 {
                width: 65px;
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
<div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewOrdeno'></a></td>
                <td align="center" style="width:40%"><a id='vewCust'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='ordeno'>~ordeno</td>
                   <td align="center" id='custno cust'>~custno ~cust</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='td1'><span> </span><a id="lblDatea" class="lbl" ></a></td>
            <td class="td2"><input id="txtDatea" type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblNoa" class="lbl"></a></td>
            <td class="td4"><input id="txtNoa" type="text" class="txt c1"/></td>
            <td class='td5'><span> </span><a id="lblType"class="lbl" ></a></td>
            <td class="td6"><select id="cmbTypea" class="txt c1"></select></td> 
             <td class='td7'><span> </span><a id="lblKind" class="lbl"> </a></td>
            <td class="td8"><select id="cmbKind" class="txt c1"> </select></td>
        </tr>
        <tr>
            <td class='td1'><span> </span><a id="lblMech" class="lbl btn" ></a></td>
            <td class="td2"><input id="txtMechno" type="text" class="txt c3" />
            <input id="txtMech"  type="text"  class="txt c4"/></td>
            <td class='td3'><span> </span><a id="lblType2"class="lbl" ></a></td>
            <td class="td4"><select id="cmbType2" class="txt c1"></select></td><!--<input id="txtType2" type="text" class="txt c1" />-->
            <td class='td5'><span> </span><a id="lblCust" class="lbl btn" ></a></td>
            <td class="td6"><input id="txtCustno" type="text"  class="txt c1"/></td>
            <td class="td7" colspan="2"><input id="txtCust" type="text"  class="txt c1"/></td>
        </tr>
        <tr>
            <td class='td1'><span> </span><a id="lblUno" class="lbl btn"></a></td>
            <td class="td2"><input id="txtUno" type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblProduct" class="lbl"></a></td>
            <td class="td4"><input id="txtProductno" type="text" class="txt c3"/>
                <input id="txtProduct" type="text" class="txt c4"/></td>
            <td class='td5'><span> </span><a id="lblSpec" class="lbl"></a></td>
            <td class="td6"><input id="txtSpec" type="text" class="txt c1"/></td> 
            <td class='td7'><span> </span><a id="lblCuano" class="lbl"></a></td>
            <td class="td8"><input id="txtCuano" type="text" class="txt c2"/></td>
        </tr> 
        <tr>
            <td class='td1'><span> </span><a id="lblDime" class="lbl"></a></td>
            <td class="td2"><input id="txtDime" type="text" class="txt num c1" /></td>
            <td class='td3'><span> </span><a id="lblWidth" class="lbl" ></a></td>
            <td class="td4"><input id="txtWidth" type="text" class="txt num c1" /></td>
            <td class='td5'><span> </span><a id="lblLengthb" class="lbl"></a></td>
            <td class="td6"><input id="txtLengthb" type="text" class="txt num c1"  /></td> 
            <td class='td7'><span> </span><a id="lblRadius" class="lbl"></a></td>
            <td class="td8"><input id="txtRadius" type="text" class="txt num c2" /></td>
        </tr>  
        <tr>
            <td class='td1'><span> </span><a id="lblOweight" class="lbl" ></a></td>
            <td class="td2"><input id="txtOweight" type="text" class="txt num c1" /></td>
            <td class='td3'><span> </span><a id="lblEweight" class="lbl"></a></td>
            <td class="td4"><input id="txtEweight" type="text" class="txt num c1" /></td>
                   
        </tr>     
        <tr>
            <td class='td1'><span> </span><a id="lblGweight" class="lbl" ></a></td>
            <td class="td2"><input id="txtGweight" type="text" class="txt num c1" /></td> 
            <td class='td3'><span> </span><a id="lblGtime" class="lbl"></a></td>
            <td class="td4"><input id="txtGtime" type="text" class="txt c1"/></td>
            <td class='td5'><span> </span><a id="lblGmount" class="lbl"></a></td>
            <td class="td6"><input id="txtGmount" type="text" class="txt num c1" /></td>
        </tr>
         <tr>
            <td class='td1'><span> </span><a id="lblMon" class="lbl"></a></td>
            <td class="td2"><input id="txtMon" type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblTgg" class="lbl btn"></a></td>
            <td class="td4" ><input id="txtTggno" type="text" class="txt c1"/></td> 
            <td class="td5" colspan="4"><input id="txtTgg" type="text"  class="txt c2"/></td>           
        </tr> 
        <tr>
            <td class='td1'><span> </span><a id="lblLoss" class="lbl"></a></td>
            <td class="td2"><input id="txtLoss" type="text" class="txt c1"/></td> 
            <td class='td3'><span> </span><a id="lblTheyout" class="lbl" ></a></td>
            <td class="td4"><input id="txtTheyout" type="text" class="txt num c1" /></td>
            <td class='td5'><span> </span><a id="lblTotalout" class="lbl" ></a></td>
            <td class="td6"><input id="txtTotalout" type="text"class="txt num c1" /></td>
        </tr> 
        <tr>
        <td class='td1'><span> </span><a id="lblMemo" class="lbl" ></a></td>
        <td class="td2" colspan='7'><textarea id="txtMemo" rows="5" cols="10" style="width: 98%; height: 50px;"></textarea></td>
        </tr>
        <tr>
            <td class='td1'><span> </span><a id="lblComp" class="lbl"></a></td>
            <td class="td2"><input id="txtComp" type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblCarno"  class="lbl"></a></td>
            <td class="td4"><input id="txtCarno" type="text" class="txt c1"/></td>
            <td class='td5'><span> </span><a id="lblPrice" class="lbl" ></a></td>
            <td class="td6"><input id="txtPrice" type="text" class="txt num c1" /></td> 
            <td class='td7'><span> </span><a id="lblTranmoney" class="lbl" ></a></td>
            <td class="td8"><input id="txtTranmoney" type="text" class="txt num c2" /></td>
        </tr>
        <tr>
            <td class='td1'><span> </span><a id="lblOrdeno" class="lbl"></a></td>
            <td class="td2"><input id="txtOrdeno" type="text" class="txt c2"/></td>
            <td class="td3"></td>
            <td class="td4"></td>
            <td class="td5"></td>
            <td class="td6"></td>
            <td class='td7'><span> </span><a id="lblWorker" class="lbl" ></a></td>
            <td class="td8"><input id="txtWorker" type="text" class="txt c2"/></td>
        </tr>                   
        </table>
        </div>
       </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' style="width: 2000px;"  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblCustno'></a></td>
                <td align="center"><a id='lblComps'></a></td>
                <td align="center"><a id='lblStyle'></a></td>
                <td align="center" id='Size'><a id='lblSize_st'> </a><BR><a id='lblSize_help'> </a></td>
                <!--<td align="center"><a id='lblDimes'></a></td>
                <td align="center"><a id='lblWidths'></a></td>
                <td align="center"><a id='lblLengthbs'></a></td>-->
                <td align="center"><a id='lblMounts'></a></td>
                <td align="center"><a id='lblDivide'></a></td>
                <td align="center"><a id='lblTheory'></a></td>
                <td align="center"><a id='lblHweight'></a></td>
                <td align="center"><a id='lblWeight'></a></td>
                <td align="center"><a id='lblXbutt'></a></td>
                <td align="center"><a id='lblBno'></a></td>
                <td align="center"><a id='lblStoreno'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
                <td align="center" ><a id='lbltime'></a></td>
                <td align="center" ><a id='lblProductno'></a></td>
                <td align="center" ><a id='lblSpecs'></a></td>
                <td align="center"><a id='lblWprice'></a></td>
                <td align="center"><a id='lblSize'></a></td>
                <!--<td align="center"><a id='lblRadiuss'></a></td>-->
                <td align="center"><a id='lblMweight'></a></td>
                <td align="center"><a id='lblOrdenos'></a></td>
                <td align="center" ><a id='lblNo2'></a></td>
                <td align="center" ><a id='lblSpecial'></a></td>
                <td align="center" ><a id='lblCname'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input id="txtCustno.*" type="text" style="width: 80%;"/><input id="btnCust.*" type="button" value="..." style="width: 14%;"/></td>
                <td ><input class="txt num c1" id="txtCust.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtStyle.*" type="text" /></td>
                <!--<td ><input class="txt num c1" id="txtDime.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtWidth.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtLengthb.*" type="text" /></td>-->
                <td><input class="txt num c8" id="textSize1.*" type="text" disabled="disabled"/><div id="x1.*" style="float: left"> x</div>
                		<input class="txt num c8" id="textSize2.*" type="text" disabled="disabled"/><div id="x2.*" style="float: left"> x</div>
                        <input class="txt num c8" id="textSize3.*" type="text" disabled="disabled"/><div id="x3.*" style="float: left"> x</div>
                         <input class="txt num c8" id="textSize4.*" type="text" disabled="disabled"/>
                         <!--上為虛擬下為實際-->
                         <input id="txtRadius.*" type="hidden"/>
                		<input  id="txtWidth.*" type="hidden"/>
                        <input  id="txtDime.*" type="hidden"/>
                         <input id="txtLengthb.*" type="hidden"/>
                </td>
                <td style="width: 2%;"><input class="txt num c1" id="txtMount.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt num c1" id="txtDivide.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt num c1" id="txtTheory.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtHweight.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtWeight.*" type="text"  /></td>
                <td ><input class="txt c1" id="txtXbutt.*" type="text" /></td>
                <td ><input class="txt c1" id="txtBno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtStoreno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtTime.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtProductno.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtSpec.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtWprice.*" type="text" /></td>
                <td ><input class="txt c1" id="txtSize.*" type="text" /></td>
                <!--<td ><input class="txt num c1" id="txtRadius.*" type="text" /></td>-->
                <td ><input class="txt num c1" id="txtMweight.*" type="text" /></td>
                <td ><input class="txt c1" id="txtOrdeno.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtNo2.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtSpecial.*" type="text" /></td>
                <td style="width: 2%;"><input class="txt c1" id="txtCname.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
