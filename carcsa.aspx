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

            q_desc = 1;
            q_tables = 's';
            var q_name = "carcsa";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtWeight','txtMount','txtCarno','txtCarno2'
            ,'txtInmoney','txtIntotal','txtOutmoney','txtOutplus','txtOutminus','txtOuttotal'];
            var q_readonlys = ['txtInmoney','txtOutmoney','txtTranno'];
            var bbmNum = [['txtWeight',10,3,1],['txtMount',10,3,1],['txtPrice',10,3,1]
            ,['txtInmoney',10,0,1],['txtInplus',10,0,1],['txtInminus',10,0,1],['txtIntotal',10,0,1]
            ,['txtOutmoney',10,0,1],['txtOutplus',10,0,1],['txtOutminus',10,0,1],['txtOuttotal',10,0,1]];
            var bbsNum = [['txtWeight',10,3,1],['txtMount',10,3,1],['txtDiscount',10,3,1],['txtInmoney',10,0,1],['txtOutmoney',10,0,1],['txtOutplus',10,0,1],['txtOutminus',10,0,1],['txtOutprice',10,3,1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(
            ['txtAddrno', 'lblAddr', 'addr', 'noa,addr,productno,product', 'txtAddrno,txtAddr,txtUccno,txtProduct', 'addr_b.aspx'],
            ['txtUccno', 'lblProduct', 'ucca', 'noa,product', 'txtUccno,txtProduct', 'ucca_b.aspx'],
            ['txtDriverno_', 'btnDriver_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx'],
        	['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'],
        	['txtCarno_', 'btnCarno_', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx']);

			brwCount2 = 15;
            q_xchg = 1;
            var calctypeItem = new Array();
            function currentData() {}
			currentData.prototype = {
				data : [],
				/*新增時複製的欄位*/
				include : ['txtTrandate','txtMon','cmbInterval','txtCustno','txtComp','txtNick','txtAddrno','txtAddr','txtUccno','txtProduct'],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isInclude = false;
						for (var j in curData.include) {
							if (fbbm[i] == curData.include[j]) {
								isInclude = true;
								break;
							}
						}
						if (isInclude) {
							curData.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in curData.data) {
						$('#' + curData.data[i].field).val(curData.data[i].value);
					}
				}
			};
			var curData = new currentData();
			
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_desc = 1;
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {

                q_getFormat();
                bbmMask = [['txtTrandate', r_picd], ['txtBtime', '99:99'], ['txtEtime', '99:99'], ['txtMon', r_picm]];
                q_mask(bbmMask);
				q_gt('carcsatype', '', 0, 0, 0, "");
				q_gt('acomp', '', 0, 0, 0, "");
				q_gt('calctype2', '', 0, 0, 0, "calctypes");
				q_cmbParse("cmbOntime", ',Y');
				q_cmbParse("cmbInterval", q_getPara('carcsa.interval'));
                //q_cmbParse("cmbType", '@,'+q_getPara('carcsa.type'));
                q_cmbParse("cmbTypea2", ('').concat(new Array('', '全拖', '半拖', '小時', '塊')));

				$("#txtAddrno").focus(function() {
					var input = document.getElementById ("txtAddrno");
		            if (typeof(input.selectionStart) != 'undefined' ) {	  
		                input.selectionStart = 5;
		                input.selectionEnd =8;
		            }
				});
                $('#cmbType').change(function() {         
                    var tmp = $('#cmbType').find(":selected").text().split('_');
                    if(tmp.length==4){
                    	$('#txtCartype').val(tmp[0]);
                        $('#txtMemo').val(tmp[1]);
                        $('#cmbTypea2').val(tmp[2]);
                        $('#txtPrice').val(tmp[3]);
                    }else{
                    	$('#txtCartype').val('');
                        $('#txtMemo').val('');
                        $('#cmbTypea2').val('');
                        $('#txtPrice').val('0');
                    }
                    sum();
                });
                
                $('#txtPrice').change(function() {
                    sum();
                });
                $('#txtInplus').change(function() {
                    sum();
                });
                $('#txtInminus').change(function() {
                    sum();
                });
                $('#lblType').click(function(){
                	q_box("carcsatype.aspx?" + r_userno + ";" + r_name + ";" + q_time, 'carcsatype', "95%", "95%", q_getMsg('popCarcsatype'));
                });
                $('#btnTran').click(function(){
                	var t_where = '',t_tranno='';
                    for (var i = 0; i < q_bbsCount; i++) {
                    	t_tranno = $.trim($('#txtTranno_'+i).val());
                    	if(t_tranno.length>0)
                    		t_where += (t_where.length > 0 ? ' or ' : '') + "noa='" + t_tranno + "'";
                    }
                   	if(t_where.length>0)
                   		q_pop('', "trans.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno+";", 'vcca', 'noa', 'datea', "95%", "95%", q_getMsg('popTrans'), true);
               		else
               			alert('無出車單號。');
                });
            }
			function browTrans(obj){
				var noa = $.trim($(obj).val());
            	if(noa.length>0)
            		q_box("trans.aspx?;;;noa='" + noa + "';"+r_accy, 'trans', "95%", "95%", q_getMsg("popTarans"));
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

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'addr':
                        var as = _q_appendData("addr", "", true);
                        if (as[0] != undefined) {
	                        $('#txtAddrno').val(as[0].noa);
	                        $('#txtAddr').val(as[0].addr);
	                        $('#txtUccno').val(as[0].productno);
	                        $('#txtProduct').val(as[0].product);
                        }
                        break;
                	case 'calctypes':
						var as = _q_appendData("calctypes", "", true);
						var t_item = "@";
						var item = new Array({
								noa : '',
								typea : '',
								discount : 0,
								isOutside : false
							});
						for ( i = 0; i < as.length; i++) {
							if(!(as[i].noa=='D' || as[i].noa=='E'))
								continue;
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
							item.push({
								noa : as[i].noa + as[i].noq,
								typea : as[i].typea,
								discount : as[i].discount,
								isOutside : as[i].isoutside.length == 0 ? false : (as[i].isoutside == "false" || as[i].isoutside == "0" || as[i].isoutside == "undefined" ? false : true)
							});
						}
						q_cmbParse("cmbCalctype", t_item, "s");
						calctypeItem = item;
						refresh(q_recno);
						break;
                	case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        if (as[0] != undefined) {
	                        var t_item = " @ ";
	                        for ( i = 0; i < as.length; i++) {
	                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
	                        }
	                        q_cmbParse("cmbCno", t_item);
	                        if (abbm[q_recno] != undefined) {
	                        	$("#cmbCno").val(abbm[q_recno].cno);
	                        }
                        }
                        break;
                	case 'carcsatype':
                        var as = _q_appendData("carcsatype", "", true);
                        if (as[0] != undefined) {
	                        var t_item = " @ ";
	                        for ( i = 0; i < as.length; i++) {
	                            t_item = t_item + (t_item.length > 0 ? ',' : '');
	                            t_item = t_item + as[i].cartype + '_' + as[i].memo + '_' + as[i].typea + '_' + as[i].price;
	                        }
	                        q_cmbParse("cmbType", t_item);
	                        if (abbm[q_recno] != undefined) {
	                        	$("#cmbType").val(abbm[q_recno].cno);
	                        }
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                } 
            }
            function q_popPost(id) {
				switch(id) {
					case 'txtCustno':
						if ($("#txtCustno").val().length > 0) {
							var t_addrno = $('#txtCustno').val()+'-001';
							var t_where = "where=^^ noa='"+t_addrno+"' ^^";
	                		q_gt('addr', t_where, 0, 0, 0, "");
						}
						break;
					case 'txtCarno_':
						if(q_cur==1 || q_cur==2){
							if(q_float('txtOutprice_'+b_seq)==0)							
								$('#txtOutprice_'+b_seq).val($('#txtPrice').val());
						}
						break;
				}
			}
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                var string =  xmlString.split(';');
                var n = 0;
                for (var i = 0; i < q_bbsCount; i++) {
                	n += $.trim($('#txtCarno_'+i).val()).length>0?1:0;
                }
                if(n != string.length && q_cur==2){
                	alert('stPost 出車單回傳錯誤!'+n+'_'+string.length +'_'+string);
                	return;
                }
                var t_noa = abbm[q_recno]['noa'];
				var b_seq = 0;
               	var i = 0;
				for (var j = 0; j < abbs.length; j++) {
					if(abbs[j]['noa'] == t_noa){
						abbs[j]['tranno'] = string[i];
						$('#txtTranno_'+i).val(string[i]);
						i++;
						b_seq++;
					}
				}                /*
                if(string[0]!=undefined){        
                	for(var i in string) {
                		$('#txtTranno_'+i).val(string[i]);
                	}
                }
                */
            }
            function btnOk() {
            	var t_carno = '';
            	$('#txtCarno2').val('');
            	for (var i = 0; i < q_bbsCount; i++) {
            		if($('#txtCarno2').val().length==0){
            			$('#txtCarno2').val($.trim($('#txtCarno_'+i).val()));
            		}
            		if(t_carno.indexOf($.trim($('#txtCarno_'+i).val()))==-1)
            			t_carno += (t_carno.length>0?',':'') + $.trim($('#txtCarno_'+i).val());
            	}
            	$('#txtCarno').val(t_carno);
            	
            	if ($('#txtCustno').val().length==0){
                	alert('請輸入'+q_getMsg('lblCust')+'。');
                	return;
                }
                if ($('#txtAddrno').val().length==0){
                	alert('請輸入'+q_getMsg('lblAddr')+'。');
                	return;
                }
                if ($('#txtUccno').val().length==0){
                	alert('請輸入'+q_getMsg('lblProduct')+'。');
                	return;
                }
                
            	if ($('#txtTrandate').val().length==0 || !q_cd($('#txtTrandate').val())){
                	alert(q_getMsg('lblTrandate')+'錯誤。');
                	return;
                }
                $('#txtMon').val($.trim($('#txtMon').val()));
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val()))
                    alert(q_getMsg('lblMon')+'錯誤。');
				if(q_cur==1)
                	$('#txtWorker').val(r_name);
                else
                	$('#txtWorker2').val(r_name);
                sum();

                var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtTrandate').val()); /*!!!!!!!!!!*/
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_carcsa') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('carcsa_s.aspx', q_name + '_s', "550px", "550px", q_getMsg("popSeek"));
            }
            function bbsAssign() {
            	for (var j = 0; j < q_bbsCount; j++) {
                	$('#lblNo_'+j).text(j+1);	
                	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                		$('#cmbCalctype_'+j).change(function(e){
                			var n = parseInt($(this).attr('id').replace('cmbCalctype_',''));
                			var m = $(this)[0].selectedIndex;
                			$('#txtDiscount_' + n).val(calctypeItem[m].discount);
                			sum();
                		});
                		$('#txtMount_' + j).change(function(e){
                			sum();
                		});
                		$('#txtDiscount_' + j).change(function(e){
                			sum();
                		});
                		$('#txtOutprice_' + j).change(function(e){
                			sum();
                		});
                		$('#txtOutplus_' + j).change(function(e){
                			sum();
                		});
                		$('#txtOutminus_' + j).change(function(e){
                			sum();
                		});
                	}
                }     
                _bbsAssign();   
            }

            function btnIns() {
                curData.copy();
                _btnIns();
                curData.paste();
                $('#txtNoa').val('AUTO');
                if($('#txtTrandate').val().length==0)
               		$('#txtTrandate').val(q_date());
                $('#txtTrandate').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtTrandate').focus();
                sum();
            }

            function btnPrint() {
                q_box('z_carcs.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['carno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
            	if(!(q_cur==1 || q_cur==2))
            		return;
                var t_mount=0,t_weight=0,t_inmoney=0,t_outmoney=0,t_outplus=0,t_outminus=0,t_outprice;
                var t_price = q_float('txtPrice');
                for (var j = 0; j < q_bbsCount; j++) {
                	if(q_float('txtOutprice_'+j)==0 && $('#txtCarno_'+j).val().length>0)							
						$('#txtOutprice_'+j).val(t_price );
					t_outprice = q_float('txtOutprice_'+j);
                	
                    $('#txtInmoney_'+j).val( round(t_price*q_float('txtMount_'+j) ,0));
                    $('#txtOutmoney_'+j).val( round(t_outprice*q_float('txtMount_'+j)*q_float('txtDiscount_'+j) ,0));
                    
                    t_mount += q_float('txtMount_'+j);
                    t_weight += q_float('txtWeight_'+j);
                    t_inmoney += q_float('txtInmoney_'+j);
                    t_outmoney += q_float('txtOutmoney_'+j);
                    t_outplus += round(q_float('txtOutplus_'+j)*q_float('txtDiscount_'+j) ,0);
                    t_outminus += q_float('txtOutminus_'+j);
                }
                
                $('#txtMount').val(t_mount);
                $('#txtWeight').val(t_weight);
                $('#txtInmoney').val(t_inmoney);
                $('#txtIntotal').val(t_inmoney+q_float('txtInplus')-q_float('txtInminus'));
     
                $('#txtOutmoney').val(t_outmoney);
                $('#txtOutplus').val(t_outplus);
                $('#txtOutminus').val(t_outminus);
                $('#txtOuttotal').val(t_outmoney+t_outplus-t_outminus);
            }

            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
            function refresh(recno) {
                _refresh(recno);
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
                } else if ((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//西元年
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                    if (regex.test(str))
                        return 3;
                } else if ((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//民國年
                    str = (parseInt(str.substring(0, 3)) + 1911) + str.substring(3);
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                    if (regex.test(str))
                        return 4
                }
                return 0;
                //錯誤
            }

		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 95%;
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
                width: 95%;
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
                width: 10%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
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
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            .dbbs {
                width: 95%;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs input[type="text"] {
                width: 95%;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"], select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTrandate'> </a></td>
						<td align="center" style="width:150px; color:black;"><a id='vewOrdeno'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewCartype'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewMon'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewInterval'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewComp'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewMount'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTimes'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewInmoney'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewInplus'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewInminus'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewIntotal'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewCarno'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewOuttotal'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="trandate" style="text-align: center;">~trandate</td>
						<td id="ordeno" style="text-align: center;">~ordeno</td>
						<td id="cartype" style="text-align: center;">~cartype</td>
						<td id="mon" style="text-align: center;">~mon</td>
						<td id="interval=carcsa.interval" style="text-align: center;">~interval=carcsa.interval</td>
						<td id="nick" style="text-align: left;">~nick</td>
						<td id="mount" style="text-align: right;">~mount</td>
						<td id="times" style="text-align: right;">~times</td>
						<td id="inmoney,0,1" style="text-align: right;">~inmoney,0,1</td>
						<td id="inplus,0,1" style="text-align: right;">~inplus,0,1</td>
						<td id="inminus,0,1" style="text-align: right;">~inminus,0,1</td>
						<td id="intotal,0,1" style="text-align: right;">~intotal,0,1</td>
						<td id="carno2" style="text-align: left;">~carno2</td>
						<td id="outtotal,0,1" style="text-align: right;">~outtotal,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblTrandate" class="lbl"> </a></td>
						<td><input id="txtTrandate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblInterval" class="lbl"> </a></td>
						<td><select id="cmbInterval" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
						<td colspan="2"><input id="txtOrdeno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblAcomp" class="lbl" style="display: none;"> </a></td>
						<td colspan="2"><select id="cmbCno" class="txt c1" style="display: none;"> </select></td>
						<td><span> </span><a id="lblType" class="lbl btn"> </a></td>
						<td><select id="cmbType" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCartype" class="lbl"> </a></td>
						<td><input id="txtCartype" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td>
							<input id="txtTypea" type="text" style="float:left; width:30%;"/>
							<select id="cmbTypea2" style="float:left; width:70%;"> </select>
						</td>
						<td><span> </span><a id="lblPrice" class="lbl"> </a></td>
						<td><input id="txtPrice" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text" style="float:left; width:35%;"/>
							<input id="txtComp"  type="text" style="float:left; width:65%;"/>
							<input id="txtNick"  type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblAddr" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtAddrno"  type="text"  style="float:left; width:50%;"/>
							<input id="txtAddr"  type="text"  style="float:left; width:50%;"/>
						</td>
					</tr>
					<tr>
						<td colspan="4"> </td>
						<td><span> </span><a id="lblProduct" class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtUccno"  type="text"  style="float:left; width:50%;"/>
							<input id="txtProduct"  type="text"  style="float:left; width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBtime" class="lbl"> </a></td>
						<td><input id="txtBtime"  type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblOntime" class="lbl"> </a></td>
						<td><select id="cmbOntime" class="txt c1"> </select></td>
						<td><span> </span><a id="lblEtime" class="lbl"> </a></td>
						<td><input id="txtEtime" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td><input id="txtWeight"  type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblTimes" class="lbl"> </a></td>
						<td><input id="txtTimes" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblInmoney" class="lbl"> </a></td>
						<td><input id="txtInmoney"  type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblInplus" class="lbl"> </a></td>
						<td><input id="txtInplus"  type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblInminus" class="lbl"> </a></td>
						<td><input id="txtInminus"  type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblIntotal" class="lbl"> </a></td>
						<td><input id="txtIntotal"  type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOutmoney" class="lbl" title="數量*發單價*折扣"> </a></td>
						<td><input id="txtOutmoney"  type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblOutplus" class="lbl" title="司機加項*折扣"> </a></td>
						<td><input id="txtOutplus"  type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblOutminus" class="lbl"> </a></td>
						<td><input id="txtOutminus"  type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblOuttotal" class="lbl"> </a></td>
						<td><input id="txtOuttotal"  type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCarno" class="lbl"> </a></td>
						<td colspan="7">
							<input id="txtCarno" type="text" class="txt c1"/>
							<input id="txtCarno2" type="text" style="display:none;"/>	
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl btn"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl btn"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><input type="button" id="btnTran" value="出車單明細"/> </td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:100px;"><a id='lblCarnos'> </a></td>
					<td align="center" style="width:200px;"><a id='lblDrivers'> </a></td>
					<td align="center" style="width:100px;"><a id='lblCalctype'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWeights'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMounts'> </a></td>
					<td align="center" style="width:80px;"><a id='lblIns'> </a></td>
					<td align="center" style="width:80px;"><a id='lblDiscounts'> </a></td>
					<td align="center" style="width:80px;"><a id='lblOutprice'> </a></td>
					<td align="center" style="width:80px;"><a id='lblOuts'> </a></td>
					<td align="center" style="width:80px;"><a id='lblOutpluss'> </a></td>
					<td align="center" style="width:80px;"><a id='lblOutminuss'> </a></td>
					<td align="center" style="width:150px;"><a id='lblTranno'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td>
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*"  style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					
					<td>
						<input class="btn"  id="btnCarno.*" type="button" value='.' style="display: none; font-weight: bold;width:1%;float:left;" />
						<input  id="txtCarno.*" type="text" class="txt c1"/>
					</td>
					<td>
						<input class="btn"  id="btnDriver.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <input type="text" id="txtDriverno.*"  style="width:40%; float:left;"/>
						<input type="text" id="txtDriver.*"  style="width:40%; float:left;"/>
					</td>
					<td><select id="cmbCalctype.*" class="txt c1"> </select></td>
					<td><input  id="txtWeight.*" type="text" class="txt c1 num"/></td>
					<td><input  id="txtMount.*" type="text" class="txt c1 num"/></td>
					<td><input  id="txtInmoney.*" type="text" class="txt c1 num"/></td>
					<td><input  id="txtDiscount.*" type="text" class="txt c1 num"/></td>
					<td><input  id="txtOutprice.*" type="text" class="txt c1 num"/></td>
					<td><input  id="txtOutmoney.*" type="text" class="txt c1 num"/></td>
					<td><input  id="txtOutplus.*" type="text" class="txt c1 num"/></td>
					<td><input  id="txtOutminus.*" type="text" class="txt c1 num"/></td>
					<td><input  id="txtTranno.*" onclick="browTrans(this)" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
