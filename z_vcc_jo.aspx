<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="/../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var gfrun = false;
            var uccgaItem = '',uccgbItem = '',uccgcItem = '';
            var partItem = '';
            var sss_state = false;
            var issale = '0';
            var job = '';
            var sgroup = '';
            var isinvosystem = '';
            aPop = new Array(
				['txtCust1a', 'btnCust1', 'cust', 'noa,comp', 'txtCust1a,txtCust1b', 'cust_b.aspx'],
				['txtCust2a', 'btnCust2', 'cust', 'noa,comp', 'txtCust2a,txtCust2b', 'cust_b.aspx'],
				['txtSales1a', 'btnSales1', 'sss', 'noa,comp', 'txtSales1a,txtSales1b', 'sss_b.aspx'],
				['txtSales2a', 'btnSales2', 'sss', 'noa,namea', 'txtSales2a,txtSales2b', 'sss_b.aspx'],
				['txtProduct1a', 'btnProduct1', 'ucaucc', 'noa,product', 'txtProduct1a,txtProduct1b', 'ucaucc_b.aspx'],
				['txtProduct2a', 'btnProduct2', 'ucaucc', 'noa,product', 'txtProduct2a,txtProduct2b', 'ucaucc_b.aspx'],
				['txtTggno1a', 'btnTggno1', 'tgg', 'noa,comp', 'txtTggno1a,txtTggno1b', 'tgg_b.aspx'],
				['txtTggno2a', 'btnTggno2', 'tgg', 'noa,comp', 'txtTggno2a,txtTggno2b', 'tgg_b.aspx']
			);


            if (location.href.indexOf('?') < 0) {
                location.href = location.href + "?;;;;100";
            }
            
            $(document).ready(function() {
                q_getId();
                if (isinvosystem.length == 0) {
                    q_gt('ucca', 'stop=1 ', 0, 0, 0, "ucca_invo");
                }
                if (uccgaItem.length == 0) {
                    q_gt('uccga', '', 0, 0, 0, "");
                }
                if (uccgbItem.length == 0) {
                    q_gt('uccgb', '', 0, 0, 0, "");
                }
                if (uccgcItem.length == 0) {
                    q_gt('uccgc', '', 0, 0, 0, "");
                }
                if (partItem.length == 0) {
                    q_gt('part', '', 0, 0, 0, "");
                }
                if (!sss_state) {
                    q_gt('sss', "where=^^noa='" + r_userno + "'^^", 0, 0, 0, "");
                }
                
                $('#q_report').click(function(e) {
					
					if(isinvosystem=='2'){//沒有發票系統
	                	$('#Xshowinvono').hide();
	                }
	                var report_name=$('#q_report [type=radio]:checked').val();
	                if(report_name!='undefined'){
	                	$('.option div').show()
	                	if(report_name=='1'){
	                		$('#Mon').hide();
	                		$('#Xgroupbno').hide();
	                		$('#Xgroupcno').hide();
	                	}
						if(report_name=='2' || report_name=='4' || report_name=='6' || report_name=='8'){
	                		$('#Mon').hide();
	                		$('#Sales').hide();
	                		$('#Xgroupbno').hide();
	                		$('#Xgroupcno').hide();
	                		$('#Salesgroup').hide();
	                		$('#Xpartno').hide();
	                		$('#Xshowinvono').hide();
	                	}
	                	if(report_name=='3' || report_name=='5' || report_name=='7' || report_name=='9' || report_name=='11' || report_name=='13' || report_name=='15'){
	                		$('#Mon').hide();
	                		$('#Xgroupbno').hide();
	                		$('#Xgroupcno').hide();
	                		$('#Xshowinvono').hide();
	                	}
	                	if(report_name=='10' || report_name=='12' || report_name=='14' || report_name=='16'){
	                		$('#Mon').hide();
	                		$('#Xgroupbno').hide();
	                		$('#Xgroupcno').hide();
	                		$('#Xpartno').hide();
	                		$('#Xshowinvono').hide();
	                	}
	                	if(report_name=='20'){
	                		$('#Mon').hide();
	                		$('#Xgroupbno').hide();
	                		$('#Xgroupcno').hide();
	                		$('#Xshowinvono').hide();
	                		$('#Tggno').hide();
	                		$('#Xstype').hide();
	                		$('#Vcctypea').hide();
	                		$('#Xpartno').hide();
	                		$('#product').hide();
	                		$('#Xtype').hide();
	                		$('#Xgroupano').hide();
	                		$('#Salesgroup').hide();
	                		$('#Multcust').hide();
	                		$('#Multucc').hide();
	                	}	
	                	if(report_name=='21'){
	                		$('#Mon').hide();
	                		$('#Xgroupbno').hide();
	                		$('#Xgroupcno').hide();
	                		$('#Xshowinvono').hide();
	                		$('#Tggno').hide();
	                		$('#Xstype').hide();
	                		$('#Vcctypea').hide();
	                		$('#Xpartno').hide();
	                	}
	                	if(report_name=='22'){
	                		$('#Mon').hide();
	                		$('#Sales').hide();
	                		$('#Product').hide();
	                		$('#Xgroupbno').hide();
	                		$('#Xgroupcno').hide();
	                		$('#Xshowinvono').hide();
	                		$('#Tggno').hide();
	                		$('#Xstype').hide();
	                		$('#Vcctypea').hide();
	                		$('#Xpartno').hide();
	                		$('#product').hide();
	                		$('#Xtype').hide();
	                		$('#Xgroupano').hide();
	                		$('#Salesgroup').hide();
	                		$('#Multcust').hide();
	                		$('#Multucc').hide();
	                	}		
	                }
				});
			
            });      
            
            
            function q_gfPost() {     
				q_cmbParse("cmbStype",' @全部'+ ','+ q_getPara('vcc.stype'));
            	q_cmbParse("cmbType",' @全部'+ ',' + q_getPara('ucc.typea') + ',' + q_getPara('uca.typea'));
            	q_cmbParse("cmbVcctype",' @全部'+ ',' + q_getPara('vcc.typea'));
                      
                q_popAssign();
                q_getFormat();
                q_langShow();
                
                 if(r_len==4){                	
                	$.datepicker.r_len=4;
					//$.datepicker.setDefaults($.datepicker.regional["ENG"]);
                }

                $('#txtDate1').mask(r_picd);
                $('#txtDate1').datepicker();
                $('#txtDate2').mask(r_picd);
                $('#txtDate2').datepicker();

				$('#txtDate1').val(q_date().substr(0,r_lenm)+'/01');
				$('#txtDate2').val(q_cdn(q_cdn(q_date().substr(0,r_lenm)+'/01',45).substr(0,r_lenm)+'/01',-1));
				
                $('#txtMon1').val(r_accy + '/01').mask(r_picm);
                $('#txtMon2').val(r_accy + '/12').mask(r_picm);
                $('#txtXbmon1').val(r_accy + '/01').mask(r_picm);
                $('#txtXbmon2').val(r_accy + '/12').mask(r_picm);
                $('#txtXemon1').val(r_accy + '/01').mask(r_picm);
                $('#txtXemon2').val(r_accy + '/12').mask(r_picm);
                $('#Xmemo').removeClass('a2').addClass('a1');
                $('#txtXmemo').css('width', '85%');
                $('#Xgroupano select').css('width', '150px');
                $('.q_report .report').css('width', '420px');
                $('.q_report .report div').css('width', '200px');
               
                $('#Xshowinvono').css('width', '300px').css('height', '30px');
                $('#Xshowinvono .label').css('width','0px');
                $('#chkXshowinvono').css('width', '220px').css('margin-top', '5px');
                $('#chkXshowinvono span').css('width','180px')
                
                if(isinvosystem=='2'){//沒有發票系統
	                $('#Xshowinvono').hide();
				}
				
				$("input[type='radio'][value=1]").attr('checked', true);
				$('#Mon').hide();
	            $('#Xgroupbno').hide();
	            $('#Xgroupcno').hide();
				
				$('#q_report .rptext').unbind('click');$('#q_report .rptext').click(function(){ 
						$('#q_report [type=radio]').prop('checked',false)
						$(this).children('.radio').prop('checked',true)
				});


				$('#radio input').click(function(){ 
						var tcheck=$(this).val(); 
						$('#radio input').each(function() {
							if(tcheck!=$(this).val()){ 
								$(this).prop('checked',false);
							}
						});  
				});
				
				$('#txtMultcust').css("width","205px");
				$('#Multcust').css("color","#0000ff");
				$('#Multcust').click(function(e) {
                	q_box("cust_b2.aspx?;;;;", 'cust', "600px", "90%", q_getMsg("popCust"));
                });
                $('#Multucc').css("width","605px");
				$('#txtMultucc').css("width","515px");
				$('#Multucc').css("color","#0000ff");
				$('#Multucc').click(function(e) {
                	q_box("ucaucc_b2.aspx?;;;;", 'ucc', "600px", "990%", q_getMsg("popUcc"));
                });
                
                $('#btnOk').unbind('click');
				$('#btnOk').click(function(){
					var bdate=!emp($('#txtDate1').val())?$('#txtDate1').val():'#non';
					var edate=!emp($('#txtDate2').val())?$('#txtDate2').val():'#non';
					var bmon=!emp($('#txtMon1').val())?$('#txtMon1').val():'#non';
					var emon=!emp($('#txtMon2').val())?$('#txtMon2').val():'#non';
					var bcustno=!emp($('#txtCust1a').val())?$('#txtCust1a').val():'#non';
					var ecustno=!emp($('#txtCust2a').val())?$('#txtCust2a').val():'#non';
					var bsales=!emp($('#txtSales1a').val())?$('#txtSales1a').val():'#non';
					var esales=!emp($('#txtSales2a').val())?$('#txtSales2a').val():'#non';
					var bproduct=!emp($('#txtProduct1a').val())?$('#txtProduct1a').val():'#non';
					var eproduct=!emp($('#txtProduct2a').val())?$('#txtproduct2a').val():'#non';
					var btggno=!emp($('#txtTggno1a').val())?$('#txtTggno1a').val():'#non';
					var etggno=!emp($('#txtTggno2a').val())?$('#txtTggno2a').val():'#non';
					var type=!emp($('#cmbType').val())?$('#cmbType').val():'#non';
					var groupano=!emp($('#cmbGroupa').val())?$('#cmbGroupa').val():'#non';
					var groupbno=!emp($('#cmbGroupb').val())?$('#cmbGroupb').val():'#non';
					var groupcno=!emp($('#cmbGroupc').val())?$('#cmbGroupc').val():'#non';
					var stype=!emp($('#cmbStype').val())?$('#cmbStype').val():'#non';
					var salesgroup=!emp($('#txtSalesgroup').val())?$('#txtSalesgroup').val():'#non';
					var vcctypea=!emp($('#cmbVcctype').val())?$('#cmbVcctype').val():'#non';
					var partno=!emp($('#cmbPart').val())?$('#cmbPart').val():'#non';
					var showinvono=!emp($('#chkXshowinvono').val())?$('#chkXshowinvono').val():'#non';
					var multcust=!emp($('#txtMultcust').val())?$('#txtMultcust').val():'#non';
					var multucc=!emp($('#txtMultucc').val())?$('#txtMultucc').val():'#non';
					
					var t_where= r_accy + ';' + q_getPara('sys.d4taxtype')+ ';' + q_getPara('sys.comp') + ';' + bdate + ';' + edate + ';'
						+ bmon + ';' + emon + ';'  + bcustno + ';' + ecustno + ';' + bsales + ';' + esales + ';' + bproduct + ';' 
						+ eproduct + ';'+ btggno + ';' + etggno + ';' + type + ';' + groupano + ';' + groupbno + ';' + groupcno + ';' 
						+ stype + ';' + salesgroup + ';' + vcctypea + ';' + partno + ';' + showinvono + ';' + q_getPara('sys.isspec') + ';' 
						+ multcust + ';' + multucc + ';' +r_len;
						
					var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + r_accy + ",r_cno=" + r_cno;
					
					var report_namea=$('#q_report [type=radio]:checked').val();
					
	                if(report_namea!='undefined'){
						if(report_namea=='1'){
							q_gtx("z_vcc1", t_where + ";;" + t_para + ";;z_vcc;;出貨月報表");
						}
						if(report_namea=='2'){
							q_gtx("z_vcc19", t_where + ";;" + t_para + ";;z_vcc;;出貨統計-客戶+產品");
						}
						if(report_namea=='3'){
							q_gtx("z_vcc3", t_where + ";;" + t_para + ";;z_vcc;;出貨明細-客戶+產品");
						}
						if(report_namea=='4'){
							q_gtx("z_vcc4", t_where + ";;" + t_para + ";;z_vcc;;出貨統計-產品+客戶");
						}
						if(report_namea=='5'){
							q_gtx("z_vcc5", t_where + ";;" + t_para + ";;z_vcc;;出貨明細-客戶+日期");
						}
						if(report_namea=='6'){
							q_gtx("z_vcc6", t_where + ";;" + t_para + ";;z_vcc;;出貨統計-客戶");
						}
						if(report_namea=='7'){
							q_gtx("z_vcc7", t_where + ";;" + t_para + ";;z_vcc;;出貨明細-產品+日期");
						}
						if(report_namea=='8'){
							q_gtx("z_vcc8", t_where + ";;" + t_para + ";;z_vcc;;出貨統計-產品");
						}
						if(report_namea=='9'){
							q_gtx("z_vcc9", t_where + ";;" + t_para + ";;z_vcc;;出貨明細-業務+日期");
						}
						if(report_namea=='10'){
							q_gtx("z_vcc10", t_where + ";;" + t_para + ";;z_vcc;;出貨統計-業務");
						}
						if(report_namea=='11'){
							q_gtx("z_vcc11", t_where + ";;" + t_para + ";;z_vcc;;出貨明細-業務 產品 日期");
						}
						if(report_namea=='12'){
							q_gtx("z_vcc12", t_where + ";;" + t_para + ";;z_vcc;;出貨統計-業務+產品");
						}
						if(report_namea=='13'){
							q_gtx("z_vcc13", t_where + ";;" + t_para + ";;z_vcc;;出貨明細-業務 客戶 產品");
						}
						if(report_namea=='14'){
							q_gtx("z_vcc14", t_where + ";;" + t_para + ";;z_vcc;;出貨統計-業務 客戶 產品");
						}
						if(report_namea=='15'){
							q_gtx("z_vcc15", t_where + ";;" + t_para + ";;z_vcc;;出貨明細-產品 業務 客戶");
						}
						if(report_namea=='16'){
							q_gtx("z_vcc16", t_where + ";;" + t_para + ";;z_vcc;;出貨統計-產品 業務 客戶");
						}
						if(report_namea=='20'){
							q_gtx("z_vcc20", t_where + ";;" + t_para + ";;z_vcc;;出貨利潤分析表");
						}
						if(report_namea=='21'){
							q_gtx("z_vcc21", t_where + ";;" + t_para + ";;z_vcc;;出貨產品統計表");
						}
						if(report_namea=='22'){
							q_gtx("z_vcc22", t_where + ";;" + t_para + ";;z_vcc;;應收帳款對帳單");
						}
					}
				});
            
            }

            function q_boxClose(s2) {
            	var ret;
                switch (b_pop) {
                	case 'cust':
                        ret = getb_ret();
                        if(ret==null){
                        	b_pop = '';
                        	return;
                        }
                        var xcust='';
                        if(ret[0]!=undefined){
                        	for (var i = 0; i < ret.length; i++) {
                        		xcust+=ret[i].noa+','
                        	}
                        }
                        xcust=xcust.substr(0,xcust.length-1);
                        $('#txtMultcust').val(xcust);
                        break;	
                    case 'ucc':
                        ret = getb_ret();
                        if(ret==null){
                        	b_pop = '';	
                        	return;
                        }
                        var xucc='';
                        if(ret[0]!=undefined){
                        	for (var i = 0; i < ret.length; i++) {
                        		xucc+=ret[i].noa+','
                        	}
                        }
                        xucc=xucc.substr(0,xucc.length-1);
                        $('#txtMultucc').val(xucc);
                        break;	    
                }   /// end Switch
				b_pop = '';		
            }
            
			//交換div位置
			var exchange = function(a,b){
				try{
					var tmpTop = a.offset().top;
					var tmpLeft = a.offset().left;
					a.offset({top:b.offset().top,left:b.offset().left});
					b.offset({top:tmpTop,left:tmpLeft});
				}catch(e){
				}
			};
			
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'sss':
                        var as = _q_appendData("sss", "", true);
                        if (as[0] != undefined) {
                            issale = as[0].issales;
                            job = as[0].job;
                            sgroup = as[0].salesgroup;
                        }
                        sss_state = true;
                        break;
					case 'ucca_invo':
						var as = _q_appendData("ucca", "", true);
						if (as[0] != undefined) {
							isinvosystem = '1';
						} else {
							isinvosystem = '2';
						}
						break;
                    case 'uccga':
                        var as = _q_appendData("uccga", "", true);
                        uccgaItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            uccgaItem = uccgaItem + (uccgaItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
                        }
                        q_cmbParse("cmbGroupa", uccgaItem);
                        break;
					case 'uccgb':
                        var as = _q_appendData("uccgb", "", true);
                        uccgbItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            uccgbItem = uccgbItem + (uccgbItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
                        }
                        q_cmbParse("cmbGroupb", uccgbItem);
                        break;
					case 'uccgc':
                        var as = _q_appendData("uccgc", "", true);
                        uccgcItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            uccgcItem = uccgcItem + (uccgcItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
                        }
                        q_cmbParse("cmbGroupc", uccgcItem);
                        break;
                     case 'part':
                        var as = _q_appendData("part", "", true);
                        partItem = " @全部";
                        for ( i = 0; i < as.length; i++) {
                            partItem = partItem + (partItem.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].part;
                        }
                        q_cmbParse("cmbPart", partItem);
                        break;   
                }
                if (isinvosystem.length > 0 && uccgaItem.length > 0 &&uccgbItem.length > 0 &&uccgcItem.length > 0 && partItem.length > 0 && sss_state && !gfrun) {
                    gfrun = true;
                    q_gf('', 'z_vcc_jo'); //抓取網頁權限
                }
            }
		</script>
	<style type="text/css">
		.q_report {
		    cursor: default;
		}
		.q_report .report {
		    position: relative;
		    width: 380px;
		    margin-right: 2px;
		    border: 1px solid #76a2fe;
		    background: #EEEEEE;
		    float: left;
		    border-radius: 5px;
		}
		.q_report .report div {
		    display: block;
		    float: left;
		    width: 180px;
		    height: 30px;
		    font-size: 14px;
		    font-weight: normal;
		    font-family: "Times New Roman", "·s²Ó©úÅé", monospace;
		    cursor: pointer;
		}
		.q_report .report div .rptext{
		    width: 200px;
		}
		.q_report .report div .radio {
		    display: block;
		    float: left;
		    width: 20px;
		    height: 12px;
		    margin-left: 5px;
		    margin-top: 8px;
		}
		.q_report .report div .text {
		    display: block;
		    float: left;
		    height: 30px;
		    margin-top: 6px;
		}
		.q_report .report  div .text:hover {
		    color: #CD0A0A;
		}
		.q_report .report  div .text {
		    color: #000000;
		}
		.q_report .option {
		    position: relative;
		    width: 620px;
		    float: left;
		    background: #76a2fe;
		    border-radius: 5px;
		}
		.q_report .option div.option {
		    height: 30px;
		    border: 1px solid white;
		    background: #76a2fe;
		    margin: 2px;
		    margin-left: 4px;
		    float: left;
		    border-radius: 5px;
		}
		.q_report .option div.a1 {
		    width: 610px;
		}
		.q_report .option div.a2 {
		    width: 300px;
		}
		.q_report .option div.a3 {
		    width: 195px;
		}
		.q_report .option div .c1 {
		    width: 15px;
		}
		.q_report .option div .c2 {
		    width: 110px;
		}
		.q_report .option div .c3 {
		    width: 110px;
		}
		.q_report .option div .c4 {
		    width: 110px;
		}
		.q_report .option div .c5 {
		    width: 170px;
		}
		.q_report .option div .c6 {
		    width: 80px;
		}
		.q_report .option div .label {
		    font-size: 16px;
		    font-weight: normal;
		    font-family: "Times New Roman", "·s²Ó©úÅé", monospace;
		    float: left;
		    text-align: center;
		    height: 25px;
		    margin-top: 5px;
		    color: #FFFFFF;
		}
		.q_report .option div .dash {
		    display: block;
		    float: left;
		    text-align: center;
		    height: 25px;
		    color: #FFFFFF;
		    margin-top: 2px;
		}
		.q_report .option div .text {
		    float: left;
		    height: 20px;
		    margin-top: 2px;
		    font-size: 16px;
		}
		.q_report .option div .cmb {
		    float: left;
		    height: 20px;
		    margin-top: 5px;
		}
		.q_report .option div .rad {
		    float: left;
		    height: 20px;
		    margin-top: 5px;
		}
		.q_report .option div .btnLookup {
		    margin-top: 3px;
		    width: 24px;
		    height: 24px;
		    display: block;
		    cursor: pointer;
		    float: left;
		}
		.q_report .option div .btnLookup {
		    background: url(http://59.125.143.171/image/search_1.png) no-repeat;
		}
		.q_report .option div .btnLookup:hover {
		    background: url(http://59.125.143.171/image/search_2.png) no-repeat;
		}
	</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report" class="q_report">
					<div id='radio' class="report " style="width: 420px;">
						<div class="rptext">
							<input  type="radio" value="1" class="radio"> 
							<span class="text">出貨月報表</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="2" class="radio">
							<span class="text">出貨統計-客戶+產品</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="3" class="radio">
							<span class="text">出貨明細-客戶+產品</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="4" class="radio">
							<span class="text">出貨統計-產品+客戶</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="5" class="radio">
							<span class="text">出貨明細-客戶+日期</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="6" class="radio">
							<span class="text">出貨統計-客戶</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="7" class="radio">
							<span class="text">出貨明細-產品+日期</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="8" class="radio">
							<span class="text">出貨統計-產品</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="9" class="radio">
							<span class="text">出貨明細-業務+日期</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="10" class="radio">
							<span class="text">出貨統計-業務</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="11" class="radio">
							<span class="text">出貨明細-業務 產品 日期</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="12" class="radio">
							<span class="text">出貨統計-業務+產品</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="13" class="radio">
							<span class="text">出貨明細-業務 客戶 產品</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="14" class="radio">
							<span class="text">出貨統計-業務 客戶 產品</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="15" class="radio">
							<span class="text nonfocus nonselect">出貨明細-產品 業務 客戶</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="16" class="radio">
							<span class="text">出貨統計-產品 業務 客戶</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="20" class="radio">
							<span class="text">出貨利潤分析表</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="21" class="radio">
							<span class="text">出貨產品統計表</span>
						</div>
						<div class="rptext">
							<input  type="radio" value="22" class="radio">
							<span class="text">應收帳款對帳單</span>
						</div>
					</div>	
					<div class="option">
						<div id="Date" class="option a1 " style="display: block;">
							<div class="label c6">
								<span id="Date">日 期</span>
							</div>
							<input id="txtDate1" class="c3 text hasDatepicker" type="text">
							<span class="c1 dash">~</span>
							<input id="txtDate2" class="c3 text hasDatepicker" type="text">
						</div>
						<div id="Mon" class="option a1 " style="display: block;">
							<div class="label c6">
								<span id="Mon">帳款月份</span>
							</div>
							<input id="txtMon1" class="c3 text" type="text">
							<span class="c1 dash">~</span>
							<input id="txtMon2" class="c3 text" type="text">
						</div>
						<div id="Cust" class="option a1 " style="display: block;">
							<div class="label c6">
								<span id="Cust">客戶編號</span>
							</div>
							<input id="txtCust1a" class="c2 text" type="text">
							<input id="txtCust1b" class="c3 text" type="text" disabled="disabled">
							<span id="btnCust1" class="btnLookup"></span>
							<span class="c1 dash">~</span><input id="txtCust2a" class="c2 text" type="text">
							<input id="txtCust2b" class="c3 text" type="text" disabled="disabled">
							<span id="btnCust2" class="btnLookup"></span>
						</div>
						<div id="Sales" class="option a1 " style="display: block;">
							<div class="label c6">
								<span id="Sales">業務</span>
							</div>
							<input id="txtSales1a" class="c2 text" type="text">
							<input id="txtSales1b" class="c3 text" type="text" disabled="disabled">
							<span id="btnSales1" class="btnLookup" style="cursor: pointer;">
							</span><span class="c1 dash">~</span><input id="txtSales2a" class="c2 text" type="text">
							<input id="txtSales2b" class="c3 text" type="text" disabled="disabled">
							<span id="btnSales2" class="btnLookup"></span>
						</div>
						<div id="Product" class="option a1 " style="display: none;">
							<div class="label c6">
								<span id="Product">產品編號</span>
							</div>
							<input id="txtProduct1a" class="c2 text" type="text">
							<input id="txtProduct1b" class="c3 text" type="text" disabled="disabled">
							<span id="btnProduct1" class="btnLookup"></span>
							<span class="c1 dash">~</span>
							<input id="txtProduct2a" class="c2 text" type="text">
							<input id="txtProduct2b" class="c3 text" type="text" disabled="disabled">
							<span id="btnProduct2" class="btnLookup"></span>
						</div>
						<div id="Tggno" class="option a1 " style="display: block;">
							<div class="label c6">
								<span id="Tggno">供應商</span>
							</div>
							<input id="txtTggno1a" class="c2 text" type="text">
							<input id="txtTggno1b" class="c3 text" type="text" disabled="disabled">
							<span id="btnTggno1" class="btnLookup" style="cursor: pointer;">
							</span><span class="c1 dash">~</span><input id="txtTggno2a" class="c2 text" type="text">
							<input id="txtTggno2b" class="c3 text" type="text" disabled="disabled">
							<span id="btnTggno2" class="btnLookup" style="cursor: pointer;"></span>
						</div>
						<div id="Xtype" class="option a2 " style="display: block;">
							<div class="label c6">
								<span id="Xtype">產品類別</span>
							</div>
							<select id="cmbType" class="c4 cmb"></select>
						</div>
						<div id="Xgroupano" class="option a2 " style="display: block;">
							<div class="label c6">
								<span id="Xgroupano">產品群組</span>
							</div>
							<select id="cmbGroupa" class="c4 cmb" style="width: 150px;"></select>
						</div>
						<div id="Xgroupbno" class="option a2 " style="display: block;">
							<div class="label c6">
								<span id="Xgroupbno">中類群組</span>
							</div>
							<select id="cmbGroupb" class="c4 cmb"></select>
						</div>
						<div id="Xgroupcno" class="option a2 " style="display: block;">
							<div class="label c6">
								<span id="Xgroupcno">小類群組</span>
							</div>
							<select id="cmbGroupc" class="c4 cmb"></select>
						</div>
						<div id="Xstype" class="option a2 " style="display: block;">
							<div class="label c6">
								<span id="Xstype">出貨類別</span>
							</div>
							<select id="cmbStype" class="c4 cmb"></select>
						</div>
						<div id="Salesgroup" class="option a2 " style="display: block;">
							<div class="label c6">
								<span id="Salesgroup">業務群組</span>
							</div>
							<input id="txtSalesgroup" class="c5 text" type="text">
						</div>
						<div id="Vcctypea" class="option a2 " style="display: block;">
							<div class="label c6">
								<span id="Vcctypea">貨單類別</span>
							</div>
							<select id="cmbVcctype" class="c4 cmb"></select>
						</div>
						<div id="Xpartno" class="option a2 " style="display: block;">
							<div class="label c6">
								<span id="Xpartno">部門</span>
							</div>
							<select id="cmbPart" class="c4 cmb"></select>
						</div>
						<div id="Xshowinvono" class="option a1" style="height: 30px; display: block; width: 300px;">
							<div class="label c6" style="display: block; float: left; width: 0px;">
								<span id="Xshowinvono"></span>
							</div>
							<div id="chkXshowinvono" style="width: 220px; display: block; float: left; height: 25px; margin-top: 5px;">
								<input id="chkXshowinvono"  type="checkbox" value="1" style="width:25px;height:15px;float:left;">
								<span style="width: 180px; height: 25px; display: block; float: left;">顯示發票資料</span>
							</div>
						</div>
						<div id="Multcust" class="option a2 " style="display: block;">
							<div class="label c6">
								<span id="Multcust" style="color: rgb(0, 0, 255);">客戶複選</span>
							</div>
							<input id="txtMultcust" class="c5 text" type="text" style="width: 205px;">
						</div>
						<div id="Multucc" class="option a2 " style="display: block; width: 605px;">
							<div class="label c6">
								<span id="Multucc" style="color: rgb(0, 0, 255);">產品複選</span>
							</div>
							<input id="txtMultucc" class="c5 text" type="text" style="width: 515px;">
						</div>
				</div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>