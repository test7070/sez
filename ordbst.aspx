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
            var q_name = "ordb";
            var q_readonly = ['txtTgg', 'txtAcomp','txtSales','txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = ['txtC1','txtNotv'];
            var bbmNum = [['txtFloata', 10, 5, 1],['txtMoney', 10, 0, 1],['txtTax', 10, 0, 1],['txtTotal', 10, 0, 1],['txtTotalus', 10, 0, 1],['txtWeight', 10, 1, 1]];
            var bbsNum = [['textSize1', 10, 3, 1],['textSize2', 10, 2, 1],['textSize3', 10, 3, 1],['textSize4', 10, 2, 1],['txtRadius', 10, 3, 1],['txtWidth', 10, 2, 1],['txtDime', 10, 3, 1],['txtLengthb', 10, 2, 1],['txtMount', 10, 2, 1],['txtWeight', 10, 1, 1],['txtTheory', 10, 1, 1],['txtPrice', 10, 2, 1],['txtTotal', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [['txtStyle','A']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Odate';
            aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],
				             ['txtSales', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
				             ['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx'],
				             ['txtUno_', 'btnUno_', 'uccc', 'noa', 'txtUno_', 'uccc_seek_b.aspx','95%','60%'],
				             ['txtTggno','lblTgg','tgg','noa,comp,paytype','txtTggno,txtTgg,cmbPaytype','tgg_b.aspx']
            );
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'no3'];
                q_brwCount();
                q_gt('style','',0,0,0,'');
               q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            
            //////////////////   end Ready
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
                q_cmbParse("cmbKind", q_getPara('sys.stktype')); 
                q_cmbParse("cmbCoin", q_getPara('sys.coin'));      
                q_cmbParse("cmbPaytype", q_getPara('rc2.paytype'));  
                q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype')); 
                $('#btnOrde').click(function() {
                     q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";", 'ordes', "95%", "95%", q_getMsg('popOrde'));
                });
                $('#cmbPaytype').change(function () {
	            	$('#txtPay').val($('#cmbPaytype').find("option:selected").text())
			     });
                $('#txtFloata').change(function () {
		        	sum();
				});
				$('#txtTotal').change(function () {
		        	sum();
				});
	            //變動尺寸欄位
	            $('#cmbKind').change(function () {
	            	size_change();
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
	                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtPrice,txtOrdeno,txtNo2,txtDime,txtWidth,txtLengthb,txtSpec', b_ret.length, b_ret
	                                                           , 'productno,product,unit,mount,price,noa,no2,dime,width,lengthb,spec'
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

			function ProductAddStyle(id){
				var Styleno = $('#txtStyle_' + id).val();
				var StyleName = '';
				var ProductVal = $('#txtProduct_' + id).attr('OldValue');
				ProductVal = (emp(ProductVal)?(emp($('#txtProductno_' + id).val())?'':$('#txtProduct_' + id).val()):ProductVal);
				if(!emp(Styleno)){
					for(j = 0;j<StyleList.length;j++){
						if(StyleList[j].noa == Styleno){
							StyleName = StyleList[j].product;
							break;
						}
					}
					$('#txtProduct_' + id).val(ProductVal + StyleName);
				}
			}
			var StyleList = '';
            function q_gtPost(t_name) {
                switch (t_name) {
            		case 'style' :
            			var as = _q_appendData("style", "", true);
            			StyleList = new Array();
            			StyleList = as;
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
	            $('#txtDatea').val($.trim($('#txtDatea').val()));
	                if (checkId($('#txtDatea').val())==0){
	                	alert(q_getMsg('lblDatea')+'錯誤。');
	                	return;
	            }
	            $('#txtOdate').val($.trim($('#txtOdate').val()));
	                if (checkId($('#txtOdate').val())==0){
	                	alert(q_getMsg('lblOdate')+'錯誤。');
	                	return;
	            }	
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('G' + $('#txtOdate').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('ordb_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
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

            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
            		  if (!$('#btnMinus_' + j).hasClass('isAssign')) {
            		  	$('#txtMount_' + j).change(function () {sum();});
				        $('#txtWeight_' + j).change(function () {sum();});
				        $('#txtPrice_' + j).change(function () {sum();});
				        $('#txtTotal_' + j).change(function () {sum();});
						$('#txtStyle_' + j).blur(function(){
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
						    q_bodyId($(this).attr('id'));
						    b_seq = t_IdSeq;
							ProductAddStyle(b_seq);
						});
	           		  	//計算理論重
					     $('#textSize1_' + j).change(function () {
				         		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				            	q_bodyId($(this).attr('id'));
				            	b_seq = t_IdSeq;
				            	if ($('#cmbKind').val().substr(0,1)=='A'){	
				            		q_tr('txtDime_'+b_seq ,q_float('textSize1_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize1_' + b_seq).val());
				            	}else if($('#cmbKind').val().substr(0,1)=='B'){
				            		q_tr('txtRadius_'+b_seq ,q_float('textSize1_'+b_seq));//短徑$('#txtRadius_'+b_seq).val($('#textSize1_' + b_seq).val());	
				            	}
								q_tr('txtTheory_'+b_seq ,getTheory(b_seq));
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
								q_tr('txtTheory_'+b_seq ,getTheory(b_seq));
				          });
				          $('#textSize3_' + j).change(function () {
				          		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				          		q_bodyId($(this).attr('id'));
				           		b_seq = t_IdSeq;
				                if ($('#cmbKind').val().substr(0,1)=='A'){
				            		q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize3_' + b_seq).val());	
				            	}else if( $('#cmbKind').val().substr(0,1)=='B'){
				            		q_tr('txtDime_'+b_seq ,q_float('textSize3_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize3_' + b_seq).val());		
				            	}else{//鋼筋、胚
				            		q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));
				            	}
								q_tr('txtTheory_'+b_seq ,getTheory(b_seq));
				            });
				            $('#textSize4_' + j).change(function () {
				            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				                q_bodyId($(this).attr('id'));
				                b_seq = t_IdSeq;
				                if ($('#cmbKind').val().substr(0,1)=='A'){
				            		q_tr('txtRadius_'+b_seq ,q_float('textSize4_'+b_seq));//短徑為0 $('#txtRadius_'+b_seq).val($('#textSize4_' + b_seq).val());	
				            	}else if($('#cmbKind').val().substr(0,1)=='B'){
				            		q_tr('txtLengthb_'+b_seq ,q_float('textSize4_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize4_' + b_seq).val());	
				            	}
								q_tr('txtTheory_'+b_seq ,getTheory(b_seq));
				           	});
				            $('#txtMount_' + j).change(function () {
				            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				                q_bodyId($(this).attr('id'));
				                b_seq = t_IdSeq;
								q_tr('txtTheory_'+b_seq ,getTheory(b_seq));
								q_tr('txtTotal_'+b_seq ,q_float('txtMount_'+b_seq)*q_float('txtPrice_'+b_seq)*q_float('txtWeight_'+b_seq));
								sum();
				            });
				            $('#txtPrice_' + j).change(function () {
				            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				                q_bodyId($(this).attr('id'));
				                b_seq = t_IdSeq;
				                q_tr('txtTotal_'+b_seq ,q_float('txtMount_'+b_seq)*q_float('txtPrice_'+b_seq)*q_float('txtWeight_'+b_seq));
				                sum();
				            });
				            $('#txtWeight_' + j).change(function () {
				            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				                q_bodyId($(this).attr('id'));
				                b_seq = t_IdSeq;
				                q_tr('txtTotal_'+b_seq ,q_float('txtMount_'+b_seq)*q_float('txtPrice_'+b_seq)*q_float('txtWeight_'+b_seq));
				                sum();
				            });
				            $('#txtC1_' + j).change(function(){sum();});
            		  }
            	}
            		 
                _bbsAssign();
                size_change();
            }

            function btnIns() {
                _btnIns();
                $('#cmbKind').val(q_getPara('vcc.kind'));
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtOdate').val(q_date());
                $('#txtOdate').focus();
                size_change();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
                size_change();
            }

            function btnPrint() {
				q_box('z_ordbstp.aspx', '', "800px", "600px", q_getMsg("popPrint"));
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
                as['date'] = abbm2['date'];
                as['kind'] = abbm2['kind'];
                as['tggno'] = abbm2['tggno'];
                as['odate'] = abbm2['kind'];
                as['enda'] = abbm2['enda'];

                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                var t_money=0;
                for(var j = 0; j < q_bbsCount; j++) {
                	t_money+=q_float('txtTotal_'+j);
					t_weight+=q_float('txtWeight_'+j);
					q_tr('txtNotv_'+j ,q_float('txtWeight_'+j)-q_float('txtC1_'+j));
                }  // j
                q_tr('txtMoney' ,t_money);
				q_tr('txtWeight' ,t_weight);
				q_tr('txtTotal' ,q_float('txtMoney')+q_float('txtTax'));
				q_tr('txtTotalus' ,q_float('txtTotal')*q_float('txtFloata'));
            }

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
		                	$(this).attr('OldValue',OldValue);
		                });
		                ProductAddStyle(b_seq);
		                $('#txtStyle_' + b_seq).focus();
		                break;
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            	size_change();
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
                width: 37%;
                float: left;
            }
            .txt.c3 {
                width: 57%;
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
            .txt.c9 {
            	float:left;
                width: 90%;
                text-align:center;
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
                font-size: medium;
            }
            .dbbs {
                width: 120%;
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
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewTgg'></a></td>
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
               <td class="td1"><span> </span><a id='lblKind' class="lbl"></a></td>
               <td class="td2"><select id="cmbKind" class="txt c1"></select></td>
               <td class="td3"><span> </span><a id='lblOdate' class="lbl"></a></td>
               <td class="td4"><input id="txtOdate" type="text" class="txt c1"/></td>
               <td class="td5"><span> </span><a id='lblDatea' class="lbl"></a></td>
               <td class="td6"><input id="txtDatea" type="text" class="txt c1"/></td>
               <td class="td7"><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td8"><input id="txtNoa"   type="text"  class="txt c1"/></td> 
            </tr>
            <tr class="tr2">
               <td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"></a></td>
               <td class="td2" colspan="2"><input id="txtCno"  type="text" class="txt c4"/>
               <input id="txtAcomp" type="text" class="txt c5"/></td>
               <td class="td4"><span> </span><a id='lblFloata' class="lbl"></a></td>
                <td class="td5"><select id="cmbCoin" class="txt c1"></select></td>                 
                <td class="td6"><input id="txtFloata"  type="text"  class="txt num c1" /></td>                 
                <td class="td7"><span> </span><a id='lblContract_st' class="lbl"></a></td>
                <td class="td8"><input id="txtContract"  type="text" class="txt c1"/></td> 
            </tr>
           <tr class="tr3">
                <td class="td1"><span> </span><a id="lblTgg" class="lbl btn"></a></td>
                <td class="td2" colspan="2"><input id="txtTggno" type="text" class="txt c4"/>
                <input id="txtTgg"  type="text" class="txt c5"/></td>
                <td class="td4"><span> </span><a id='lblPaytype' class="lbl"></a></td>
                <td class="td5"  colspan='2'><select id="cmbPaytype" class="txt c1" ></select><input id="txtPay" type="hidden" class="txt c1"/></td> 
                <td class="td7"><span> </span><a id='lblTrantype' class="lbl"></a></td>
                <td class="td8"><select id="cmbTrantype" class="txt c1" name="D1" ></select></td> 
            </tr>
            <tr class="tr4">
                <td class="td1"><span> </span><a id="lblSales" class="lbl btn"></a></td>
                <td class="td2" colspan="2"><input id="txtSalesno" type="text" class="txt c4"/> 
                <input id="txtSales" type="text" class="txt c5"/></td> 
                <td class="td4"><span> </span><a id='lblTel' class="lbl"></a></td>
                <td class="td5" colspan='2'><input id="txtTel"  type="text"  class="txt c1"/></td>
                <td class="td7"><span> </span><a id='lblFax' class="lbl"></a></td>
                <td class="td8"><input id="txtFax" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr5">
                <td class="td1"><span> </span><a id='lblAddr' class="lbl"></a></td>
                <td class="td2"><input id="txtPost"  type="text"  class="txt c1"/></td>
                <td class="td3" colspan='4' ><input id="txtAddr"  type="text" class="txt c1"/></td>
                <td class="td7"><span> </span><a id="lblApv" class="lbl"></a></td>
                <td class="td8"><input id="txtApv" type="text" class="txt c1" disabled="disable"/></td> 
            </tr>
            <tr class="tr6">
                <td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
                <td class="td2" colspan='2'><input id="txtMoney" type="text" class="txt num c1" /></td> 
                <td class="td4"><span> </span><a id='lblTax' class="lbl"></a></td>
                <td class="td5"><input id="txtTax"  type="text" class="txt num c1" /></td>
                <td class="td6"><select id="cmbTaxtype" class="txt c1" onchange="calTax()"></select></td>
                <td class="td7"><span> </span><a id='lblTotal' class="lbl"></a></td>
                <td class="td8"><input id="txtTotal" type="text" class="txt num c1" />
                </td> 
            </tr>
            <tr class="tr7">
                <td class="td1"><span> </span><a id='lblTotalus' class="lbl"></a></td>
                <td class="td2" colspan='2'><input id="txtTotalus"  type="text" class="txt num c1" /></td> 
                <td class="td4"><span> </span><a id='lblWeight' class="lbl"></a></td>
                <td class="td5" colspan='2'><input id="txtWeight"  type="text" class="txt num c1" /></td>
                <td class="td7"><span> </span><a id='lblWorker' class="lbl"></a></td>
                <td class="td8"><input id="txtWorker"  type="text" class="txt c1" /></td> 
            </tr>
            <tr class="tr8">
                <td class="td1"><span> </span><a id='lblAeno' class="lbl"></a></td>
                <td class="td2"><input id="chkAeno" type="checkbox"/></td>
                <td class="td3"><span> </span><a id='lblEnd' class="lbl"></a></td>
                <td class="td4"><input id="chkEnda" type="checkbox"/></td>
                <td class="td5"></td>  
                <td class="td6"><input id="btnOrde" type="button" /></td>
                <td class="td7"><span> </span><a id='lblWorker2' class="lbl"></a></td>
                <td class="td8"><input id="txtWorker2"  type="text" class="txt c1" /></td> 
            </tr>
            <tr class="tr9">
                <td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
                <td class="td2" colspan='7'><textarea id="txtMemo" rows="5" cols="10" style="width: 99%; height: 50px;"></textarea></td> 
            </tr>
        </table>
        </div>
		</div>
        <div class='dbbs' >
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:8%"><a id='lblUno_st'></a></td>
                <td align="center" style="width:8%"><a id='lblProductno_st'></a></td>
                <td align="center" style="width:30px"><a id='lblStyle_st'></a></td>
                <td align="center" style="width:10%"><a id='lblProduct_st'></a></td>
                <!--<td align="center" style="width:8%"><a id='lblSpec_st'></a></td>-->
                <td align="center" id='Size'><a id='lblSize_help'> </a><BR><a id='lblSize_st'></a></td>
                <td align="center" style="width:12%"><a id='lblSizea_st'></a></td>
                <td align="center" style="width:86"><a id='lblMount_st'></a></td>
                <td align="center" style="width:6%"><a id='lblWeights_st'></a></td>
                <td align="center" style="width:6%"><a id='lblPrices_st'></a></td>
                <td align="center" style="width:8%"><a id='lblTotals_st'></a></td>
				<td align="center" style="width:6%;"><a id='lblGemounts'></a></td>
                <td align="center"><a id='lblMemos_st'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
              	<td><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td><input class="txt c1" id="txtUno.*" type="text" style="width:80%;" />
                	<input class="btn" id="btnUno.*" type="button" value='.' style="width:1%;"/>
                	<input type="text" id="txtNo3.*"  class="txt c1"/>
                </td>
                <td>
					<input class="btn"  id="btnProduct.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                    <input type="text" id="txtProductno.*"  style="width:80%;"/>
                    <input id="txtClass.*" style="width: 80%;" type="text" />
				</td>
                <td><input class="txt c9" id="txtStyle.*" type="text" /></td>
                <td><input class="txt c1" id="txtProduct.*" type="text" /></td>
              			
                <!--<td><input class="txt c1" id="txtSpec.*" type="text"  /></td>-->
                <td>
                	<input class="txt num c8" id="textSize1.*" type="text" disabled="disabled"/><div id="x1.*" style="float: left"> x</div>
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
                <td><input class="txt c1" id="txtSize.*" type="text" /></td>
                <td><input class="txt num c1" id="txtMount.*" type="text" /></td>
                <td><input class="txt num c1" id="txtWeight.*" type="text"/></td>
                <td><input class="txt num c1" id="txtPrice.*" type="text" /></td>
                <td><input class="txt num c1" id="txtTotal.*" type="text" />
                       <input class="txt num c1" id="txtTheory.*" type="text" /></td>
                <td>
                	<input class="txt num c1" id="txtC1.*" type="text" />
                	<input class="txt num c1" id="txtNotv.*" type="text" />
                </td>
                <td><input class="txt c1" id="txtMemo.*" type="text" />
                <input class="txt c3" id="txtOrdeno.*" type="text" />
                <input class="txt c2" id="txtNo2.*" type="text" />
                <input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
