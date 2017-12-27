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
			var q_readonly = ['txtComp','txtWorker','txtWorker2','txtMo','txtVcceno','txtCost'//,'txtIpfrom','txtIpto'
			,'txtChecker','txtCheckerdate','txtApprove','txtApprovedate','txtIssuedate','textStyle','textSize','txtReviewdate','txtkind'];
			var q_readonlys = ['txtDate2', 'txtOrdeno', 'txtNo2','txtMo','txtW01','txtProcess'];
			var q_readonlyt = ['txtSpec','txtSize','txtPlace'];
			var bbmNum = [['txtMount',10,0,1],['txtCost',15,0,1],['txtMo',15,2,1],['txtPrice',15,3,1]];
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
			brwCount2 = 23;
			aPop = new Array(
				['txtCno', 'lblCno', 'quar', 'noa', 'txtCno', '']
				,['txtCustno', 'lblCust', 'cust', 'noa,nick,memo2', 'txtCustno,txtComp,txtMemo2', 'cust_b.aspx']
				,['txtM14', 'lblM14', 'cust', 'noa,nick', 'txtM14,txtM15', 'cust_b.aspx']
				//,['txtProductno_', '', 'ucx', 'noa,product', 'txtProductno_,txtProduct_', 'ucx_b.aspx']
				,['txtProductno', 'lblProduct', 'ucaucc', 'noa,product,spec,unit,style,size', 'txtProductno,txtProduct,txtSpec,txtUnit,textStyle,textSize', 'ucaucc_b.aspx']
				//,['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx']
				//106/12/19 改抓 uccgb
				,['txtProcessno', 'lblProcess', 'uccgb', 'noa,namea', 'txtProcessno,txtProcess', 'uccgb_b.aspx']
				,['txtTggno', 'lblTgg', 'part', 'noa,part', 'txtTggno,txtTgg', 'part_b.aspx']
				,['txtTggno_', 'btnTggno_', 'tgg', 'noa,comp', 'txtTggno_,txtTgg_', "tgg_b.aspx"]
				,['txtM1', '', 'adsize', 'noa,mon,memo1,memo2', '0txtM1', '']
				,['txtM4', '', 'adsss', 'noa,mon,memo1,memo2', '0txtM4', '']
				,['txtM2','','adly','noa,mon,memo,memo1,memo2','0txtM2','']
				,['txtM3','','adly','noa,mon,memo,memo1,memo2','0txtM3','']
				,['txtM8','','addime','noa,mon,memo,memo1,memo2','0txtM8','']
				,['txtM9','','adly','noa,mon,memo,memo1,memo2','0txtM9','']
				,['txtM10','','adly','noa,mon,memo,memo1,memo2','0txtM10','']
				,['txtM11','','adknife','noa,mon,memo,memo1,memo2','0txtM11','']
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
				q_gt('acomp', "where=^^ isnull(dbname,'')!='' and isnull(ip,'')!='' ^^", 0, 0, 0, "getipto");
				q_gt('acomp', "where=^^ isnull(dbname,'')!='' and isnull(ip,'')!='' ^^", 0, 0, 0, "getipfrom");
				
				q_cmbParse("cmbItype", ',ODM,OBM,OEM');
				q_cmbParse("cmbLevel", ',A,B,C,D,E,F,逾期');
				//天數差異	說明        	等級 	評分
				//0     	當天完成 	A   	100
				//-1    	隔天完成 	B   	90
				//-2    	隔二天完成	C   	80
				//-3    	隔三天完成	D   	70
				//-4    	隔四天完成	E   	60
				//-5    	隔五天完成	F   	50
				//-6    	超過5天以上	逾期 	40
				
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
						if(emp($('#txtChecker').val()) && !emp($('#cmbIpto').val())){
							var t_noa=$('#txtNoa').val();							
							var t_hostname=location.hostname;
							var t_proj=q_getPara('sys.project').toUpperCase();
							q_func('qtxt.query.cub_apv', 'cub.txt,cub_apv,' + encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI('checker')+';'+encodeURI(t_hostname)+';'+encodeURI(t_proj)+';'+encodeURI('0'),r_accy,1);
		                	var as = _q_appendData("tmp0", "", true, true);
		                	if (as[0] != undefined) {
		                		$('#txtChecker').val(as[0].checker);
		                		$('#txtCheckerdate').val(as[0].checkerdate);
		                		$('#txtUindate').val(as[0].uindate);
		                		abbm[q_recno]['checker'] = as[0].checker;
                            	abbm[q_recno]['checkerdate'] = as[0].checkerdate;
                            	abbm[q_recno]['uindate'] = as[0].uindate;
		                	}
						}else{
							if(!emp($('#txtChecker').val()))
								alert('已被【'+$('#txtChecker').val()+'】核准!!');
							else
								alert('【Ipto】禁止空白!!');
						}
					}
				});
				
				$('#btnReviewapv').click(function() {
					if(!(q_cur==1 || q_cur==2) && !emp($('#txtNoa').val())){
						if(!emp($('#txtChecker').val()) && !emp($('#txtCheckerdate').val()) && emp($('#txtReviewdate').val())){
							var t_noa=$('#txtNoa').val();							
							var t_hostname=location.hostname;
							var t_proj=q_getPara('sys.project').toUpperCase();
							q_func('qtxt.query.cub_apv', 'cub.txt,cub_apv,' + encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI('review')+';'+encodeURI(t_hostname)+';'+encodeURI(t_proj)+';'+encodeURI('0'),r_accy,1);
			                var as = _q_appendData("tmp0", "", true, true);
			                if (as[0] != undefined) {
			                	$('#txtReviewdate').val(as[0].reviewdate);
			                	abbm[q_recno]['reviewdate'] = as[0].reviewdate;
			                }
						}else{
							if(!emp($('#txtReviewdate').val())){
								alert('已被覆核!!');
							}else{
								alert('尚未被【核准】禁止【覆核】!!');
							}
						}
					}
				});
				
				$('#btnApproveapv').click(function() {
					//執行txt
					if(!(q_cur==1 || q_cur==2) && !emp($('#txtNoa').val())){
						if(!emp($('#txtChecker').val()) && !emp($('#txtReviewdate').val())){
							var t_noa=$('#txtNoa').val();
							var t_hostname=location.hostname;
							var t_proj=q_getPara('sys.project').toUpperCase();
							//t_noa,r_userno,r_name
							if(q_getPara('sys.project').toUpperCase()=="AD" || q_getPara('sys.project').toUpperCase()=="JO"){
								//106/12/12 暫不判斷
								//if(r_userno=='8001'){
									q_func('qtxt.query.cub_apv', 'cub.txt,cub_apv,' + encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI('approve')+';'+encodeURI(t_hostname)+';'+encodeURI(t_proj)+';'+encodeURI('0'),r_accy,1);
				                	var as = _q_appendData("tmp0", "", true, true);
				                	if (as[0] != undefined) {
				                		$('#txtApprove').val(as[0].approve);
				                		$('#txtApprovedate').val(as[0].approvedate);
				                		abbm[q_recno]['approve'] = as[0].approve;
		                            	abbm[q_recno]['approvedate'] = as[0].approvedate;
				                	}
								//}else{
								//	alert('需由李經理核准!!');
								//}
							}else{
								q_func('qtxt.query.cub_apv', 'cub.txt,cub_apv,' + encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI('approve')+';'+encodeURI(t_hostname)+';'+encodeURI(t_proj)+';'+encodeURI('0'),r_accy,1);
			                	var as = _q_appendData("tmp0", "", true, true);
			                	if (as[0] != undefined) {
			                		$('#txtApprove').val(as[0].approve);
				                	$('#txtApprovedate').val(as[0].approvedate);
				                	abbm[q_recno]['approve'] = as[0].approve;
		                            abbm[q_recno]['approvedate'] = as[0].approvedate;
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
								var t_hostname=location.hostname;
								var t_proj=q_getPara('sys.project').toUpperCase();
								q_func('qtxt.query.cub_apv', 'cub.txt,cub_apv,' + encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI('issue')+';'+encodeURI(t_hostname)+';'+encodeURI(t_proj)+';'+encodeURI('0'),r_accy,1);
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
				
				$('#bbtimg').click(function() {
					var image = new Image();
			        image.src = document.getElementById("bbtimg").src;
			
			        var w = window.open("", "_blank", 'directories=no,location=no,menubar=no,resizable=1,scrollbars=1,status=0,toolbar=1');
			        w.document.write(image.outerHTML);
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
							t_item +=(t_item.length > 0 ? ',' : '') + as[i].noa + '@'+ as[i].nick;
						}
						
						q_cmbParse("cmbIpto", t_item);
						if(abbm[q_recno]){
							$('#cmbIpto').val(abbm[q_recno].ipto);
							bbmdisabled();
							bbsdisabled();
						}
						break;
					case 'getipfrom':
						var as = _q_appendData("acomp", "", true);
                        var t_item ="@";
                        for (var i = 0; i < as.length; i++) {
                        	if(as[i].dbname.toUpperCase()==q_db.toUpperCase() && z_cno.length==0){
                        		z_cno=as[i].noa;
                        	}
							t_item +=(t_item.length > 0 ? ',' : '') + as[i].noa + '@'+ as[i].nick;
						}
						
						q_cmbParse("cmbIpfrom", t_item);
						if(abbm[q_recno]){
							$('#cmbIpfrom').val(abbm[q_recno].ipfrom);
							bbmdisabled();
							bbsdisabled();
						}
						break;
					case 'custprices':
						var as = _q_appendData("custprices", "", true);
						if (as[0] != undefined) {
							$('#txtPrice').val(as[0].cost);
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
                    
                    
                    //已被核可過的樣品單進行更新
                    var t_noa=$('#txtNoa').val();							
					var t_hostname=location.hostname;
					var t_proj=q_getPara('sys.project').toUpperCase();
					
					//修改不進行更新 只有在覆核和開發經理核准才更新
					/*if($('#cmbIpfrom').val().toUpperCase()==z_cno.toUpperCase() && !emp($('#txtChecker').val())){
						q_func('qtxt.query.cub_apv', 'cub.txt,cub_apv,' + encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI('checker')+';'+encodeURI(t_hostname)+';'+encodeURI(t_proj)+';'+encodeURI('1'),r_accy,1);
					}*/
					
					/*if($('#cmbIpto').val().toUpperCase()==z_cno.toUpperCase() && !emp($('#txtApprove').val())){
						q_func('qtxt.query.cub_apv', 'cub.txt,cub_apv,' + encodeURI(r_accy)+';'+encodeURI(t_noa)+';'+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI('approve')+';'+encodeURI(t_hostname)+';'+encodeURI(t_proj)+';'+encodeURI('1'),r_accy,1);
					}*/
					
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
					case 'txtProductno':
						if(emp($('#txtProductno').val()) && emp($('#txtCustno').val())){
							var t_where="custno ='"+$('#txtCustno').val()+"' and productno='"+$('#txtProductno').val()+"'"; 
							t_where+=" and noa=(select top 1 noa from custprices where custno ='"+$('#txtCustno').val()+"' and productno='"+$('#txtProductno').val()+"' order by bdate desc,noa desc,noq desc)";
							t_where="where=^^"+t_where+"^^";
							q_gt('custprices', t_where, 0, 0, 0, "custprices");
						}
						break;
					case 'txtCno':
						if(!emp($('#txtCno').val())){
							var t_where = "where=^^ noa ='"+$('#txtCno').val()+"' ^^";
							q_gt('quar', t_where, 0, 0, 0, "getquar",r_accy,1);
							var as = _q_appendData("quar", "", true);
							if (as[0] != undefined) {
								$('#txtM13').val(as[0].payterms);
								if(emp($('#txtCustno').val())){
									$('#txtCustno').val(as[0].custno);
									$('#txtComp').val(as[0].comp);
								}
							}
						}
					
						if(!emp($('#txtCustno').val())){
							var t_where = "where=^^ noa ='"+$('#txtCustno').val()+"' ^^";
							q_gt('cust', t_where, 0, 0, 0, "getmemo2",r_accy,1);
							var as = _q_appendData("cust", "", true);
                    		if (as[0] != undefined) {
                    			$('#txtMemo2').val(as[0].memo2);
                    		}
                    		$('#txtM13').val($('#txtCustno').val());
                    		$('#txtM14').val($('#txtCustno').val());
                    		$('#txtM15').val($('#txtComp').val());
						}
						break;
					case 'txtCustno':
						if(!emp($('#txtCustno').val())){
                    		$('#txtM14').val($('#txtCustno').val());
                    		$('#txtM15').val($('#txtComp').val());
						}
						break;
					default:
						break;
				}			
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
					
				q_box('cub_r_s.aspx', q_name + '_s', "500px", "750px", q_getMsg("popSeek"));
			}

			function btnIns() {
                _btnIns();
                
                if(q_cur==1){
					$('#txtWorker').val(r_name);
					
					q_gt('sss', "where=^^noa='"+r_userno+"'^^" , 0, 0, 0, "getsalesgroup",r_accy,1);
					var as = _q_appendData("sss", "", true);
                    if (as[0] != undefined) {
						//$('#txtkind').val(as[0].salesgroup);
						//106/12/15 改成抓部門
						$('#txtkind').val(as[0].partno);
					}
				}
                
                refreshBbm();
                //取消變色
                $("#tbbm input[type='text']").css('color','black')
                $("#tbbm textarea").css('color','black');
                
                //清除圖片
                $('#bbtimg').attr('src','');
                
				$('#txtNoa').val('');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
				$('#txtMount').val(1);
				$('#cmbIpfrom').val(z_cno);
				
				if(emp($('#txtProcess_0').val())){//自動產生流程
					var as =[];
					/*as.push({process:'開銅膜/模具'});
					as.push({process:'樣品照片'});
					as.push({process:'客戶確認'});
					as.push({process:'寄送樣品'});
					as.push({process:'客戶收樣品'});
					as.push({process:'轉生產件號'});
					as.push({process:'檢查生產參數'});
					as.push({process:'越南會計報價日'});//as.push({process:'會計詢價'});
					as.push({process:'PF計算 for 會計'});//as.push({process:'成本計算'});
					as.push({process:'回覆'});
					as.push({process:'報價'});
					as.push({process:'客戶銷售採購價格表'});
					as.push({process:'製造廠銷售價格表'});*/
					
					as.push({process:'模具需求申請單'});
					as.push({process:'銅模需求申請單'});
					as.push({process:'網版需求申請單'});
					as.push({process:'委外加工製造通知單'});
					as.push({process:'樣品需求單'});
					as.push({process:'開發部傳鐳雕圖'});
					as.push({process:'銷售單位傳鐳雕圖給客戶'});
					as.push({process:'客戶確認鐳雕圖日期'});
					as.push({process:'開發部傳樣品照片'});
					as.push({process:'銷售單位傳樣品照片給客戶'});
					as.push({process:'開發部寄出樣品日期'});
					as.push({process:'寄送樣品-銷售單位寄送樣品給客戶'});
					as.push({process:'客戶確認樣品日期'});
					as.push({process:'產生生產件號並發行'});
					as.push({process:'檢查生產基本資料'});
					as.push({process:'越南會計報價日'});
					as.push({process:'PF計算 for 會計'});
					as.push({process:'銷售訂單追蹤'});
					as.push({process:'報價單追蹤'});
					as.push({process:'銷售單位客戶銷售_採購價格表'});
					as.push({process:'製造廠維護銷售價格表'});
					q_gridAddRow(bbsHtm, 'tbbs', 'txtProcess', as.length, as, 'process', '', '');
				}
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
					
				if(q_getPara('sys.project').toUpperCase()=="AD" || q_getPara('sys.project').toUpperCase()=="JO"){
					if($('#cmbIpfrom').val().toUpperCase()==z_cno.toUpperCase() && !emp($('#txtReviewdate').val())){
						alert('已覆核禁止修改!!');
						return;
					}
				}
					
				if(!emp($('#txtIssuedate').val())){
					alert('開發經理已發行禁止修改!!');
					return;
				}
				_btnModi();
				refreshBbm();
				$('#txtDatea').focus();
				//if(emp($('#cmbIpfrom').val()))
				//	$('#cmbIpfrom').val(z_cno);
				
				//只取消簽核人員姓名，保留時間
				//106/11/14 不取消姓名 因為只會變動表身內容
				/*if($('#cmbIpfrom').val().toUpperCase()==z_cno.toUpperCase())
					$('#txtChecker').val('');
				else{
					$('#txtApprove').val('');
				}*/
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
				
				if($('#cmbIpfrom').val()==$('#cmbIpto').val() && !emp($('#cmbIpfrom').val()) && !emp($('#cmbIpto').val())){
					alert('【Ipto】禁止與【Ipfrom】相同!!');
				}
				
				sum();
				if(q_cur==1){
					$('#txtWorker').val(r_name);
					
					q_gt('sss', "where=^^noa='"+r_userno+"'^^" , 0, 0, 0, "getsalesgroup",r_accy,1);
					var as = _q_appendData("sss", "", true);
                    if (as[0] != undefined) {
						//$('#txtkind').val(as[0].salesgroup);
						//106/12/15 改成抓部門
						$('#txtkind').val(as[0].partno);
					}
				}else{
					$('#txtWorker2').val(r_name);
				}

				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if(q_cur==2){
					wrServer(t_noa);
				}else if (t_noa.length == 0){
					//105/05/03 改成S開頭
					q_gtnoa(q_name, replaceAll('S' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					//q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cub') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				}else{
					//106/11/09 noa 會自己打 存檔後後面自動加序號
					/*wrServer(t_noa);*/
					q_gtnoa(q_name, replaceAll(t_noa, '/', ''));
				}
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
				refreshBbm();
				bbmdisabled();
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
				
				//抓取尺寸/車種
				if(!emp($('#txtProductno').val())){
					var t_pno=$('#txtProductno').val();
					q_gt('uca', "where=^^noa='"+t_pno+"'^^" , 0, 0, 0, "",r_accy,1);
					var as = _q_appendData("uca", "", true);
					if (as[0] != undefined) {
						$('#textSize').val(as[0].size);
						$('#textStyle').val(as[0].style);
					}
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					//106/11/24
					$('#textbbtComp').attr('disabled', 'disabled');
					$('#textbbtMemo').attr('disabled', 'disabled');
					$('#btnbbtUcolor').attr('disabled', 'disabled');
					$('#btnbbtScolor').attr('disabled', 'disabled');
					$('#btnbbtPrt').attr('disabled', 'disabled');
				}else{
					
				}
				bbmdisabled();
				$('#cmbIpfrom').attr('disabled', 'disabled');
				bbsdisabled();
			}
			
			function bbmdisabled() {
				if(!(q_cur==1 || q_cur==2) && !emp($('#cmbIpfrom').val()) && $('#cmbIpfrom').val()!=null  && $('#cmbIpto').val()!=null){
					if($('#cmbIpfrom').val().toUpperCase()==z_cno.toUpperCase()){
						$('#btnCheckapv').removeAttr("disabled");
						$('#btnReviewapv').removeAttr("disabled");
					}else{
						$('#btnCheckapv').attr('disabled', 'disabled');
						$('#btnReviewapv').attr('disabled', 'disabled');
					}
					if($('#cmbIpto').val().toUpperCase()==z_cno.toUpperCase()){
						$('#btnApproveapv').removeAttr("disabled");
						$('#btnApproveucx').removeAttr("disabled");
					}else{
						$('#btnApproveapv').attr('disabled', 'disabled');
						$('#btnApproveucx').attr('disabled', 'disabled');
					}
				}else{
					$('#btnCheckapv').attr('disabled', 'disabled');
					$('#btnReviewapv').attr('disabled', 'disabled');
					$('#btnApproveapv').attr('disabled', 'disabled');
					$('#btnApproveucx').attr('disabled', 'disabled');
				}
				if($('#cmbIpfrom').val()!=null  && $('#cmbIpto').val()!=null){
					//106/11/09當業務已核准過(時間不會清除) BBM禁止修改
					//106/12/12 調整 針對ST2
					if(!emp($('#txtCheckerdate').val()) && $('#cmbIpfrom').val().toUpperCase()==z_cno.toUpperCase()){
						for (var i=0;i<fbbm.length;i++){
							$('#'+fbbm[i]).attr('disabled', 'disabled');
						}
					}
					
					if(emp($('#txtApprovedate').val()) && $('#cmbIpto').val().toUpperCase()==z_cno.toUpperCase()){
						for (var i=0;i<fbbm.length;i++){
							if( fbbm[i]=='txtDatea' || fbbm[i]=='txtCno' || fbbm[i]=='txtCustno' || fbbm[i]=='txtUcxno2'
								|| fbbm[i]=='txtMount' || fbbm[i]=='txtPrice' || fbbm[i]=='txtMo' || fbbm[i]=='txtOrdeno'
								|| fbbm[i]=='cmbIpfrom' || fbbm[i]=='cmbIpto' || fbbm[i]=='txtM14' || fbbm[i]=='txtM15'
								|| fbbm[i]=='txtRefrev' || fbbm[i]=='txtIssuerev' || fbbm[i]=='txtAbrev' || fbbm[i]=='txtTrackingno'
							)
								$('#'+fbbm[i]).attr('disabled', 'disabled');
						}
					}
					
					if(!emp($('#txtApprovedate').val()) && $('#cmbIpto').val().toUpperCase()==z_cno.toUpperCase()){
						for (var i=0;i<fbbm.length;i++){
							if(fbbm[i]!='txtUcxno')
								$('#'+fbbm[i]).attr('disabled', 'disabled');
						}
					}
				}
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
				bbmdisabled();
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
				//106/11/24 bbt改為一行
				if($('#lblUcolor__0').is(':hidden')){
					$('#lablUcolor').text('').hide();
				}else{
					$('#lablUcolor').text('下載').show();
				}
				if($('#lblScolor__0').is(':hidden')){
					$('#lablScolor').text('').hide();
				}else{
					$('#lablScolor').text('下載').show();
				}
				if($('#lblPrt__0').is(':hidden')){
					$('#lablPrt').text('').hide();
				}else{
					$('#lablPrt').text('下載').show();
				}
				
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
				
				//106/12/15 會上傳多個檔案 重新開放使用bbt顯示
				/*for (var i = 1; i < q_bbtCount; i++) {
					$('#bbttr__'+i).css('display','none');
				}*/
				
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
						//106/11/24bbt只改用一行
						if(txtOrgName[0]=='txtScolor'){
							$('#txtSpec__'+txtOrgName[1]).val(file.name);
							$('#textbbtSpec').val(file.name);
						}
						if(txtOrgName[0]=='txtUcolor'){
							$('#txtSize__'+txtOrgName[1]).val(file.name);
							$('#textbbtSize').val(file.name);
						}
						if(txtOrgName[0]=='txtPrt'){
							$('#txtPlace__'+txtOrgName[1]).val(file.name);
							$('#textbbtPlace').val(file.name);
						}
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
							
							if(fr.result.length>0 && ttxtName=='txtUcolor__0'){//106/12/13 該為銷售單位的圖 原完成圖
								$('#txtMemo2__0').val(fr.result);
								$('#bbtimg').attr('src',$('#txtMemo2__0').val());
								t_zoomimg=true;
								zoomimg();
							}
							
						};
					}
					ShowDownlbl();
				});
				ShowDownlbl();
				
				//另存暫存bbt---------------------------------------------
				if(abbtNow[0]){
					$('#textbbtUcolor').val(abbtNow[0].ucolor);
					$('#textbbtSize').val(abbtNow[0].size);
					$('#textbbtScolor').val(abbtNow[0].scolor);
					$('#textbbtSpec').val(abbtNow[0].spec);
					$('#textbbtComp').val(abbtNow[0].comp);
					$('#textbbtPrt').val(abbtNow[0].prt);
					$('#textbbtPlace').val(abbtNow[0].place);
					$('#textbbtMemo').val(abbtNow[0].memo);
				}else{
					$('#textbbtUcolor').val('');
					$('#textbbtSize').val('');
					$('#textbbtScolor').val('');
					$('#textbbtSpec').val('');
					$('#textbbtComp').val('');
					$('#textbbtPrt').val('');
					$('#textbbtPlace').val('');
					$('#textbbtMemo').val('');
				}
				$('#textbbtSize').attr('disabled', 'disabled');
				$('#textbbtSpec').attr('disabled', 'disabled');
				$('#textbbtPlace').attr('disabled', 'disabled');
				if(q_cur==1 || q_cur==2){
					$('#textbbtComp').removeAttr("disabled");
					$('#textbbtMemo').removeAttr("disabled");
					$('#btnbbtUcolor').removeAttr("disabled");
					$('#btnbbtScolor').removeAttr("disabled");
					$('#btnbbtPrt').removeAttr("disabled");
				}else{
					$('#textbbtComp').attr('disabled', 'disabled');
					$('#textbbtMemo').attr('disabled', 'disabled');
					$('#btnbbtUcolor').attr('disabled', 'disabled');
					$('#btnbbtScolor').attr('disabled', 'disabled');
					$('#btnbbtPrt').attr('disabled', 'disabled');
				}
				
				$('#btnbbtUcolor').unbind('click');
				$('#btnbbtUcolor').click(function() {
					$('#btnUcolor__0').click();
				});
				$('#btnbbtScolor').unbind('click');
				$('#btnbbtScolor').click(function() {
					$('#btnScolor__0').click();
					$('#chkEnda_7').prop('checked',true);
					if($('#chkEnda_7').prop('checked') && emp($('#txtDatea_7').val())){
						$('#txtDatea_7').val(q_date());
					}
				});
				$('#btnbbtPrt').unbind('click');
				$('#btnbbtPrt').click(function() {
					$('#btnPrt__0').click();
					$('#chkEnda_9').prop('checked',true);
					if($('#chkEnda_9').prop('checked') && emp($('#txtDatea_9').val())){
						$('#txtDatea_9').val(q_date());
					}
				});
				$('#lablUcolor').unbind('click');
				$('#lablUcolor').click(function() {
					$('#lblUcolor__0').click();
				});
				$('#lablScolor').unbind('click');
				$('#lablScolor').click(function() {
					$('#lblScolor__0').click();
				});
				$('#lablPrt').unbind('click');
				$('#lablPrt').click(function() {
					$('#lblPrt__0').click();
				});
				$('#textbbtComp').unbind('blur');
				$('#textbbtComp').blur(function() {
					$('#txtComp__0').val($(this).val())
				});
				$('#textbbtMemo').unbind('blur');
				$('#textbbtMemo').blur(function() {
					$('#txtMemo__0').val($(this).val())
				});
				
				//另存暫存bbt---------------------------------------------
			}
			
			var t_zoomimg=false;
			function zoomimg() {
				//106/11/8 縮放
				var image = document.getElementById('bbtimg');
				var c = document.getElementById("canvas");
				image.onload = function() {
					if(t_zoomimg){
						$('#bbtimg').hide();
						$('#bbtimg').css('width','')
						$('#bbtimg').css('height','')
						var imgwidth = $('#bbtimg').width();
			            var imgheight = $('#bbtimg').height();
			            var t_widh=240;//106/12/19 圖片移到最右邊 故圖片寬度固定 $('#dview').width();
			            var x_height=500;//106/12/19 圖片移到最右邊 故圖片高度固定 $('.dbbs').offset().top-$('#dview').height()-35;
			            var t_height=imgheight*(dec(t_widh)/dec(imgwidth));
			            if(t_height>x_height){
			            	t_height=x_height;
			            	t_widh=imgwidth*(dec(t_height)/dec(imgheight));
			            }
			            
			            $('#canvas').width(t_widh).height(t_height);
						c.width = t_widh;
						c.height = t_height;
						$("#canvas")[0].getContext("2d").drawImage($('#bbtimg')[0],0,0,imgwidth,imgheight,0,0,t_widh,t_height);
						$('#txtMemo2__0').val(c.toDataURL());
						
						$('#bbtimg').show();
						t_zoomimg=false;
						showbbtimg();
					}	
				}
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
                
				if(!emp($('#txtReviewdate').val())){
					alert('已覆核禁止刪除!!');
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
						
						//106/10/09 鎖定固定流程
						if((q_getPara('sys.project').toUpperCase()=="AD" || q_getPara('sys.project').toUpperCase()=="JO")){
							if($('#cmbIpfrom').val().toUpperCase()==z_cno.toUpperCase()){ //ST4
								if((i==1 || i==2 || i==3 || i==4 || i==5 || i==8 || i==10 || i==13 || i==14 || i==15 || i==20)){ //i==5 || i==6 || i==7 || i==12
									for (var j=0;j<fbbs.length;j++){
										$('#'+fbbs[j]+'_'+i).attr('disabled', 'disabled');
									}
									$('#btnTggno_'+i).attr('disabled', 'disabled');
								}
							}
							if($('#cmbIpto').val().toUpperCase()==z_cno.toUpperCase()){ //ST2
								if(!(i==1 || i==2 || i==3 || i==4 || i==5 || i==8 || i==10 || i==13 || i==14 || i==15 || i==20)){
									for (var j=0;j<fbbs.length;j++){
										$('#'+fbbs[j]+'_'+i).attr('disabled', 'disabled');
									}
									$('#btnTggno_'+i).attr('disabled', 'disabled');
								}
							}
						}
					}
				}
				
				if((q_getPara('sys.project').toUpperCase()=="AD" || q_getPara('sys.project').toUpperCase()=="JO")){
					if($('#cmbIpfrom').val()!=null  && $('#cmbIpto').val()!=null){
						for (var i = 0; i < q_bbsCount; i++) {
							if($('#cmbIpfrom').val().toUpperCase()==z_cno.toUpperCase()){ //ST4
								if((i==1 || i==2 || i==3 || i==4 || i==5 || i==8 || i==10 || i==13 || i==14 || i==15 || i==20)){
									$('#trcolor_'+i).css('background','#cad3ff');
								}else{
									$('#trcolor_'+i).css('background','antiquewhite');
								}
							}
								
							if($('#cmbIpto').val().toUpperCase()==z_cno.toUpperCase()){ //ST2
								if(!(i==1 || i==2 || i==3 || i==4 || i==5 || i==8 || i==10 || i==13 || i==14 || i==15 || i==20)){
									$('#trcolor_'+i).css('background','#cad3ff');
								}else{
									$('#trcolor_'+i).css('background','antiquewhite');
								}
							}
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
			
			function refreshBbm() {
                if (q_cur == 1) {
                    $('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
                } else {
                    $('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
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
				width: 360px;
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
				width: 1200px;
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
				width: 1560px;
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
				width: 1560px;
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
            
            #tmptbbt tr td {
				text-align: center;
				border: 2px pink double;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1950px;">
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
						<td style="width: 100px;"> </td>
						<td style="width: 195px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 195px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 195px;"> </td>
						<td style="width: 100px;"> </td>
						<td style="width: 195px;"> </td>
						<td style="width: 5px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCno_r" class="lbl">Quote#</a></td>
						<td><input id="txtCno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa_r" class="lbl">樣品單號</a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td style="display: none;"><span> </span><a id="lblStatus" class="lbl" > </a>完成狀態</td>
						<td style="display: none;"><input id="txtStatus" type="hidden" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust_r" class="lbl">客戶</a></td>
						<td><input id="txtCustno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblUcxno2" class="lbl" >貿易銷售件號</a></td>
						<td colspan="3"><input id="txtUcxno2" type="text" class="txt c1"/></td>					
					</tr>
					<tr>
						<td><span> </span><a id="lblMount_r" class="lbl" >P/0數量</a></td>
						<td><input id="txtMount" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblPrice" class="lbl" > </a></td>
						<td><input id="txtPrice" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblMoney_r" class="lbl" >P/0金額</a></td>
						<td><input id="txtMo" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblOrdeno" class="lbl" >P/0</a></td>
						<td><input id="txtOrdeno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct_r" class="lbl" >生產件號</a></td>
						<td colspan="2"><input id="txtProductno" type="text" class="txt c1"/></td>
						<td colspan="5">
							<textarea id="txtProduct" rows='5' cols='10' style="width:99%; height: 35px;"> </textarea>
							<!--<input id="txtProduct" type="text" class="txt c1"/>-->
						</td>
						<!--<td><span> </span><a id="lblNo2" class="lbl" >P/0序</a></td>
						<td><input id="txtNo2" type="text" class="txt c1"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id="lblProcess_r" class="lbl">產品線</a></td>
						<td><input id="txtProcessno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtProcess" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTggno_r" class="lbl">部門組別</a></td>
						<td><input id="txtTggno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtTgg" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSpec_r" class="lbl" >型號</a></td>
						<td><input id="txtSpec" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblUnit_r" class="lbl" >單位</a></td>
						<td><input id="txtUnit" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblItype_r" class="lbl" >銷售類別</a></td>
						<td><select id="cmbItype" class="txt c1"> </select></td>
						<td><span> </span><a id="lblLevel" class="lbl" >服務等級</a></td>
						<td>
							<select id="cmbLevel" class="txt c1"> </select>
							<!--<input id="txtLevel" type="text" class="txt c1" />-->
						</td>	
					</tr>
					<tr>
						<td><span> </span><a id="lblStyle_r" class="lbl" >車種</a></td>
						<td><input id="textStyle" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblSize_r" class="lbl" >尺寸</a></td>
						<td><input id="textSize" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblM13_r" class="lbl" >報價條件</a></td>
						<td><input id="txtM13" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblM1" class="lbl" >車縫</a></td>
						<td><input id="txtM1" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblM4" class="lbl" >護片</a></td>
						<td><input id="txtM4" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblBdate" class="lbl" > </a></td>
						<td><input id="txtBdate" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblUindate" class="lbl" >應完工日</a></td>
						<td><input id="txtUindate" type="text" class="txt c1" /></td>
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
						<td><span> </span><a id="lblM7" class="lbl" >中束</a></td>
						<td colspan="2"><input id="txtM7" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblM8" class="lbl" >中束電鍍</a></td>
						<td colspan="2"><input id="txtM8" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblM5" class="lbl" >高週波</a></td>
						<td><input id="txtM5" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblM11" class="lbl" >大弓</a></td>
						<td colspan="2"><input id="txtM11" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblM12" class="lbl" >大弓電鍍</a></td>
						<td colspan="2"><input id="txtM12" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo2_r" class="lbl" >品質要求</a></td>
						<td colspan="5"><input id="txtMemo2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="7">
							<!--<input id="txtMemo" type="text" class="txt c1"/>-->
							<textarea id="txtMemo" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea>
						</td>
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
						<td><span> </span><a id="lblM14_r" class="lbl" >銷售客戶</a></td>
						<td><input id="txtM14" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtM15" type="text" class="txt c1"/></td>
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
					<tr style="height: 25px;">
						<td><span> </span><a id="lblUcxno" class="lbl" >生產發行件號</a></td>
						<td><input id="txtUcxno" type="text" class="txt c1"/></td>
						<td> </td>
						<td colspan="3" style="color: red;">※有變動時，核准取消，重送簽核。</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblChecker" class="lbl" >業務主管</a></td>
						<td><input id="txtChecker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCheckerdate" class="lbl" >核准日期</a></td>
						<td colspan="2">
							<input id="txtCheckerdate" type="text" class="txt c1" style="width: 60%;"/>
							<input id="btnCheckapv" type="button" value="核准" />
						</td>
						<td><span> </span><a id="lblReviewdate" class="lbl" >覆核日期</a></td>
						<td><input id="txtReviewdate" type="text" class="txt c1"/></td>
						<td><input id="btnReviewapv" type="button" value="覆核" /></td>
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
						<td><span> </span><a id="lblWorker_r" class="lbl" >製單者</a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblGroup_r" class="lbl" >製單組別</a></td>
						<td><input id="txtkind" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
					<tr style="display: none;">
						<td colspan="3"><div style="width:100%;" id="FileList"> </div></td>
						<canvas id="canvas" style="display:none"> </canvas>
					</tr>
				</table>
			</div>
			<div class="bbtimg" style="float:left;"><img id="bbtimg" style="MAX-WIDTH: fit-content;MAX-HEIGHT: fit-content;"></div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;display: none;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:20px;"> </td>
					<td style="width:210px;"><a id='lblProcess_r_s'>流程</a></td>
					<td style="width:140px;"><a id='lblTgg_r_s'>廠商名稱</a></td>
					<td style="width:80px;"><a id='lblMount_r_s'>數量</a></td>
					<td style="width:40px;"><a id='lblUnit_r_s'>單位</a></td>
					<td style="width:80px;"><a id='lblPrice_r_s'>單價</a></td>
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
				<tr id="trcolor.*" style='background:#cad3ff;'>
					<td align="center" style="display: none;">
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
					<td style="width:300px; text-align: center;">銷售單位</td><!--ai格式-->
					<td style="width:300px; text-align: center;">開發部</td><!--雷雕圖-->
					<td style="width:300px; text-align: center;">備註</td>
					<td style="width:300px; text-align: center;">樣品完成圖</td><!--完成品jpg-->
					<td style="width:300px; text-align: center;">備註</td>
				</tr>
				<tr id="bbttr..*" >
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
					<td><input id="txtComp..*" type="text" class="txt c1"/></td>
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
		<div id="tmpdbbt" style="width:1260px;display: none;">
			<table id="tmptbbt" style="background: pink;margin: 0;padding: 2px;border: 2px pink double;border-collapse: collapse;color: blue;">
				<tr class="head" style="color:white; background:#003366;height: 35px;">
					<td style="width:300px; text-align: center;">銷售單位</td><!--ai格式-->
					<td style="width:300px; text-align: center;">開發部</td><!--雷雕圖-->
					<td style="width:300px; text-align: center;">備註</td>
				</tr>
				<tr style="height: 35px;">
					<td>
						<input type="button" id="btnbbtUcolor" value="選擇檔案"/>
						<input id="textbbtUcolor"  type="hidden"/>
						<a id="lablUcolor" class='lbl' style="color: #4297D7;font-weight: bolder;cursor: pointer;"> </a>
						<BR>
						<input id="textbbtSize" type="text" class="txt c1"/>
					</td>
					<td>
						<input type="button" id="btnbbtScolor" value="選擇檔案"/>
						<input id="textbbtScolor"  type="hidden"/>
						<a id="lablScolor" class='lbl' style="color: #4297D7;font-weight: bolder;cursor: pointer;"> </a>
						<BR>
						<input id="textbbtSpec" type="text" class="txt c1"/>
					</td>
					<td><input id="textbbtComp" type="text" class="txt c1"/></td>
				</tr>
				<tr class="head" style="color:white; background:#003366;height: 35px;">
					<td style="width:600px; text-align: center;" colspan="2">樣品完成圖</td><!--完成品jpg-->
					<td style="width:300px; text-align: center;">備註</td>
				</tr>
				<tr style="height: 35px;">
					<td colspan="2">
						<input type="button" id="btnbbtPrt" value="選擇檔案"/>
						<input id="textbbtPrt"  type="hidden"/>
						<a id="lablPrt" class='lbl' style="color: #4297D7;font-weight: bolder;cursor: pointer;"> </a>
						<BR>
						<input id="textbbtPlace" type="text" class="txt c1"/>
					</td>
					<td><input id="textbbtMemo" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		
		<iframe id="xdownload" style="display:none;"> </iframe>
	</body>
</html>