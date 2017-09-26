<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			q_tables = 't';
			var q_name = "cub";
			var q_readonly = ['txtNoa','txtComp','txtWorker','txtWorker2','txtMo','txtVcceno','txtCost'//,'txtIpfrom','txtIpto'
			,'txtChecker','txtCheckerdate','txtApprove','txtApprovedate','txtIssuedate'];
			var q_readonlys = ['txtDate2', 'txtOrdeno', 'txtNo2','txtMo','txtW01'];
			var q_readonlyt = ['txtSpec','txtSize','txtPlace'];
			var bbmNum = [['txtMount',10,0,1],['txtCost',15,0,1]];
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			q_copy = 1;
			brwCount2 = 12;
			aPop = new Array(
				['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx']
				//,['txtProductno_', '', 'ucx', 'noa,product', 'txtProductno_,txtProduct_', 'ucx_b.aspx']
				,['txtProductno', 'lblProduct', 'ucaucc', 'noa,product,spec,unit', 'txtProductno,txtProduct,txtSpec,txtUnit', 'ucaucc_b.aspx']
				,['txtTggno_', 'btnTggno_', 'tgg', 'noa,comp', 'txtTggno_,txtTgg_', "tgg_b.aspx"]
				,['txtM1', '', 'adsize', 'noa,mon,memo1,memo2', '0txtM1', '']
				,['txtM4', '', 'adsss', 'noa,mon,memo1,memo2', '0txtM4', '']
				,['txtM2','','adly','noa,mon,memo,memo1,memo2','0txtM2','']
				,['txtM3','','adly','noa,mon,memo,memo1,memo2','0txtM3','']
				,['txtM8','','addime','noa,mon,memo,memo1,memo2','0txtM8','']
				,['txtM9','','adly','noa,mon,memo,memo1,memo2','0txtM9','']
				,['txtM10','','adly','noa,mon,memo,memo1,memo2','0txtM10','']
				,['txtFactoryno','lblFactory','factory','noa,factory','txtFactoryno,txtFactory','factory_b.aspx']
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				
				//李經理 預設只要顯示未處理的單子 8001
				if((q_getPara('sys.project').toUpperCase()=="AD" || q_getPara('sys.project').toUpperCase()=="JO")){
					if(r_userno=='8001'){
						q_content="where=^^isnull(approve,'')=''^^"
					}
				}
				
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}
			
			function sum() {
				var t_cost=0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_cost=q_add(t_cost,dec($('#txtMo_'+j).val()));
				}
				$('#txtCost').val(t_cost);
			}

			function mainPost() {
				document.title='樣品流程管理';
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtMedate', r_picd],['txtUindate', r_picd]];
				bbsMask = [['txtDate2', r_picd], ['txtDatea', r_picd]];
				
				bbmNum = [['txtMount',10,q_getPara('vcc.mountPrecision'),1],['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1]
				,['txtMo', 15, 0, 1]];
				bbsNum = [['txtMount', 15, q_getPara('vcc.mountPrecision'), 1],['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1]
				,['txtMo', 15, 0, 1],['txtW02', 15, 0, 1],['txtW01', 15, 0, 1]];
				bbtNum = [['txtMount', 15, q_getPara('vcc.mountPrecision'), 1]];
				q_mask(bbmMask);
				q_gt('acomp', "where=^^ dbname!='"+q_db+"' and isnull(dbname,'')!='' and isnull(ip,'')!='' ^^", 0, 0, 0, "getipto");
				q_gt('acomp', "where=^^ dbname='"+q_db+"' and isnull(dbname,'')!='' and isnull(ip,'')!='' ^^", 0, 0, 0, "getipfrom");
				
				$('#txtMo').change(function() {
					if(dec($('#txtMount').val())!=0 && dec($('#txtMo').val())!=0){
						$('#txtPrice').val(round(q_div(dec($('#txtMo').val()),dec($('#txtMount').val())),q_getPara('vcc.pricePrecision')));
					}
				});
						
				$('#txtMount').change(function() {
					$('#txtMo').val(round(q_mul(dec($('#txtMount').val()),dec($('#txtPrice').val())),0));
				});
				
				$('#txtPrice').change(function() {
					$('#txtMo').val(round(q_mul(dec($('#txtMount').val()),dec($('#txtPrice').val())),0));
				});
				
				/*$('#chkIsproj').change(function() {
					bbsdisabled();
				});*/
				
				$('#txtVcceno').click(function() {
					var t_vccno = $.trim($("#txtVcceno").val());
                    if (t_vccno.length > 0) {
                    	var t_where = "noa='" + t_vccno + "'";
                        q_box("vcc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, q_name, "98%", "98%", q_getMsg("popSeek"));
					}
				});
				
				$('#chkEnda').change(function() {
					if($(this).prop('checked') && emp($('#txtEdate').val()))
						$('#txtEdate').val(q_date());
				});
				
				$('#chkMenda').change(function() {
					if($(this).prop('checked') && emp($('#txtMedate').val()))
						$('#txtMedate').val(q_date());
				});				
				
				$('#btnCheckapv').click(function() {
					//執行txt
					if(!(q_cur==1 || q_cur==2) && !emp($('#txtNoa').val())){
						if(emp($('#txtChecker').val()) && !emp($('#txtUcxno').val()) && !emp($('#cmbIpto').val())){
							var t_noa=$('#txtNoa').val();							
							
							q_func('qtxt.query.cub_apv', 'cub.txt,cub_apv,' + encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI('checker'),r_accy,1);
		                	var as = _q_appendData("tmp0", "", true, true);
		                	if (as[0] != undefined) {
		                		$('#txtChecker').val(as[0].checker);
		                		$('#txtCheckerdate').val(as[0].checkerdate);
		                		abbm[q_recno]['checker'] = as[0].checker;
                            	abbm[q_recno]['checkerdate'] = as[0].checkerdate;
		                	}
						}else{
							if(!emp($('#txtChecker').val()))
								alert('已被【'+$('#txtChecker').val()+'】核准!!');
							else
								alert('【Ipto】與【生產發行件號】禁止空白!!');
						}
					}
				});
				
				$('#btnApproveapv').click(function() {
					//執行txt
					if(!(q_cur==1 || q_cur==2) && !emp($('#txtNoa').val())){
						if(!emp($('#txtChecker').val()) && !emp($('#txtCheckerdate').val())){
							var t_noa=$('#txtNoa').val();
							//t_noa,r_userno,r_name
							if(q_getPara('sys.project').toUpperCase()=="AD" || q_getPara('sys.project').toUpperCase()=="JO"){
								if(r_userno=='8001'){
									q_func('qtxt.query.cub_apv', 'cub.txt,cub_apv,' + encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI('approve'),r_accy,1);
				                	var as = _q_appendData("tmp0", "", true, true);
				                	if (as[0] != undefined) {
				                		$('#txtApprove').val(as[0].approve);
				                		$('#txtApprovedate').val(as[0].approvedate);
				                		abbm[q_recno]['checker'] = as[0].approve;
		                            	abbm[q_recno]['checkerdate'] = as[0].approvedate;
				                	}
								}else{
									alert('需由李經理核准!!');
								}
							}else{
								q_func('qtxt.query.cub_apv', 'cub.txt,cub_apv,' + encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI('approve'),r_accy,1);
			                	var as = _q_appendData("tmp0", "", true, true);
			                	if (as[0] != undefined) {
			                		$('#txtApprove').val(as[0].approve);
				                	$('#txtApprovedate').val(as[0].approvedate);
				                	abbm[q_recno]['checker'] = as[0].approve;
		                            abbm[q_recno]['checkerdate'] = as[0].approvedate;
			                	}
							}
						}else{
							alert('業務主管尚未核准!!');
						}
					}
				});
				
				$('#btnApproveucx').click(function() {
					//執行txt
					if(!(q_cur==1 || q_cur==2) && !emp($('#txtNoa').val())){
						if(!emp($('#txtApprove').val()) && !emp($('#txtApprovedate').val()) && emp($('#txtIssuedate').val())){
							if(!emp($('#txtUcxno').val()) && !emp($('#cmbIpto').val())){
								var t_noa=$('#txtNoa').val();
								q_func('qtxt.query.cub_apv', 'cub.txt,cub_apv,' + encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI('issue'),r_accy,1);
				                var as = _q_appendData("tmp0", "", true, true);
				                if (as[0] != undefined) {
				                	$('#txtIssuedate').val(as[0].issuedate);
				                	abbm[q_recno]['issuedate'] = as[0].issuedate;
				                	
				                	if(as[0].tip.length==0){
				                		alert('發行公司主檔【對應IP】沒有填寫!!');
				                	}else if(as[0].tdb.length==0){
				                		alert('發行公司主檔【對應資料庫名稱】沒有填寫!!');
				                	}else{
				                		alert('生產發行件號重複，請重新編號!!');
				                	}
				                }
							}else{
								if(emp($('#txtUcxno').val())){
									alert('請填寫生產發行件號!!');
								}else{
									alert('請選擇Ipto!!');
								}
							}
						}else{
							if(!emp($('#txtIssuedate').val())){
								alert('禁止重複發行!!');
							}else{
								alert('開發經理尚未核准!!');
							}
						}
					}
				});
			}
			
			var z_cno='';
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'stpost_rc2_0':
                        var as = _q_appendData("view_rc2", "", true);
                        for (var i = 0; i < as.length; i++) {
                            q_func('rc2_post.post', as[i].accy + ',' + as[i].noa + ',0');
                            sleep(100);
                        }
                        
                        q_gt('view_vcc', "where=^^zipcode='" + $('#txtNoa').val() + "'^^", 0, 0, 0, "",r_accy,1);
                        var ass = _q_appendData("view_vcc", "", true);
                        if (ass[0] != undefined) {
                        	q_func('vcc_post.post', ass[0].accy + ',' + ass[0].noa + ',0');
                            sleep(100);
                        }
                        
                        //執行txt
                        q_func('qtxt.query.cub_r_0', 'cub.txt,cub_r,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val()) + ';0;' + encodeURI(q_getPara('sys.key_rc2'))+';'+ encodeURI(q_getPara('sys.key_vcc'))+ ';' + encodeURI($('#txtFactoryno').val()));
                        break;
					case 'stpost_rc2_1':
                        var as = _q_appendData("view_rc2", "", true);
                        for (var i = 0; i < as.length; i++) {
                            q_func('rc2_post.post', as[i].accy + ',' + as[i].noa + ',1');
                            sleep(100);
                        }
                        
                        q_gt('view_vcc', "where=^^zipcode='" + $('#txtNoa').val() + "'^^", 0, 0, 0, "",r_accy,1);
                        var ass = _q_appendData("view_vcc", "", true);
                        if (ass[0] != undefined) {
                        	q_func('vcc_post.post', ass[0].accy + ',' + ass[0].noa + ',1');
                            sleep(100);
                        }
                        
                        Unlock(1);
                        break;
					case 'stpost_rc2_3':
                        var as = _q_appendData("view_rc2", "", true);
                        for (var i = 0; i < as.length; i++) {
                            q_func('rc2_post.post', as[i].accy + ',' + as[i].noa + ',0');
                            sleep(100);
                        }
                        
                        q_gt('view_vcc', "where=^^zipcode='" + $('#txtNoa').val() + "'^^", 0, 0, 0, "",r_accy,1);
                        var ass = _q_appendData("view_vcc", "", true);
                        if (ass[0] != undefined) {
                        	q_func('vcc_post.post', ass[0].accy + ',' + ass[0].noa + ',0');
                            sleep(100);
                        }
                        
                        q_func('qtxt.query.cub_r_3', 'cub.txt,cub_r,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val()) + ';0;' + encodeURI(q_getPara('sys.key_rc2'))+';'+ encodeURI(q_getPara('sys.key_vcc'))+ ';' + encodeURI($('#txtFactoryno').val()));
                        break;
                    case 'getrc2no':
                        var as = _q_appendData("view_cubs", "", true);
                        for (var i = 0; i < as.length; i++) {
                            for (var j = 0; j < q_bbsCount; j++) {
                                if (as[i].noq == $('#txtNoq_' + j).val()) {
                                    $('#txtOrdeno_' + j).val(as[i].ordeno);
                                }
                            }
                            for (var j = 0; j < abbs.length; j++) {
                                if (abbs[j]['noa'] == as[i].noa && abbs[j]['noq'] == as[i].noq) {
                                    abbs[j]['ordeno'] = as[i].ordeno;
                                }
                            }
                        }
                        break;
					case 'getvccno':
                        var as = _q_appendData("view_cub", "", true);
                        if (as[0] != undefined) {
                        	$('#txtVcceno').val(as[0].vcceno);
                        	$('#txtMvcceno').val(as[0].mvcceno);
                            abbm[q_recno]['vcceno'] = as[0].vcceno;
                            abbm[q_recno]['mvcceno'] = as[0].mvcceno;
                        }
                        break;
                    case 'factory':
                		var as = _q_appendData("factory", "", true);
                        var t_item ="";
						if (as[0] != undefined) {
							t_item =(t_item.length > 0 ? ',' : '') + as[0].ip + ','+ as[0].db;
						}
						$('#txtIpto').val(t_item);
                		break;    
					case 'getipto':
						var as = _q_appendData("acomp", "", true);
                        var t_item ="@";
                        for (var i = 0; i < as.length; i++) {
							t_item =(t_item.length > 0 ? ',' : '') + as[i].noa + '@'+ as[i].nick;
						}
						
						q_cmbParse("cmbIpto", t_item);
						if(abbm[q_recno]){
							$('#cmbIpto').val(abbm[q_recno].ipto);
						}
						break;
					case 'getipfrom':
						var as = _q_appendData("acomp", "", true);
                        var t_item ="@";
                        for (var i = 0; i < as.length; i++) {
                        	if(i==0){
                        		z_cno=as[i].noa;
                        	}
							t_item =(t_item.length > 0 ? ',' : '') + as[i].noa + '@'+ as[i].nick;
						}
						
						q_cmbParse("cmbIpfrom", t_item);
						if(abbm[q_recno]){
							$('#cmbIpfrom').val(abbm[q_recno].ipfrom);
						}
						break;	
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}
			
			function sleep(milliseconds) {
                var start = new Date().getTime();
                for (var i = 0; i < 1e7; i++) {
                    if ((new Date().getTime() - start) > milliseconds) {
                        break;
                    }
                }
            }
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.cub_r_0':
                        q_func('qtxt.query.cub_r_1', 'cub.txt,cub_r,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val()) + ';1;' + encodeURI(q_getPara('sys.key_rc2'))+';'+ encodeURI(q_getPara('sys.key_vcc'))+ ';' + encodeURI($('#txtFactoryno').val()));
                        break;
                    case 'qtxt.query.cub_r_1':
                        q_gt('view_rc2', "where=^^postname='" + $('#txtNoa').val() + "'^^", 0, 0, 0, "stpost_rc2_1");
                        //回寫到bbs 與 bbm
                        q_gt('view_cubs', "where=^^noa='" + $('#txtNoa').val() + "'^^", 0, 0, 0, "getrc2no");
                        q_gt('view_cub', "where=^^noa='" + $('#txtNoa').val() + "'^^", 0, 0, 0, "getvccno");
                        break;
                    case 'qtxt.query.cub_r_3':
                        _btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
                        break;
                }
            }

			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				if (!emp($('#txtNoa').val())) {
                    Lock(1, {
                        opacity : 0
                    });
                    
                    q_gt('view_rc2', "where=^^postname='" + $('#txtNoa').val() + "'^^", 0, 0, 0, "stpost_rc2_0");
                }
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			
			function q_popPost(id){
				switch(id){
					case 'txtFactoryno':
						var t_where = "where=^^ noa ='"+$('#txtFactoryno').val()+"' ^^";
						q_gt('factory', t_where, 0, 0, 0, "factory");		
						break;
					default:
						break;
				}			
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
					
				q_box('cub_r_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}

			function btnIns() {
                _btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				$('#txtMount').val(1);
				$('#cmbIpfrom').val(z_cno);
				
				if(emp($('#txtProcess_0').val())){//自動產生流程
					var as =[];
					as.push({process:'開銅膜/模具'});
					as.push({process:'樣品照片'});
					as.push({process:'客戶確認'});
					as.push({process:'寄送樣品'});
					as.push({process:'客戶收樣品'});
					as.push({process:'轉生產件號'});
					as.push({process:'通知建製程'});
					as.push({process:'越南會計報價日'});//as.push({process:'會計詢價'});
					as.push({process:'PF計算 for 會計'});//as.push({process:'成本計算'});
					as.push({process:'回覆'});
					as.push({process:'報價'});
					as.push({process:'客戶銷售採購價格表'});
					as.push({process:'DDK-ACTIVE 價格表'});
					q_gridAddRow(bbsHtm, 'tbbs', 'txtProcess', as.length, as, 'process', '', '');
				}
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				if(!emp($('#txtIssuedate').val())){
					alert('已發行禁止修改!!');
					return;
				}
				_btnModi();
				$('#txtDatea').focus();
				if(emp($('#cmbIpfrom').val()))
					$('#cmbIpfrom').val(z_cno);
				
				//只取消簽核人員性名，保留時間
				$('#txtChecker').val('');
				$('#txtApprove').val('');
			}

			function btnPrint() {
				q_box('z_cubpr.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				
				if($('#chkEnda').prop('checked') && (emp($('#txtCustno').val()) || emp($('#txtEdate').val()))){
					if(emp($('#txtCustno').val()) && emp($('#txtEdate').val())){
						alert('【'+q_getMsg('lblCust')+'】和【出貨日期】空白，不會產生出貨單!!');
					}else if(emp($('#txtEdate').val())){
						alert('【出貨日期】空白，不會產生出貨單!!');
					}else{
						alert('【'+q_getMsg('lblCust')+'】空白，不會產生出貨單!!');
					}
				}

				if($('#chkMenda').prop('checked') && (emp($('#txtCustno').val()) || emp($('#txtMedate').val()))){
					if(emp($('#txtCustno').val()) && emp($('#txtMedate').val())){
						alert('【'+q_getMsg('lblCust')+'】和【出貨日期】空白，不會產生出貨單!!');
					}else if(emp($('#txtMedate').val())){
						alert('【出貨日期】空白，不會產生出貨單!!');
					}else{
						alert('【'+q_getMsg('lblCust')+'】空白，不會產生出貨單!!');
					}
				}
				
				sum();
				if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);

				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO"){
					//105/05/03 改成S開頭
					q_gtnoa(q_name, replaceAll('S' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					//q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cub') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				}else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['processno'] && !as['process']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				return true;
			}

			function bbtSave(as) {
				if (!as['spec'] && !as['scolor'] && !as['size'] && !as['ucolor'] && !as['place'] && !as['prt'] && !as['memo'] ) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				bbsdisabled();
				showbbtimg();
				//變色
				if(q_getPara('sys.project').toUpperCase()=="AD" || q_getPara('sys.project').toUpperCase()=="JO"){
					var t_where="noa='" + $('#txtNoa').val() + "' and action='Update' and tablea='cub'";
					//取最後修改時間
					t_where+=" and datea+' '+timea in (select MAX(datea+' '+timea) from drun where noa='" + $('#txtNoa').val() + "' and action='Update' and tablea='cub')";
					t_where+=" order by datea,timea";
					t_where="where=^^ "+t_where+" ^^";
					
					q_gt('drun', t_where , 0, 0, 0, "",r_accy,1);
					var as = _q_appendData("drun", "", true);
                    if (as[0] != undefined) {
                        //同一分鐘內可能會有2筆以上的修改紀錄取最後一筆
                        if(as[as.length-1].usera=='8001'){
                        	$("#tbbm input[type='text']").css('color','red');
                        	$("#tbbm textarea").css('color','red');
                        }else{
                        	$("#tbbm input[type='text']").css('color','blue')
                        	$("#tbbm textarea").css('color','blue');
                        }
                    }else{
                    	//無修改紀錄
                    	$("#tbbm input[type='text']").css('color','black')
                    	$("#tbbm textarea").css('color','black');
                    }
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#btnCheckapv').removeAttr("disabled");
					$('#btnApproveapv').removeAttr("disabled");
					$('#btnApproveucx').removeAttr("disabled");
				}else{
					$('#btnCheckapv').attr('disabled', 'disabled');
					$('#btnApproveapv').attr('disabled', 'disabled');
					$('#btnApproveucx').attr('disabled', 'disabled');
				}
				
				bbsdisabled();
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function btnPlut(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
			}

			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						
						$('#chkEnda_'+i).click(function() {
							t_IdSeq = -1; 
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if($(this).prop('checked') && emp($('#txtDatea_'+b_seq).val())){
								$('#txtDatea_'+b_seq).val(q_date());
							}
						});
						
						$('#txtMount_' + i).change(function() {    
                        	t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;  	
                            if(dec($('#txtMount_' + b_seq).val())>0 && dec($('#txtPrice_' + b_seq).val())>0){
                            	t_mount = dec($('#txtMount_' + b_seq).val());
                            	t_price = dec($('#txtPrice_' + b_seq).val());
                            	$('#txtMo_' + b_seq).val(q_mul(t_mount,t_price));
                            	if ($('#chkSale_' + b_seq).is(':checked')) {
	                                var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
	                                $('#txtW02_' + b_seq).css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
	                                $('#txtW02_' + b_seq).val(round(q_mul(dec($('#txtMo_' + b_seq).val()), t_taxrate), 0));
	                            }
                            	$('#txtW01_' + b_seq).val(q_add(dec($('#txtW02_' + b_seq).val()), dec($('#txtMo_' + b_seq).val())));
                            }
                            sum();
                        });
						
						$('#txtPrice_' + i).change(function() {
                        	t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;  	
                            if(dec($('#txtMount_' + b_seq).val())>0 && dec($('#txtPrice_' + b_seq).val())>0){
                            	t_mount = dec($('#txtMount_' + b_seq).val());
                            	t_price = dec($('#txtPrice_' + b_seq).val());
                            	$('#txtMo_' + b_seq).val(q_mul(t_mount,t_price));
                            	if ($('#chkSale_' + b_seq).is(':checked')) {
	                                var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
	                                $('#txtW02_' + b_seq).css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
	                                $('#txtW02_' + b_seq).val(round(q_mul(dec($('#txtMo_' + b_seq).val()), t_taxrate), 0));
	                            }
                            	$('#txtW01_' + b_seq).val(q_add(dec($('#txtW02_' + b_seq).val()), dec($('#txtMo_' + b_seq).val())));
                            }
                            sum();
                        });
						
						if ($('#chkSale_' + i).is(':checked'))
                            $('#txtW02_' + i).css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
						
						$('#chkSale_' + i).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if ($('#chkSale_' + b_seq).is(':checked')) {
                                var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')), 100);
                                $('#txtW02_' + b_seq).css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                                $('#txtW02_' + b_seq).val(round(q_mul(dec($('#txtMo_' + b_seq).val()), t_taxrate), 0));
                            } else
                                $('#txtW02_' + b_seq).css('color', 'black').css('background', 'white').removeAttr('readonly');
							
							$('#txtW01_' + b_seq).val(q_add(dec($('#txtW02_' + b_seq).val()), dec($('#txtMo_' + b_seq).val())));
                        });
                        
                        $('#txtW02_' + i).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
							
							$('#txtW01_' + b_seq).val(q_add(dec($('#txtW02_' + b_seq).val()), dec($('#txtMo_' + b_seq).val())));
                        });
                        
                        $('#txtOrdeno_' + i).click(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            var t_rc2no = $.trim($("#txtOrdeno_" + b_seq).val());
                            if (t_rc2no.length > 0) {
                                var t_where = "noa='" + t_rc2no + "'";
                                q_box("rc2.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, q_name, "98%", "98%", q_getMsg("popSeek"));
                            }
                        });
					}
				}
				_bbsAssign();
				bbsdisabled();
			}
			
			var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				return function() {return s4() + s4() + s4() + s4();};
			})();
			
			function ShowDownlbl() {				
				$('.lblDownload').text('').hide();
				$('.lblDownload').each(function(){
					var txtfiles=replaceAll($(this).attr('id'),'lbl','txt');
					var lblfiles=replaceAll($(this).attr('id'),'lbl','lbl');
					var txtOrgName = replaceAll($(this).attr('id'),'lbl','txt').split('__');
					
					if(!emp($('#'+txtfiles).val()))
						$(this).text('下載').show();
											
					$('#'+lblfiles).click(function(e) {
                        if(txtfiles.length>0){
                        	if(txtOrgName[0]=='txtScolor')
                        		$('#xdownload').attr('src','cub_r_download.aspx?FileName='+$('#txtSpec__'+txtOrgName[1]).val()+'&TempName='+$('#'+txtfiles).val());
                        	if(txtOrgName[0]=='txtUcolor')
                        		$('#xdownload').attr('src','cub_r_download.aspx?FileName='+$('#txtSize__'+txtOrgName[1]).val()+'&TempName='+$('#'+txtfiles).val());
                        	if(txtOrgName[0]=='txtPrt')
                        		$('#xdownload').attr('src','cub_r_download.aspx?FileName='+$('#txtPlace__'+txtOrgName[1]).val()+'&TempName='+$('#'+txtfiles).val());
                        }else
                        	alert('無資料下載!!');
					});
				});
			}
			
			var ttxtName='';
			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
						$('#btnMinut__' + i).click(function() {
							ShowDownlbl();
						});
					}
				}
				_bbtAssign();
				 if(q_cur==1 || q_cur==2){
					$('.btnFiles').removeAttr('disabled', 'disabled');
				}else{
					$('.btnFiles').attr('disabled', 'disabled');
				}
		        $('.btnFiles').change(function() {
					event.stopPropagation(); 
					event.preventDefault();
					if(q_cur==1 || q_cur==2){}else{return;}
					var txtOrgName = replaceAll($(this).attr('id'),'btn','txt').split('__');
					var txtName = replaceAll($(this).attr('id'),'btn','txt');
					ttxtName=txtName;
					file = $(this)[0].files[0];
					if(file){
						Lock(1);
						var ext = '';
						var extindex = file.name.lastIndexOf('.');
						if(extindex>=0){
							ext = file.name.substring(extindex,file.name.length);
						}
						if(txtOrgName[0]=='txtScolor')
							$('#txtSpec__'+txtOrgName[1]).val(file.name);
						if(txtOrgName[0]=='txtUcolor')
							$('#txtSize__'+txtOrgName[1]).val(file.name);
						if(txtOrgName[0]=='txtPrt')
							$('#txtPlace__'+txtOrgName[1]).val(file.name);
						//$('#'+txtName).val(guid()+Date.now()+ext);
						//106/05/22 不再使用亂數編碼
						$('#'+txtName).val(file.name);
						
						fr = new FileReader();
						fr.fileName = $('#'+txtName).val();
					    fr.readAsDataURL(file);
					    fr.onprogress = function(e){
							if ( e.lengthComputable ) { 
								var per = Math.round( (e.loaded * 100) / e.total) ; 
								$('#FileList').children().last().find('progress').eq(0).attr('value',per);
							}; 
						}
						fr.onloadstart = function(e){
							$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
						}
						fr.onloadend = function(e){
							$('#FileList').children().last().find('progress').eq(0).attr('value',100);
							console.log(fr.fileName+':'+fr.result.length);
							var oReq = new XMLHttpRequest();
							oReq.upload.addEventListener("progress",function(e) {
								if (e.lengthComputable) {
									percentComplete = Math.round((e.loaded / e.total) * 100,0);
									$('#FileList').children().last().find('progress').eq(1).attr('value',percentComplete);
								}
							}, false);
							oReq.upload.addEventListener("load",function(e) {
								Unlock(1);
							}, false);
							oReq.upload.addEventListener("error",function(e) {
								alert("資料上傳發生錯誤!");
							}, false);
								
							oReq.timeout = 360000;
							oReq.ontimeout = function () { alert("Timed out!!!"); }
							oReq.open("POST", 'cub_r_upload.aspx', true);
							oReq.setRequestHeader("Content-type", "text/plain");
							oReq.setRequestHeader("FileName", escape(fr.fileName));
							oReq.send(fr.result);
							
							if(fr.result.length>0 && ttxtName=='txtPrt__0'){
								$('#txtMemo2__0').val(fr.result);
								showbbtimg();
							}
							
						};
					}
					ShowDownlbl();
				});
				ShowDownlbl();
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
                //_btnDele();
                if (emp($('#txtNoa').val()))
                    return;
                
				if(!emp($('#txtIssuedate').val())){
					alert('已發行禁止修改!!');
					return;
				}

                if (!confirm(mess_dele))
                    return;
                q_cur = 3;
                
                q_gt('view_rc2', "where=^^postname='" + $('#txtNoa').val() + "'^^", 0, 0, 0, "stpost_rc2_3");
			}

			function btnCancel() {
				_btnCancel();
			}

			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			
			
			function bbsdisabled() {
				if(q_cur==1 || q_cur==2){
					if(emp($('#txtApprovedate').val())){
						$('#chkEnda').attr('disabled', 'disabled');
						$('#txtEdate').attr('disabled', 'disabled');
						$('#chkMenda').attr('disabled', 'disabled');
						$('#txtMedate').attr('disabled', 'disabled');
					}else{
						$('#chkEnda').removeAttr("disabled");
						$('#txtEdate').removeAttr("disabled");
						$('#chkMenda').removeAttr("disabled");
						$('#txtMedate').removeAttr("disabled");
					}
					for (var i = 0; i < q_bbsCount; i++) {
						if(emp($('#txtApprovedate').val())){
							$('#chkEnda_'+i).attr('disabled', 'disabled');
							$('#txtDatea_'+i).attr('disabled', 'disabled');
						}else{
							$('#chkEnda_'+i).removeAttr("disabled");
							$('#txtDatea_'+i).removeAttr("disabled");
						}
					}
				}
			}
			
			function showbbtimg() {
				if(!emp($('#txtMemo2__0').val())){
					$('.bbtimg').css('top', $('#dview').height()+35);
					$('.bbtimg').css('left', 5);
					$('#bbtimg').css('width', '');
					$('#bbtimg').css('height', '');
					
					if($('.dbbs').offset().top-$('#dview').height()-35<$('#dview').width()){
						$('.bbtimg').css('height', ($('.dbbs').offset().top-$('#dview').height()-35)+'px');
						$('#bbtimg').css('height', '100%');
					}else{
						$('.bbtimg').css('width', $('#dview').width()+'px');
						$('#bbtimg').css('width', '100%');
					}
					$('#bbtimg').attr('src',$('#txtMemo2__0').val());
				}else{
					$('#bbtimg').attr('src','');
				}
			}
		</script>
		<style type="text/css">
			#dmain {
				/*overflow: hidden;*/
			}
			.dview {
				float: left;
				border-width: 0px;
				width: 29%;
			}
			.tview {
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
				/*width: 9%;*/
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
				color: black;
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
				width: 99%;
				float: left;
			}

			.num {
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
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs {
				width: 1500px;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				/*background: #cad3ff;*/
				background: lightgrey;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			.dbbs .tbbs select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			#dbbt {
				width: 1260px;
			}
			#tbbt {
				margin: 0;
				padding: 2px;
				border: 2px pink double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: pink;
				width: 100%;
			}
			#tbbt tr {
				height: 35px;
			}
			#tbbt tr td {
				text-align: center;
				border: 2px pink double;
			}
			
			.dbbt tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                cursor: pointer;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div class="bbtimg" style="position:absolute;"><img id="bbtimg" style="MAX-WIDTH: fit-content;MAX-HEIGHT: fit-content;"></div>
		<div id='dmain' style="overflow:hidden;width: 1260px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewChecker'>業務主管</a></td>
						<td style="width:100px; color:black;"><a id='vewApprove'>開發經理</a></td>
						<td style="width:100px; color:black;"><a id='vewIssuedate'>發行日期</a></td>
						<td style="width:120px; color:black;"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='checker' style="text-align: center;">~checker</td>
						<td id='approve' style="text-align: center;">~approve</td>
						<td id='issuedate' style="text-align: center;">~issuedate</td>
						<td id='comp,6' style="text-align: center;">~comp,6</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm" id="tbbm">
					<tr style="height:1px;">
						<td style="width: 12%;"> </td>
						<td style="width: 13%;"> </td>
						<td style="width: 12%;"> </td>
						<td style="width: 13%;"> </td>
						<td style="width: 12%;"> </td>
						<td style="width: 13%;"> </td>
						<td style="width: 12%;"> </td>
						<td style="width: 13%;"> </td>
						<td style="width: 5px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn" > </a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblLevel" class="lbl" >服務等級</a></td>
						<td><input id="txtLevel" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount_r" class="lbl" >訂單數量</a></td>
						<td><input id="txtMount" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblPrice" class="lbl" > </a></td>
						<td><input id="txtPrice" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblMoney_r" class="lbl" >訂單金額</a></td>
						<td><input id="txtMo" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblOrdeno" class="lbl" >訂單號碼</a></td>
						<td><input id="txtOrdeno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl" > </a></td>
						<td><input id="txtProductno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtProduct" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblBdate" class="lbl" > </a></td>
						<td><input id="txtBdate" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblUindate" class="lbl" >應完工日</a></td>
						<td><input id="txtUindate" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSpec" class="lbl" > </a></td>
						<td colspan="3"><input id="txtSpec" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblUnit" class="lbl" > </a></td>
						<td><input id="txtUnit" type="text" class="txt c1"/></td>
						<td  style="display: none;"><span> </span><a id="lblStatus" class="lbl" > </a>完成狀態</td>
						<td><input id="txtStatus" type="hidden" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblM1" class="lbl" >車縫</a></td>
						<td><input id="txtM1" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblM4" class="lbl" >護片</a></td>
						<td><input id="txtM4" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblM2" class="lbl" >皮料號(1)</a></td>
						<td><input id="txtM2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblM9" class="lbl" >皮料號(2)</a></td>
						<td><input id="txtM9" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblM10" class="lbl" >皮料號(3)</a></td>
						<td><input id="txtM10" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblM3" class="lbl" >皮料號(4)</a></td>
						<td><input id="txtM3" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblM6" class="lbl" >印刷/位置</a></td>
						<td colspan="7"><textarea id="txtM6" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea></td>
						<!--<input id="txtM6" type="text" class="txt c1"/>-->
					</tr>
					<tr>
						<td><span> </span><a id="lblM5" class="lbl" >高週波</a></td>
						<td><input id="txtM5" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblM7" class="lbl" >鞍座</a></td>
						<td colspan="3"><input id="txtM7" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblM8" class="lbl" >電鍍</a></td>
						<td><input id="txtM8" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo2_pi" class="lbl" > </a></td>
						<td colspan="5"><input id="txtMemo2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNo2" class="lbl" >訂序</a></td>
						<td><input id="txtNo2" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblIpfrom" class="lbl" >Ipfrom</a></td>
						<td>
							<select id="cmbIpfrom" class="txt c1"> </select>
							<!--<input id="txtIpfrom" type="text" class="txt c1"/>-->
						</td>
						<td><span> </span><a id="lblIpto" class="lbl" >Ipto</a></td>
						<td>
							<select id="cmbIpto" class="txt c1"> </select>
							<!--<input id="txtIpto" type="text" class="txt c1"/>-->
						</td>
						<td><span> </span><a id="lblUcxno" class="lbl" >生產發行件號</a></td>
						<td><input id="txtUcxno" type="text" class="txt c1"/></td>
					</tr>
					<tr style="display: none;"> <!--106/09/25 隱藏 自行打出貨單 開放txt,cub_r需重寫(早期由貿易端寫回製造端 目前改由製造回寫貿易)-->
						<td><span> </span><a id="lblFactory" class="lbl btn" >工廠</a></td>
						<td><input id="txtFactoryno" type="text" class="txt c1"/></td>
						<td><input id="txtFactory" type="text" class="txt c1"/></td>
					</tr>
					<tr style="display: none;"> <!--106/09/25 隱藏 自行打出貨單 開放txt,cub_r需重寫-->
						<td> </td>
						<td colspan="2">
							<input id="chkEnda" type="checkbox"/>
							<a id='lblEnda_r'>貿易端 __ 產生出貨單 </a>
						</td>
						<td><span> </span><a id="lblEdate_r" class="lbl" >出貨日期</a></td>
						<td><input id="txtEdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblVccno_r" class="lbl" >出貨單號</a></td>
						<td><input id="txtVcceno" type="text" class="txt c1"/></td>
						<!--<td>
							<input id="chkCancel" type="checkbox"/>
							<span> </span><a id='lblCancel'>取消</a>
						</td>-->
					</tr>
					<tr style="display: none;"> <!--106/09/25 隱藏 自行打出貨單 開放txt,cub_r需重寫-->
						<td> </td>
						<td colspan="2">
							<input id="chkMenda" type="checkbox"/>
							<a id='lblMenda_r'>製造端 __ 產生出貨單 </a>
							
						</td>
						<td><span> </span><a id="lblMedate_r" class="lbl" >出貨日期</a></td>
						<td><input id="txtMedate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMvccno_r" class="lbl" >出貨單號</a></td>
						<td><input id="txtMvcceno" type="text" class="txt c1"/></td>
						<!--<td>
							<input id="chkCancel" type="checkbox"/>
							<span> </span><a id='lblCancel'>取消</a>
						</td>-->
					</tr>
					<tr>
						<td><span> </span><a id="lblRefrev" class="lbl" >參考版號</a></td>
						<td><input id="txtRefrev" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblIssuerev" class="lbl" >發行版號</a></td>
						<td><input id="txtIssuerev" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblAbrev" class="lbl" >異常版本</a></td>
						<td><input id="txtAbrev" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTrackingno" class="lbl" >快遞號碼</a></td>
						<td><input id="txtTrackingno" type="text" class="txt c1"/></td>
					</tr>
					<tr style="height: 1px;">
						<td colspan="8"><HR></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblChecker" class="lbl" >業務主管</a></td>
						<td><input id="txtChecker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCheckerdate" class="lbl" >核准日期</a></td>
						<td colspan="2">
							<input id="txtCheckerdate" type="text" class="txt c1" style="width: 60%;"/>
							<input id="btnCheckapv" type="button" value="核准" />
						</td>
						<td colspan="3" style="color: red;">※有變動時，核准取消，重送簽核。</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblApprove" class="lbl">開發經理</a></td>
						<td><input id="txtApprove" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblApprovedate" class="lbl">核准日期</a></td>
						<td  colspan="2">
							<input id="txtApprovedate" type="text" class="txt c1" style="width: 60%;"/>
							<input id="btnApproveapv" type="button" value="核准" />
							<!--<input id="chkIsproj" type="checkbox"/>
							<a id='lblIsproj_r'>核單</a>-->
						</td>
						<td><span> </span><a id="lblIssuedate" class="lbl" >發行日期</a></td>
						<td><input id="txtIssuedate" type="text" class="txt c1"/></td>
						<td><input id="btnApproveucx" type="button" value="發行" /></td>
					</tr>
					<tr style="height: 1px;">
						<td colspan="8"><HR></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCost" class="lbl" > </a></td>
						<td><input id="txtCost" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
					<tr style="display: none;">
						<td colspan="3"><div style="width:100%;" id="FileList"> </div></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:20px;"> </td>
					<td style="width:140px;"><a id='lblProcess_r_s'>流程</a></td>
					<td style="width:140px;"><a id='lblTgg_r_s'>廠商名稱</a></td>
					<td style="width:80px;"><a id='lblMount_r_s'>數量</a></td>
					<td style="width:40px;"><a id='lblUnit_r_s'>單位</a></td>
					<td style="width:150px;"><a id='lblPrice_r_s'>單價</a></td>
					<td style="width:100px;"><a id='lblMo_r_s'>金額</a></td>
					<td style="width:40px;"><a id='lblSalev_s'>外加稅</a></td>
					<td style="width:100px;"><a id='lblTxa_r_s'>稅金</a></td>
					<td style="width:100px;"><a id='lblW01_r_s'>總金額</a></td>
					<td style="width:150px;"><a id='lblMemo_r_s'>備註</a><BR><a id='lblBornproductno_r_s'>生產件號</a></td>
					<td style="width:40px;"><a id='lblEnda_r_s'>完工</a></td>
					<td style="width:90px;"><a id='lblDatea_r_s'>完工日</a></td>
					<td style="width:40px;"><a id='lblPay_r_s'>請款</a></td>
					<td style="width:150px;"><a id='lblOrdeno_r_s'>進貨單號</a></td>
					<td style="width:150px;"><a id='lblOth_r_s'>快遞帳號</a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProcess.*" type="text" class="txt c1"/>
					</td>
					<td>
						<input id="txtTggno.*" type="text" class="txt c1" style="width: 80%;"/>
						<input class="btn"  id="btnTggno.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtTgg.*" type="text" class="txt c1"/>
					</td>
					<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMo.*" type="text" class="txt c1 num"/></td>
					<td><input id="chkSale.*" type="checkbox" class="txt c1" /></td>
					<td><input id="txtW02.*" type="text" class="txt c1" style="text-align:right;"/></td>
					<td><input id="txtW01.*" type="text" class="txt c1" style="text-align:right; "/></td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="txtProductno.*" type="text" class="txt c1"/>
					</td>
					<td><input id="chkEnda.*" type="checkbox" class="txt c1" /></td>
					<td><input id="txtDatea.*" type="text" class="txt c1"/></td>
					<td><input id="chkCut.*" type="checkbox" class="txt c1"/></td>
					<td><input id="txtOrdeno.*" type="text" class="txt c1" style="color:blue;width: 90%;text-align:left;"/></td>
					<td><input id="txtOth.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt'>
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:20px;"> </td>
					<td style="width:300px; text-align: center;">ai格式</td>
					<td style="width:300px; text-align: center;">雷雕圖</td>
					<td style="width:300px; text-align: center;">完成品jpg</td>
					<td style="width:300px; text-align: center;">備註</td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<span style="float: left;"> </span>
						<input type="file" id="btnUcolor..*" class="btnFiles" value="選擇檔案"/>
						<input id="txtUcolor..*"  type="hidden"/>
						<a id="lblUcolor..*" class='lblDownload lbl btn'> </a>
						<BR>
						<input id="txtSize..*" type="text" class="txt c1"/>
					</td>
					<td>
						<span style="float: left;"> </span>
						<input type="file" id="btnScolor..*" class="btnFiles" value="選擇檔案"/>
						<input id="txtScolor..*"  type="hidden"/>
						<a id="lblScolor..*" class='lblDownload lbl btn'> </a>
						<BR>
						<input id="txtSpec..*" type="text" class="txt c1"/>
					</td>
					<td>
						<span style="float: left;"> </span>
						<input type="file" id="btnPrt..*" class="btnFiles" value="選擇檔案"/>
						<input id="txtPrt..*"  type="hidden"/>
						<a id="lblPrt..*" class='lblDownload lbl btn'> </a>
						<BR>
						<input id="txtPlace..*" type="text" class="txt c1"/>
					</td>
					<td>
						<input id="txtMemo..*" type="text" class="txt c1"/>
						<input id="txtMemo2..*" type="hidden" class="txt c1"/><!--放圖片文字使用-->
					</td>
				</tr>
			</table>
		</div>
		<iframe id="xdownload" style="display:none;"> </iframe>
	</body>
</html>