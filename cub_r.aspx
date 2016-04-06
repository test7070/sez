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
			var q_readonly = ['txtNoa','txtComp','txtWorker','txtWorker2','txtMo','txtVcceno'];
			var q_readonlys = ['txtDate2', 'txtOrdeno', 'txtNo2','txtMo','txtW01'];
			var q_readonlyt = [];
			var bbmNum = [['txtMount',10,0,1]];
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
			brwCount2 = 8;
			aPop = new Array(
				['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx']
				,['txtProductno_', '', 'ucx', 'noa,product', 'txtProductno_,txtProduct_', 'ucx_b.aspx']
				,['txtProductno', 'lblProduct', 'ucc', 'noa,product,spec,unit', 'txtProductno,txtProduct,txtSpec,txtUnit', 'ucc_b.aspx']
				,['txtTggno_', '', 'tgg', 'noa,comp', 'txtTggno_,txtTgg_', ""]
			);

			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
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
				
			}

			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd]];
				bbsMask = [['txtDate2', r_picd], ['txtDatea', r_picd]];
				
				bbmNum = [['txtMount',10,q_getPara('vcc.mountPrecision'),1],['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1]
				,['txtMo', 15, 0, 1]];
				bbsNum = [['txtMount', 15, q_getPara('vcc.mountPrecision'), 1],['txtPrice', 15, q_getPara('vcc.pricePrecision'), 1]
				,['txtMo', 15, 0, 1],['txtW02', 15, 0, 1],['txtW01', 15, 0, 1]];
				bbtNum = [['txtMount', 15, q_getPara('vcc.mountPrecision'), 1]];
				q_mask(bbmMask);
				
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
				
				$('#chkIsproj').change(function() {
					bbsdisabled();
				});
				
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
			}

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
                        	q_func('vcc_post.post', ass[i].accy + ',' + ass[i].noa + ',0');
                            sleep(100);
                        }
                        
                        //執行txt
                        q_func('qtxt.query.cub_r_0', 'cub.txt,cub_r,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val()) + ';0;' + encodeURI(q_getPara('sys.key_rc2'))+';'+ encodeURI(q_getPara('sys.key_vcc')) );
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
                        	q_func('vcc_post.post', ass[i].accy + ',' + ass[i].noa + ',1');
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
                        	q_func('vcc_post.post', ass[i].accy + ',' + ass[i].noa + ',0');
                            sleep(100);
                        }
                        
                        q_func('qtxt.query.cub_r_3', 'cub.txt,cub_r,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val()) + ';0;' + encodeURI(q_getPara('sys.key_rc2'))+';'+ encodeURI(q_getPara('sys.key_vcc')));
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
                            abbm[q_recno]['vcceno'] = as[0].vcceno;
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
                        q_func('qtxt.query.cub_r_1', 'cub.txt,cub_r,' + encodeURI(r_accy) + ';' + encodeURI($('#txtNoa').val()) + ';1;' + encodeURI(q_getPara('sys.key_rc2'))+';'+ encodeURI(q_getPara('sys.key_vcc')));
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
				
				if(emp($('#txtProcess_0').val())){//自動產生流程
					var as =[];
					as.push({process:'開銅膜/模具'});
					as.push({process:'樣品照片'});
					as.push({process:'客戶確認'});
					as.push({process:'寄送樣品'});
					as.push({process:'客戶收樣品'});
					as.push({process:'轉生產件號'});
					as.push({process:'通知建製程'});
					as.push({process:'成本計算'});
					as.push({process:'報價'});
					q_gridAddRow(bbsHtm, 'tbbs', 'txtProcess', as.length, as, 'process', '', '');
				}
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				//q_box('z_cubp_r.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}

			function btnOk() {
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				sum();
				if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);

				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cub') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
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
				if (!as['productno']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

			function refresh(recno) {
				_refresh(recno);
				bbsdisabled();
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
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

			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
					}
				}
				_bbtAssign();
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
			
	        function q_popPost(s1) {
			   	switch (s1) {
			        
			   	}
			}
			
			function bbsdisabled() {
				if(q_cur==1 || q_cur==2){
					if(!$('#chkIsproj').prop('checked')){
						$('#chkEnda').attr('disabled', 'disabled');
						$('#txtEdate').attr('disabled', 'disabled');
					}else{
						$('#chkEnda').removeAttr("disabled");
						$('#txtEdate').removeAttr("disabled");
					}
					for (var i = 0; i < q_bbsCount; i++) {
						if(!$('#chkIsproj').prop('checked')){
							$('#chkEnda_'+i).attr('disabled', 'disabled');
							$('#txtDatea_'+i).attr('disabled', 'disabled');
						}else{
							$('#chkEnda_'+i).removeAttr("disabled");
							$('#txtDatea_'+i).removeAttr("disabled");
						}
					}
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
				width: 1260px;
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
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width: 1260px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width:100px; color:black;"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='comp,4' style="text-align: center;">~comp,4</td>
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
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl" > </a></td>
						<td><input id="txtProductno" type="text" class="txt c1"/></td>
						<td colspan="2"><input id="txtProduct" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblBdate" class="lbl" > </a></td>
						<td><input id="txtBdate" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSpec" class="lbl" > </a></td>
						<td colspan="3"><input id="txtSpec" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblUnit" class="lbl" > </a></td>
						<td><input id="txtUnit" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount" class="lbl" > </a></td>
						<td><input id="txtMount" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblPrice" class="lbl" > </a></td>
						<td><input id="txtPrice" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblMoney" class="lbl" >總計</a></td>
						<td><input id="txtMo" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo2_pi" class="lbl" > </a></td>
						<td colspan="5"><input id="txtMemo2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="2">
							<input id="chkIsproj" type="checkbox"/>
							<a id='lblIsproj'>核單</a>
							<input id="chkEnda" type="checkbox"/>
							<a id='lblEnda'>寄送</a>
							<span> </span><a id="lblEdate" class="lbl" >寄送日期</a>
						</td>
						<td><input id="txtEdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblVccno" class="lbl" >出貨單號</a></td>
						<td><input id="txtVcceno" type="text" class="txt c1"/></td>
						<!--<td>
							<input id="chkCancel" type="checkbox"/>
							<span> </span><a id='lblCancel'>取消</a>
						</td>-->
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:20px;"> </td>
						<td style="width:140px;"><a id='lblProcess_r_s'>流程</a></td>
						<td style="width:140px;"><a id='lblTgg_s'>廠商名稱</a></td>
						<td style="width:80px;"><a id='lblMount_s'> </a></td>
						<td style="width:40px;"><a id='lblUnit_s'> </a></td>
						<td style="width:70px;"><a id='lblPrice_s'> </a></td>
						<td style="width:100px;"><a id='lblMo_s'>金額</a></td>
						<td style="width:40px;"><a id='lblSale_s'>外加稅</a></td>
						<td style="width:100px;"><a id='lblTxa_s'>稅金</a></td>
						<td style="width:100px;"><a id='lblW01_s'>總金額</a></td>
						<td style="width:150px;"><a id='lblNeed_s'> </a><BR><a id='lblMemo_s'> </a></td>
						<td style="width:40px;"><a id='lblEnda_s'>完工</a></td>
						<td style="width:80px;"><a id='lblDatea_s'>完工日</a></td>
						<td style="width:40px;"><a id='lblPay_s'>請款</a></td>
						<td style="width:150px;"><a id='lblOrdeno_s'>進貨單號</a></td>
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
							<input id="txtNeed.*" type="text" class="txt c1"/>
							<input id="txtMemo.*" type="text" class="txt c1"/>
						</td>
						<td><input id="chkEnda.*" type="checkbox" class="txt c1" /></td>
						<td><input id="txtDatea.*" type="text" class="txt c1"/></td>
						<td><input id="chkCut.*" type="checkbox" class="txt c1"/></td>
						<td><input id="txtOrdeno.*" type="text" class="txt c1 num" style="color:blue;width: 90%;text-align:left;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt' style="display: none;">
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:20px;"> </td>
					<td style="width:150px; text-align: center;">領料編號</td>
					<td style="width:200px; text-align: center;">領料名稱</td>
					<td style="width:200px; text-align: center;">規格</td>
					<td style="width:40px; text-align: center;">單位</td>
					<td style="width:100px; text-align: center;">領料數量</td>
					<td style="width:120px; text-align: center;">領料倉</td>
					<td style="width:200px; text-align: center;">備註</td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="txtProductno..*" type="text" class="txt c1" style="width: 85%;"/>
						<input class="btn"  id="btnProductno..*" type="button" value='.' style=" font-weight: bold;" />
					</td>
					<td><input id="txtProduct..*" type="text" class="txt c1"/></td>
					<td><input id="txtSpec..*" type="text" class="txt c1"/></td>
					<td><input id="txtUnit..*" type="text" class="txt c1"/></td>
					<td><input id="txtMount..*" type="text" class="txt c1 num"/></td>
					<td>
						<input id="txtStoreno..*" type="text" class="txt c1" style="width: 30%"/>
						<input class="btn"  id="btnStoreno..*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtStore..*" type="text" class="txt c1" style="width: 50%"/>
					</td>
					<td><input id="txtMemo..*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
	</body>
</html>