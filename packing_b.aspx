<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
		    var q_name = 'packing', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
		    var t_sqlname = 'packing_load'; t_postname = q_name;
		    var isBott = false;
		    var afield, t_htm;
		    var i, s1;
		    var q_readonly = [];
		    var q_readonlys = [];
		    var bbmNum = [];
		    var bbsNum = [['txtDime', 15, 2, 1],['txtWidth', 15, 2, 1],['txtHeight', 15, 2, 1],
					      ['txtMount', 15, 2, 1],['txtPrice', 15, 2, 1],['txtWeight', 15, 2, 1],['txtGweight', 15, 2, 1]
					      ,['txtBctn', 15, 0, 1],['txtEctn', 15, 0, 1],['txtQtyctn', 15, 0, 1]];
		    var bbmMask = [];
		    var bbsMask = [];
            aPop = new Array(
            	['txtProductno_', '', 'view_ucaucc', 'noa,engpro,spec', 'txtProductno_,txtProduct_,txtSpec_', 'ucaucc_b.aspx']
            );
		    $(document).ready(function () {
		        bbmKey = [];
		        bbsKey = ['noa', 'noq'];
		        if (location.href.indexOf('?') < 0)   // debug
		        {
		            location.href = location.href + "?;;;noa='0015'";
		            return;
		        }
		        if (!q_paraChk())
		            return;
		
		        main();
		    });            /// end ready
		
		    function main() {
		        if (dataErr) {
		            dataErr = false;
		            return;
		        }
		        mainBrow(6, t_content, t_sqlname, t_postname,r_accy);
		
		    }
		    
		    function mainPost() {
				q_getFormat();
				bbsMask = [];
		        q_mask(bbsMask);
		        
		        /*var t_key = q_getHref();
		        t_where="where=^^ noa=(select top 1 noa from view_vcc where invo='"+t_key[1]+"' order by datea desc)^^";
                q_gt('view_vccs', t_where, 0, 0, 0, "", r_accy);*/
               
               $('#btnVcces').click(function() {
               		if(q_cur!=2)
               			return;
               		for(var j = 0; j < q_bbsCount; j++) {
               			$('#btnMinus_'+j).click();
               		}
               		var t_key = q_getHref();
               		var t_where="where=^^ noa='"+t_key[1]+"' ^^";
                	q_gt('view_vcces', t_where, 0, 0, 0, "", r_accy,1);
			        var as = _q_appendData("view_vcces", "", true);
			        var t_ordewhere='1=0';
			        for(var i = 0; i < as.length; i++) {
			        	if(as[i].ordeno.length>0 && as[i].no2.length>0){
			        		t_ordewhere=t_ordewhere+" or  (noa='"+as[i].ordeno+"' and no2='"+as[i].no2+"')"
			        	}
			        }
			        q_gt('view_ordes',"where=^^"+t_ordewhere+"^^", 0, 0, 0, "", r_accy,1);
			        var ass = _q_appendData("view_ordes", "", true);
			        for(var i = 0; i < as.length; i++) {
			        	for(var j = 0; j < ass.length; j++) {
			        		if(as[i].ordeno==ass[j].noa && as[i].no2==ass[j].no2){
			        			as[i].packway=ass[j].packwayno;
			        			as[i].pack=ass[j].packway;
			        			break;
			        		}
			        	}
			        }
			        
               		q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtSpec,txtPackway,txtPack,txtMount,txtMemo,txtOrdeno,txtNo2', as.length, as
               		, 'productno,product,spec,packway,pack,mount,memo,ordeno,no2', 'txtProductno');
               		
               		for(var j = 0; j < q_bbsCount; j++) {
               			if(!emp($('#txtProductno_'+j).val()) &&!emp($('#txtPackway_'+j).val())){
               				var t_where="where=^^ noa='"+$('#txtProductno_'+j).val()+"' and packway='"+$('#txtPackway_'+j).val()+"' ^^";
                			q_gt('pack2s', t_where, 0, 0, 0, "", r_accy,1);
							var as = _q_appendData("pack2s", "", true);
							if (as[0] != undefined) {
			                    var t_gweight=0; //毛重
			                    var t_nweight=0; //淨重
								var t_mount=dec($('#txtMount_'+j).val());
								var t_uweight=dec(as[0].uweight);
								var t_inmount=dec(as[0].inmount);
								var t_outmount=dec(as[0].outmount);
								var t_inweight=dec(as[0].inweight);
								var t_outweight=dec(as[0].outweight);
								var t_cuft=dec(as[0].cuft);
								t_nweight=q_mul(t_mount,t_uweight);
								var t_pfmount=q_mul(t_inmount,t_outmount)==0?1:Math.floor(q_div(t_mount,q_mul(t_inmount,t_outmount))); //一整箱
								var t_pcmount=q_mul(t_inmount,t_outmount)==0?1:Math.ceil(q_div(t_mount,q_mul(t_inmount,t_outmount))); //總箱數
								var t_emount=q_sub(t_mount,q_mul(t_pfmount,q_mul(t_inmount,t_outmount))); //散裝數量
								t_gweight=q_add(q_add(q_mul(q_mul(t_inmount,t_outmount),t_uweight),t_outweight),q_mul(t_inweight,t_outmount));//一箱毛重
								t_gweight=q_mul(t_pfmount,t_gweight); //整箱毛重
								if(t_emount>0){ //散裝(淨重+外包裝重+內包裝重)
									var tt_weight=q_mul(t_emount,t_uweight);
									tt_weight=q_add(tt_weight,t_outweight);
									tt_weight=q_add(tt_weight,q_mul(Math.ceil((t_inmount==0?1:q_div(t_emount,t_inmount))),t_inweight));
									t_gweight=q_add(t_gweight,tt_weight);
								}
								$('#txtWeight_'+j).val(t_nweight);
								$('#txtGweight_'+j).val(t_gweight);
								$('#txtCuft_'+j).val(q_mul(t_cuft,t_pcmount));
								$('#txtQtyctn_'+j).val(round(q_mul(t_inmount,t_outmount),0));
							}
               			}		
               		}
				});
				
				$('#btnSort1').click(function() {
					var pack=[];
					//統計箱號
					for(var j = 0; j < q_bbsCount; j++) {
               			if(!emp($('#txtCtnno_'+j).val())){
               				var exists=false;
               				for(var i = 0; i < pack.length; i++) {
	               				if(pack[i].carno==$('#txtCtnno_'+j).val()){
	               					exists=true;
	               					break;
	               				}
	               			}
	               			if(!exists){
		               			pack.push({
		               				carno:$.trim($('#txtCtnno_'+j).val()), //箱號
		               				mount:0 //目前已使用箱數
		               			});
	               			}
               			}
               			//空白箱號
               			pack.push({
		               		carno:'',
		               		mount:0
		               	});
               		}
               		//處理箱數
               		for(var j = 0; j < q_bbsCount; j++) {
               			if(!emp($('#txtProductno_'+j).val()) && dec($('#txtMount_'+j).val())>0){
               				var t_bctn=0,t_ectn=0;
               				var t_qtyctn=dec($('#txtQtyctn_'+j).val())>0?dec($('#txtQtyctn_'+j).val()):1;
               				var t_tctn=Math.ceil(q_div(dec($('#txtMount_'+j).val()),t_qtyctn)); //總箱數
               				//取目前箱數
               				for(var i = 0; i < pack.length; i++) {
               					if(pack[i].carno==$.trim($('#txtCtnno_'+j).val())){
               						t_bctn=pack[i].mount+1;
               						t_ectn=pack[i].mount+t_tctn;
               						pack[i].mount=t_ectn;
               						break;
               					}
               				}
               				$('#txtBctn_'+j).val(t_bctn);
               				$('#txtEctn_'+j).val(t_ectn);
               			}
               		}
				});
				
				$('#btnSort2').click(function() {
					$('#btnSort1').click();
					var t_ctnno='',t_qtyctn=0,t_bctn=0,t_mount=0;
					for(var j = 0; j < q_bbsCount; j++) {
						if(!emp($('#txtProductno_'+j).val()) && dec($('#txtMount_'+j).val())>0){
							if(t_ctnno!=$('#txtCtnno_'+j).val()
							|| t_qtyctn!=dec($('#txtQtyctn_'+j).val())
							|| (t_mount+dec($('#txtMount_'+j).val()))>dec($('#txtQtyctn_'+j).val())
							){
								t_ctnno=$('#txtCtnno_'+j).val();
								t_qtyctn=dec($('#txtQtyctn_'+j).val());
								t_mount=dec($('#txtMount_'+j).val());
								t_bctn=dec($('#txtBctn_'+j).val());
							}else{
								t_mount=q_add(t_mount,dec($('#txtMount_'+j).val()));
								$('#txtBctn_'+j).val(t_bctn);
								$('#txtEctn_'+j).val(t_bctn);
							}
						}
					}
				});
				
				$('#btnSplit').click(function() {
					for(var j = 0; j < q_bbsCount; j++) {
						if(!emp($('#txtProductno_'+j).val()) && dec($('#txtMount_'+j).val())>0){
							var t_qtyctn=dec($('#txtQtyctn_'+j).val())>0?dec($('#txtQtyctn_'+j).val()):1;
							var c_tctn=Math.ceil(q_div(dec($('#txtMount_'+j).val()),t_qtyctn)); //總箱數
							var f_tctn=Math.floor(q_div(dec($('#txtMount_'+j).val()),t_qtyctn)); //整箱數
							if(c_tctn!=f_tctn && c_tctn!=1 && f_tctn!=0){
								q_bbs_addrow('bbs',j, 1); //增加空白行
								//複製上一筆資料
								$('#txtCtnno_'+(j+1)).val($('#txtCtnno_'+j).val());
								$('#txtProductno_'+(j+1)).val($('#txtProductno_'+j).val());
								$('#txtProduct_'+(j+1)).val($('#txtProduct_'+j).val());
								$('#txtSpec_'+(j+1)).val($('#txtSpec_'+j).val());
								$('#txtPackway_'+(j+1)).val($('#txtPackway_'+j).val());
								$('#txtPack_'+(j+1)).val($('#txtPack_'+j).val());
								$('#txtMount_'+(j+1)).val($('#txtProductno_'+j).val());
								$('#txtQtyctn_'+(j+1)).val($('#txtQtyctn_'+j).val());
								$('#txtMemo_'+(j+1)).val($('#txtMemo_'+j).val());
								$('#txtOrdeno_'+(j+1)).val($('#txtOrdeno_'+j).val());
								$('#txtNo2_'+(j+1)).val($('#txtNo2_'+j).val());
								var t_mount=dec($('#txtMount_'+j).val());
								$('#txtMount_'+(j+1)).val(q_sub(t_mount,q_mul(f_tctn,t_qtyctn)));
								$('#txtMount_'+j).val(q_mul(f_tctn,t_qtyctn));
								getweight(j);
								getweight(j+1);
							}
						}
					}
					$('#btnSort1').click();
				});
			}
		
		    function bbsAssign() {
		    		for(var j = 0; j < q_bbsCount; j++) {
		            	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
		            		/*$('#txtNo2_'+j).change(function() {
		            			t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                    q_bodyId($(this).attr('id'));
			                    b_seq = t_IdSeq;
			                    
			                     for(var j = 0; j < vccs.length; j++) {
			                     	if(vccs[j].no2==$('#txtNo2_'+b_seq).val()){
			                     		$('#txtUno_'+b_seq).val(vccs[j].uno);
			                     		$('#txtProductno_'+b_seq).val(vccs[j].productno);
			                     		$('#txtProduct_'+b_seq).val(vccs[j].product);
			                     		$('#txtSpec_'+b_seq).val(vccs[j].spec);
			                     		$('#txtSize_'+b_seq).val(vccs[j].size);
			                     		$('#txtDime_'+b_seq).val(vccs[j].dime);
			                     		$('#txtWidth_'+b_seq).val(vccs[j].width);
			                     		$('#txtHeight_'+b_seq).val(vccs[j].lengthb);
			                     		$('#txtMount_'+b_seq).val(vccs[j].mount);
			                     		$('#txtWeight_'+b_seq).val(vccs[j].weight);
			                     		$('#txtPrice_'+b_seq).val(vccs[j].price);
			                     		$('#txtMemo_'+b_seq).val(vccs[j].memo);
			                     		break;	
			                     	}
			                     }
							});*/
							
							$('#txtMount_'+j).change(function() {
		            			t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                    q_bodyId($(this).attr('id'));
			                    b_seq = t_IdSeq;
								
								if(emp($('#txtProductno_'+b_seq).val())){
			                    	alert('請先輸入'+q_getMsg('lblProductno_s')+'!!');
			                    }
			                    if(emp($('#txtPackway_'+b_seq).val())){
			                    	alert('請先輸入'+q_getMsg('lblPackway_s')+'!!');
			                    }
			                    getweight(b_seq);
							});
							
							$('#txtQtyctn_'+j).change(function() {
		            			t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                    q_bodyId($(this).attr('id'));
			                    b_seq = t_IdSeq;
								
								if(emp($('#txtProductno_'+b_seq).val())){
			                    	alert('請先輸入'+q_getMsg('lblProductno_s')+'!!');
			                    }
			                    if(emp($('#txtPackway_'+b_seq).val())){
			                    	alert('請先輸入'+q_getMsg('lblPackway_s')+'!!');
			                    }
			                    getweight(b_seq);
							});
							
							$('#btnPackway_'+j).click(function() {
		            			t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                    q_bodyId($(this).attr('id'));
			                    b_seq = t_IdSeq;
			                    if(emp($('#txtProductno_'+b_seq).val())){
			                    	alert('請先輸入'+q_getMsg('lblProductno_s')+'!!');
			                    }else{
		            				t_where = "noa='" + $('#txtProductno_'+b_seq).val() + "'";
                					q_box("pack2_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pack2', "95%", "95%", q_getMsg('popPack2'));
                				}
							});
						}
					}
		        _bbsAssign();
		        /*for(var j = 0; j < q_bbsCount; j++) {
		    		$('#lblNo_' + j).text(j + 1);
				}*/
		    }
		    
		    function getweight(noq) {
		    	if(emp($('#txtProductno_'+noq).val()) || emp($('#txtPackway_'+noq).val()))
		    		return;
		    	var t_where="where=^^ noa='"+$('#txtProductno_'+noq).val()+"' and packway='"+$('#txtPackway_'+noq).val()+"' ^^";
                q_gt('pack2s', t_where, 0, 0, 0, "", r_accy,1);
				var as = _q_appendData("pack2s", "", true);
				if (as[0] != undefined) {
					var t_gweight=0; //毛重
					var t_nweight=0; //淨重
					var t_mount=dec($('#txtMount_'+noq).val());
					var t_uweight=dec(as[0].uweight);
					var t_inmount=dec(as[0].inmount);
					var t_outmount=dec(as[0].outmount);
					var qtyctn=dec($('#txtQtyctn_'+noq).val())>0?dec($('#txtQtyctn_'+noq).val()):round(q_mul(t_inmount,t_outmount),0);
					var t_inweight=dec(as[0].inweight);
					var t_outweight=dec(as[0].outweight);
					var x_gweight=dec(as[0].gweight); //PACK2毛重
					var t_cuft=dec(as[0].cuft);
					t_nweight=q_mul(t_mount,t_uweight);
					var t_pfmount=qtyctn==0?1:Math.floor(q_div(t_mount,qtyctn)); //一整箱
					var t_pcmount=qtyctn==0?1:Math.ceil(q_div(t_mount,qtyctn)); //總箱數
					var t_emount=q_sub(t_mount,q_mul(t_pfmount,qtyctn)); //散裝數量
					if(x_gweight==0)
						x_gweight=q_add(q_add(q_mul(q_mul(t_inmount,t_outmount),t_uweight),t_outweight),q_mul(t_inweight,t_outmount));//一箱毛重
					t_gweight=q_mul(t_pfmount,x_gweight); //整箱毛重
					if(t_emount>0){ //散裝(淨重+外包裝重+內包裝重)
						var tt_weight=q_mul(t_emount,t_uweight);
						tt_weight=q_add(tt_weight,t_outweight);
						tt_weight=q_add(tt_weight,q_mul(Math.ceil((t_inmount==0?1:q_div(t_emount,t_inmount))),t_inweight));
						t_gweight=q_add(t_gweight,tt_weight);
					}
					$('#txtWeight_'+noq).val(t_nweight);
					$('#txtGweight_'+noq).val(t_gweight);
					$('#txtCuft_'+noq).val(q_mul(t_cuft,t_pcmount));
				}
		    }
		    
		    function q_boxClose(s2) { ///   q_boxClose 2/4 
				var ret;
				switch (b_pop) { 
					case 'pack2':
						if(b_ret[0] != undefined){
							q_tr('txtPackway_'+b_seq,b_ret[0].packway);
							q_tr('txtPack_'+b_seq,b_ret[0].pack);
							q_tr('txtQtyctn_'+b_seq,round(q_mul(dec(b_ret[0].inmount),dec(b_ret[0].outmount)),0));
							/*q_tr('txtHeight_'+b_seq,b_ret[0].height);
							q_tr('txtWidth_'+b_seq,b_ret[0].width);
							q_tr('txtLengthb_'+b_seq,b_ret[0].lengthb);
							q_tr('txtMount_'+b_seq,b_ret[0].outmount);
							q_tr('txtWeight_'+b_seq,b_ret[0].weight);
							q_tr('txtGweight_'+b_seq,b_ret[0].gweight);
							q_tr('txtCuft_'+b_seq,b_ret[0].cuft);*/
						}
						getweight(b_seq);
					break;  
				}   /// end Switch
				b_pop = '';
			}
		
		    function btnOk() {
		        t_key = q_getHref();
		        _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);  // (key_value, bbmKey[0], bbsKey[1], '', 2);
		    }
		
		    function bbsSave(as) {
		        if (!as['productno'] && !as['product'] && !as['ctnno'] && !as['spec'] && !as['packway'] && !as['pack']) {  // Dont Save Condition
		           as[bbsKey[0]] = '';   /// noa  empty --> dont save
            		return;
        		}
        		q_getId2('', as);  // write keys to as
        		return true;
		    }
		
		    function btnModi() {
		        var t_key = q_getHref();
		        if (!t_key)
		            return;
		        _btnModi(1);
		        
		        for(var j = 0; j < q_bbsCount; j++) {
		            $('#btnPackway_'+j).removeAttr('disabled');
		        }
		    }

		    function refresh() {
		        _refresh();
		        for(var j = 0; j < q_bbsCount; j++) {
	            	$('#btnPackway_'+j).attr('disabled','disabled');
		        }
		    }
		    
		    //var vccs;
		    function q_gtPost(t_name) {
				switch (t_name) {
					/*case 'vccs':
						vcces=_q_appendData("vccs", "", true);
						break;*/
				}  /// end switch
		    }
		
		    function readonly(t_para, empty) {
		        _readonly(t_para, empty);
		        
		    }
		
		    function btnMinus(id) {
		        _btnMinus(id);
		    }
		
		    function btnPlus(org_htm, dest_tag, afield) {
		        _btnPlus(org_htm, dest_tag, afield);
		        if (q_tables == 's')
		            bbsAssign();
		    }
		    
		    function q_popPost(s1) {
		    	switch (s1) {
			        
		    	}
			}
		</script>
		<style type="text/css">
            td a {
                font-size: medium;
            }
            input[type="text"] {
                font-size: medium;
            }
            .txt{
            	float:left;
            	width:98%;
            }
            .num{
            	text-align: right;
            }
		</style>
	</head>
	<body>
		<div id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<input id="btnVcces" type="button" value="匯入派車單明細">
			<input id="btnSort1" type="button" value="箱號重排">
			<input id="btnSort2" type="button" value="混箱箱號重排">
			<input id="btnSplit" type="button" value="分裝尾箱">
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:1800px;'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:32px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:50px;display: none;"><a id='lblNo_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblCtnno_s'> </a></td>
					<td align="center" style="width:130px;"><a id='lblCtn_s'> </a></td>
					<td align="center" style="width:160px;display: none;"><a id='lblUno_s'> </a></td>
					<td align="center" style="width:170px;"><a id='lblProductno_s'> </a> /<a id='lblProduct_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblSpec_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPackway_s'> </a></td>
					<td align="center" style="width:120px;"><a id='lblPack_s'> </a></td>
					<td align="center" style="width:100px;display: none;"><a id='lblSize_s'> </a></td>
					<td align="center" style="width:100px;display: none;"><a id='lblDime_s'> </a></td>
					<td align="center" style="width:100px;display: none;"><a id='lblLengthb_s'> </a></td>
					<td align="center" style="width:100px;display: none;"><a id='lblWidth_s'> </a></td>
					<td align="center" style="width:100px;display: none;"><a id='lblHeight_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblQtyctn_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblNweight_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblGweight_s'> </a></td>
					<td align="center" style="width:100px;display: none;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblCuft_s'> </a></td>
					<td align="center"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblOrdeno_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
						<input class="txt c1"  id="txtNoa.*" type="hidden"  />
                    	<input id="txtNoq.*" type="hidden" />
					</td>
					<td><input class="txt" id="txtCtnno.*" type="text" /></td>
					<td>
						<input class="txt" id="txtBctn.*" type="text" style="width: 40%;" /><a style="float: left;">~</a>
						<input class="txt" id="txtEctn.*" type="text" style="width: 40%;"/>
					</td>
					<td style="display: none;"><input class="txt" id="txtUno.*" type="text" /></td>
					<td>
						<input class="txt" id="txtProductno.*" type="text" />
						<input class="txt" id="txtProduct.*" type="text" />
					</td>
					<td><input class="txt" id="txtSpec.*" type="text" /></td>
					<td>
						<input class="txt" id="txtPackway.*" type="text" style="width:75%;" />
						<input class="btn"  id="btnPackway.*" type="button" value='.' style="font-weight: bold; "  />
					</td>
					<td><input class="txt" id="txtPack.*" type="text" /></td>
					<td style="display: none;"><input class="txt" id="txtSize.*" type="text" /></td>
					<td style="display: none;"><input class="txt num" id="txtDime.*" type="text" /></td>
					<td style="display: none;"><input class="txt num" id="txtLengthb.*" type="text" /></td>
					<td style="display: none;"><input class="txt num" id="txtWidth.*" type="text" /></td>
					<td style="display: none;"><input class="txt num" id="txtHeight.*" type="text" /></td>
					<td><input class="txt num" id="txtMount.*" type="text" /></td>
					<td><input class="txt num" id="txtQtyctn.*" type="text" /></td>
					<td><input class="txt num" id="txtWeight.*" type="text" /></td>
					<td><input class="txt num" id="txtGweight.*" type="text" /></td>
					<td style="display: none;"><input class="txt num" id="txtPrice.*" type="text" /></td>
					<td><input class="txt num" id="txtCuft.*" type="text" /></td>
					<td><input class="txt" id="txtMemo.*" type="text" /></td>
					<td>
						<input class="txt" id="txtOrdeno.*" type="text" style="width: 75%;" />
						<input class="txt" id="txtNo2.*" type="text"  style="width: 20%;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
