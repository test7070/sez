<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
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
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_desc = 1;
            q_tables = 's';
            var q_name = "ordb";
            var q_readonly = ['txtTgg', 'txtAcomp', 'txtSales', 'txtNoa', 'txtWorker', 'txtWorker2','txtMoney','txtTotal','txtTotalus'];
            var q_readonlys = ['txtNo3','txtNo2','txtTotal', 'txtC1', 'txtNotv'];
            var bbmNum = [['txtFloata', 10, 5, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1], ['txtTotalus', 10, 0, 1]];
            var bbsNum = [['txtMount', 10, 0, 1], ['txtPrice', 10, 2, 1], ['txtTotal', 10, 0, 1], ['txtC1', 10, 2, 1], ['txtNotv', 10, 2, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtProductno1_', 'btnProduct1_', 'bcc', 'noa,product,unit', 'txtProductno1_,txtProduct_,txtUnit_', 'bcc_b.aspx']
            , ['txtProductno2_', 'btnProduct2_', 'ucaucc', 'noa,product,unit', 'txtProductno2_,txtProduct_,txtUnit_', 'ucaucc_b.aspx']
            , ['txtProductno3_', 'btnProduct3_', 'fixucc', 'noa,namea,unit', 'txtProductno3_,txtProduct_,txtUnit_', 'fixucc_b.aspx']
            , ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
            , ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick,paytype', 'txtTggno,txtTgg,txtNick,txtPaytype', 'tgg_b.aspx']);
           	brwCount2 =10;
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'no3'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }
            
            function sum() {
            	if (!(q_cur == 1 || q_cur == 2))
                    return;
                $('#txtMoney').attr('readonly', true);
                $('#txtTax').attr('readonly', true);
                $('#txtTotal').attr('readonly', true);
                $('#txtMoney').css('background-color', 'rgb(237,237,238)').css('color', 'green');
                $('#txtTax').css('background-color', 'rgb(237,237,238)').css('color', 'green');
                $('#txtTotal').css('background-color', 'rgb(237,237,238)').css('color', 'green');

                var t_mount = 0, t_price = 0, t_money = 0, t_weight = 0, t_total = 0, t_tax = 0;
                var t_mounts = 0, t_prices = 0, t_moneys = 0, t_weights = 0;
                var t_float = q_float('txtFloata');

                for (var j = 0; j < q_bbsCount; j++) {
                    t_weights = q_float('txtWeight_' + j);
                    t_prices = q_float('txtPrice_' + j);
                    t_mounts = q_float('txtMount_' + j);
                    t_moneys = round(q_mul(t_prices,t_mounts),0);
					
					t_weight = q_add(t_weight,t_weights);
                    t_mount = q_add(t_mount,t_mounts);
                    t_money = q_add(t_money,t_moneys);

                    $('#txtTotal_' + j).val(FormatNumber(t_moneys));
                }
                t_taxrate = parseFloat(q_getPara('sys.taxrate')) / 100;
                switch ($('#cmbTaxtype').val()) {
                    case '1':
                        // 應稅
                        t_tax = round(q_mul(t_money,t_taxrate), 0);
                        t_total = q_add(t_money,t_tax);
                        break;
                    case '2':
                        //零稅率
                        t_tax = 0;
                        t_total = q_add(t_money,t_tax);
                        break;
                    case '3':
                        // 內含
                        t_tax = round(q_mul(q_div(t_money,q_add(1,t_taxrate)),t_taxrate), 0);
                        t_total = t_money;
                        t_money = q_sub(t_total,t_tax);
                        break;
                    case '4':
                        // 免稅
                        t_tax = 0;
                        t_total = q_add(t_money,t_tax);
                        break;
                    case '5':
                        // 自定
                        $('#txtTax').attr('readonly', false);
                        $('#txtTax').css('background-color', 'white').css('color', 'black');
                        t_tax = round(q_float('txtTax'), 0);
                        t_total =q_add(t_money,t_tax);
                        break;
                    case '6':
                        // 作廢-清空資料
                        t_money = 0, t_tax = 0, t_total = 0;
                        break;
                    default:
                }
                t_price = q_float('txtPrice');
                if (t_price != 0) {
                    $('#txtTranmoney').val(FormatNumber(round(q_mul(t_weight,t_price),0)));
                }
                $('#txtWeight').val(FormatNumber(t_weight));

                $('#txtMoney').val(FormatNumber(t_money));
                $('#txtTax').val(FormatNumber(t_tax));
                $('#txtTotal').val(FormatNumber(t_total));
                $('#txtTotalus').val(FormatNumber(round(q_mul(q_float('txtTotal'),q_float('txtFloata')), 2)));
                //$('#txtTotalus').val(FormatNumber(Math.round(q_float('txtTotal').mul(q_float('txtFloata'), 2))));
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtOdate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbKind", q_getPara('ordb.kind'));
                q_cmbParse("cmbCoin", q_getPara('sys.coin'));
                q_cmbParse("combPaytype", q_getPara('vcc.paytype'));
                q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));

				$("#combPaytype").change(function(e) {
                    if (q_cur == 1 || q_cur == 2)
                        $('#txtPaytype').val($('#combPaytype').find(":selected").text());
                });
                $("#combAddr").change(function(e) {
                    if (q_cur == 1 || q_cur == 2){
                    	$('#txtAddr').val($('#combAddr').find("option:selected").text());
                    	$('#txtPost').val($('#combAddr').find("option:selected").val());
                    }
                });
                $("#txtPaytype").focus(function(e) {
                    var n = $(this).val().match(/[0-9]+/g);
                    var input = document.getElementById("txtPaytype");
                    if ( typeof (input.selectionStart) != 'undefined' && n != null) {
                        input.selectionStart = $(this).val().indexOf(n);
                        input.selectionEnd = $(this).val().indexOf(n) + (n+"").length;
                    }
                }).click(function(e) {
                    var n = $(this).val().match(/[0-9]+/g);
                    var input = document.getElementById("txtPaytype");
                    if ( typeof (input.selectionStart) != 'undefined' && n != null) {
                        input.selectionStart = $(this).val().indexOf(n);
                        input.selectionEnd = $(this).val().indexOf(n) + (n+"").length;
                    }
                });
                
                $('#btnOrde').click(function() {
                    q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; isnull(enda,'0')='0' and noa+'_'+no2 not in (select isnull(ordeno,'')+'_'+isnull(no2,'') from view_ordbs"+r_accy+" where noa!='"+$('#txtNoa').val()+"')", 'ordes', "95%", "95%", q_getMsg('popOrde'));
                });

                //變動按鈕
                $('#cmbKind').change(function() {
                    for (var j = 0; j < q_bbsCount; j++) {
                        btnMinus('btnMinus_' + j);
                    }
                    product_change();
                });
				$('#txtAddr').change(function(){
					var t_where = "where=^^ noa='" + trim($(this).val()) + "' ^^";
					q_gt('cust', t_where , 0, 0, 0, "", r_accy);
				});

                $('#txtFloata').change(function() {
                    sum();
                });
                $("#cmbTaxtype").change(function(e) {
                    sum();
                });
                $('#txtTotal').change(function() {
                    sum();
                });
                $('#txtTggno').change(function() {
                    loadCustAddr($.trim($(this).val()));
                });
            }

            function q_boxClose(s2) {///	q_boxClose 2/4
                var
                ret;
                switch (b_pop) {
                    case 'ordes':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
	                             return;
	                        for (var j = 0; j < q_bbsCount; j++) {
	                        	$('#btnMinus_'+j).click();
	                        }
                            
                            var i, j = 0;
                            ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtMount,txtPrice,txtOrdeno,txtNo2', b_ret.length, b_ret, 'productno,product,unit,mount,price,noa,no2', 'txtOrdeno,txtNo2');
                            /// 最後 aEmpField 不可以有【數字欄位】
                            sum();
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///	q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }
			
			var z_cno=r_cno,z_acomp=r_comp,z_nick=r_comp.substr(0,2);
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'cno_acomp':
                		var as = _q_appendData("acomp", "", true);
                		if (as[0] != undefined) {
	                		z_cno=as[0].noa;
	                		z_acomp=as[0].acomp;
	                		z_nick=as[0].nick;
	                	}
                		break;
                    case 'combAddr':
                        var as = _q_appendData("custaddr", "", true);
                        var t_item = " @ ";
                        if (as[0] != undefined) {
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].post + '@' + as[i].addr;
                            }
                        }
                        q_cmbParse("combAddr", t_item);
                        break;
					case 'cust' :
						var as = _q_appendData("cust", "", true);
						if (as[0] != undefined) {
							var CustAddr = trim(as[0].addr_fact);
							if(CustAddr.length>0){
								$('#txtAddr').val(CustAddr);
								$('#txtPost').val(as[0].zip_fact);
							}
						}
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function btnOk() {
                Lock(1,{opacity:0});
				//日期檢查
				if($('#txtOdate').val().length == 0 || !q_cd($('#txtOdate').val())){
					alert(q_getMsg('lblOdate')+'錯誤。');
            		Unlock(1);
            		return;
				}
				if($('#txtOdate').val().substring(0,3)!=r_accy){
					alert('年度異常錯誤，請切換到【'+$('#txtOdate').val().substring(0,3)+'】年度再作業。');
					Unlock(1);
            		return;
				}
				if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);

                sum();
                if ($('#cmbKind').val() == '1') {
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#txtProductno_' + j).val($('#txtProductno1_' + j).val());
                    }
                } else if ($('#cmbKind').val() == '2') {
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#txtProductno_' + j).val($('#txtProductno2_' + j).val());
                    }
                } else {
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#txtProductno_' + j).val($('#txtProductno3_' + j).val());
                    }
                }
                var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtOdate').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ordb') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('ordb_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combAddr_chg() {/// 只有 comb 開頭，才需要寫 onChange()	，其餘 cmb 連結資料庫
                if (q_cur == 1 || q_cur == 2) {
                    $('#txtAddr').val($('#combAddr').find("option:selected").text());
                    $('#txtPost').val($('#combAddr').find("option:selected").val());
                }
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                	$('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#txtMount_' + j).change(function() {
                            sum();
                        });
                        $('#txtPrice_' + j).change(function() {
                            sum();
                        });
                        $('#btnRc2record_' + j).click(function() {
                            t_IdSeq = -1;
                            /// 要先給  才能使用 q_bodyId()
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            t_where = "tgg='" + $('#txtTggno').val() + "' and noq='" + $('#txtProductno_' + b_seq).val() + "'";
                            q_box("z_rc2record.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'rc2record', "95%", "95%", q_getMsg('lblRc2record'));
                        });
                    }
                }
                _bbsAssign();
                product_change();
            }

            function q_popPost(s1) {
                switch (s1) {
                	case 'txtTggno':
                        loadCustAddr($.trim($('#txtTggno').val()));
                        break;
                }
            }

            function btnIns() {
                _btnIns();
				$('#chkIsproj').attr('checked',true);
                $('#txtNoa').val('AUTO');
                $('#txtOdate').val(q_date());
                $('#txtOdate').focus();
                $('#txtCno').val(z_cno);
				$('#txtAcomp').val(z_acomp);
                product_change();
                if(abbm[q_recno]!=undefined)
                	loadCustAddr(abbm[q_recno].tggno);
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtOdate').focus();
                product_change();
                if(abbm[q_recno]!=undefined)
                	loadCustAddr(abbm[q_recno].tggno);
               	sum();
            }

            function btnPrint() {
                t_where = "noa='" + $('#txtNoa').val() + "'";
                q_box("z_ordbp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, '', "95%", "95%", q_getMsg('popPrint'));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['datea'] = abbm2['datea'];
                as['kind'] = abbm2['kind'];
                as['tggno'] = abbm2['tggno'];
                as['odate'] = abbm2['odate'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                product_change();
            }
            function loadCustAddr(t_tggno){
            	$('#combAddr').children().remove();
            	if((q_cur==1 || q_cur==2) ){
                	if(t_tggno.length>0){
                    	q_gt('custaddr', "where=^^ noa='" + t_tggno + "' ^^", 0, 0, 0, "combAddr");
                	}
                }
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#combAddr').attr('disabled', 'disabled');
                } else {
                    $('#combAddr').removeAttr('disabled');
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
            function product_change() {
                if ($('#cmbKind').val() == '1') {
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#btnProduct1_' + j).show();
                        $('#btnProduct2_' + j).hide();
                        $('#btnProduct3_' + j).hide();
                        $('#txtProductno1_' + j).show();
                        $('#txtProductno2_' + j).hide();
                        $('#txtProductno3_' + j).hide();
                        $('#txtProductno1_' + j).val($('#txtProductno_' + j).val());
                    }
                } else if ($('#cmbKind').val() == '2') {
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#btnProduct1_' + j).hide();
                        $('#btnProduct2_' + j).show();
                        $('#btnProduct3_' + j).hide();
                        $('#txtProductno1_' + j).hide();
                        $('#txtProductno2_' + j).show();
                        $('#txtProductno3_' + j).hide();
                        $('#txtProductno2_' + j).val($('#txtProductno_' + j).val());
                    }
                } else {
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#btnProduct1_' + j).hide();
                        $('#btnProduct2_' + j).hide();
                        $('#btnProduct3_' + j).show();
                        $('#txtProductno1_' + j).hide();
                        $('#txtProductno2_' + j).hide();
                        $('#txtProductno3_' + j).show();
                        $('#txtProductno3_' + j).val($('#txtProductno_' + j).val());
                    }
                }
            }
            function FormatNumber(n) {
                var xx = "";
                if (n < 0) {
                    n = Math.abs(n);
                    xx = "-";
                }
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx + arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }

            Number.prototype.round = function(arg) {
                return Math.round(this.mul(Math.pow(10, arg))).div(Math.pow(10, arg));
            };
            Number.prototype.div = function(arg) {
                return accDiv(this, arg);
            };
            function accDiv(arg1, arg2) {
                var t1 = 0, t2 = 0, r1, r2;
                try {
                    t1 = arg1.toString().split(".")[1].length;
                } catch (e) {
                }
                try {
                    t2 = arg2.toString().split(".")[1].length;
                } catch (e) {
                }
                with (Math) {
                    r1 = Number(arg1.toString().replace(".", ""));
                    r2 = Number(arg2.toString().replace(".", ""));
                    return (r1 / r2) * pow(10, t2 - t1);
                }
            }


            Number.prototype.mul = function(arg) {
                return accMul(arg, this);
            };
            function accMul(arg1, arg2) {
                var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
                try {
                    m += s1.split(".")[1].length;
                } catch (e) {
                }
                try {
                    m += s2.split(".")[1].length;
                } catch (e) {
                }
                return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m);
            }


            Number.prototype.add = function(arg) {
                return accAdd(arg, this);
            };
            function accAdd(arg1, arg2) {
                var r1, r2, m;
                try {
                    r1 = arg1.toString().split(".")[1].length;
                } catch (e) {
                    r1 = 0;
                }
                try {
                    r2 = arg2.toString().split(".")[1].length;
                } catch (e) {
                    r2 = 0;
                }
                m = Math.pow(10, Math.max(r1, r2));
                return (Math.round(arg1 * m) + Math.round(arg2 * m)) / m;
            }


            Number.prototype.sub = function(arg) {
                return accSub(this, arg);
            };
            function accSub(arg1, arg2) {
                var r1, r2, m, n;
                try {
                    r1 = arg1.toString().split(".")[1].length;
                } catch (e) {
                    r1 = 0;
                }
                try {
                    r2 = arg2.toString().split(".")[1].length;
                } catch (e) {
                    r2 = 0;
                }
                m = Math.pow(10, Math.max(r1, r2));
                n = (r1 >= r2) ? r1 : r2;
                return parseFloat(((Math.round(arg1 * m) - Math.round(arg2 * m)) / m).toFixed(n));
            }
		</script>
		<style type="text/css">
            #dmain {
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
                width: 300px;
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
                width: 800px;
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
                width: 99%;
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
            }
            .dbbs {
                width: 1150px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
            #dbbt {
                width: 1525px;
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
		<div style="overflow: auto;display:block;">
		<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview"  >
				<table class="tview" id="tview"	>
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewOdate'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%"><a id='vewTgg'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='odate'>~odate</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td style="100px;"> </td>
						<td style="100px;"> </td>
						<td style="100px;"> </td>
						<td style="100px;"> </td>
						<td style="100px;"> </td>
						<td style="100px;"> </td>
						<td style="100px;"> </td>
						<td style="100px;"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td class="td2"><select id="cmbKind" class="txt c1"> </select></td>
						<td class="td3"><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td class="td4"><input id="txtOdate" type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtDatea" type="text" class="txt c1"/></td>
						<td class="td8" align="right"><input id="chkIsproj" type="checkbox"/><a id='lblIsproj' style="width: 50%;"> </a><span> </span></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAcomp' class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
							<input id="txtCno" type="text" style="float:left;width:30%;"/>
							<input id="txtAcomp" type="text" style="float:left;width:70%;"/>
						</td>
						<td class="td5"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td6" colspan="2"><input id="txtNoa"   type="text" class="txt c1"/></td>
						<td class="td8" align="right"><input id="chkEnda" type="checkbox"/><a id='lblEnd' style="width: 50%;"> </a><span> </span></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
							<input id="txtTggno" type="text" style="float:left;width:30%;"/>
							<input id="txtTgg"  type="text" style="float:left;width:70%;"/>
							<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td class="td5"><span> </span><a id='lblPaytype' class="lbl"> </a></td>
						<td class="td6" colspan="2">
							<input id="txtPaytype" type="text" style="float:left; width:90%;"/>
							<select id="combPaytype" style="float:left; width:10%;"> </select>
						</td>
						<td class="td8" align="center"><input id="btnOrde" type="button" style="text-align: center;"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtTel"  type="text"  class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td class="td6" colspan="3"><input id="txtFax" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td  class="td1"><span> </span><a id='lblAddr' class="lbl"> </a></td>
						<td  class="td2" colspan="7">
							<input id="txtPost"  type="text" style="float:left; width:130px;"/>
							<input id="txtAddr"  type="text" style="float:left; width:550px;"/>
							<select id="combAddr" style="float:left;width: 20px;"></select>
						</td>
					</tr>
					<tr>
						<td  class="td1"><span> </span><a id='lblTrantype' class="lbl"> </a></td>
						<td  class="td2">	<select id="cmbTrantype" class="txt c1" name="D1" ></select></td>
						<td  class="td3"><span> </span><a id='lblContract' class="lbl"> </a></td>
						<td  class="td4" colspan="2">	<input id="txtContract"  type="text" class="txt c1"/></td>
						<td  class="td6"><span> </span><a id="lblSales" class="lbl btn"> </a></td>
						<td  class="td7" colspan="2">
							<input id="txtSalesno" type="text" style="float:left;width:50%;"/>
							<input id="txtSales" type="text" style="float:left;width:50%;"/>	
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id='lblTax' class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt num c1" />	</td>
						<td><select id="cmbTaxtype" style="float:left;width:100%;" ></select></td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td  colspan="2"><input id="txtTotal" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td  class="td1"><span> </span><a id="lblOrde" class="lbl btn"> </a></td>
						<td  class="td2"><input id="txtOrdeno" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblFloata' class="lbl"> </a></td>
						<td><select id="cmbCoin" class="txt c1" ></select></td>
						<td><input id="txtFloata" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id='lblTotalus' class="lbl"> </a></td>
						<td  colspan="2"><input id="txtTotalus" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="7">
						<input id="txtMemo" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td>
						<input id="txtWorker"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td>
						<input id="txtWorker2"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblApv" class="lbl"> </a></td>
						<td>
						<input id="txtApv" type="text"  class="txt c1" disabled="disabled"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:200px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:200px;"><a id='lblProduct_st'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_st'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrices'> </a></td>
					<td align="center" style="width:100px;"><a id='lblTotals'> </a></td>
					<td align="center" style="width:100px;">已採購量<br>未採購量</td>
					<td align="center" style="width:200px;">備註<br>訂單號碼/訂序</a></td>
					<td align="center" style="width:60px;">進貨<br>記錄</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNo3.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="btnProduct1.*" type="button" value='.' style="float:left;width:1%;" />
						<input id="btnProduct2.*" type="button" value='.' style="float:left;width:1%;" />
						<input id="btnProduct3.*" type="button" value='.' style="float:left;width:1%;" />
						<input id="txtProductno1.*" type="text" style="float:left;width:80%;"/>
						<input id="txtProductno2.*" type="text" style="float:left;width:80%;"/>
						<input id="txtProductno3.*" type="text" style="float:left;width:80%;"/>
						<input id="txtProductno.*" style="display:none;" />
					</td>
					<td>
					<input id="txtProduct.*" type="text" style="float:left;width:95%;"/>
					</td>
					<td>
					<input id="txtUnit.*" type="text" style="float:left;width:95%;"/>
					</td>
					<td>
					<input id="txtMount.*" type="text" style="float:left;width:95%;text-align: right;"/></td>
					<td>
					<input id="txtPrice.*" type="text" style="float:left;width:95%;text-align: right;"/>
					</td>
					<td>
					<input id="txtTotal.*" type="text" style="float:left;width:95%;text-align: right;"/></td>
					<td>
					<input id="txtC1.*" type="text" style="float:left;width:95%;text-align: right;"/>
					<input id="txtNotv.*" type="text" style="float:left;width:95%;text-align: right;"/>
					</td>
					<td>
					<input id="txtMemo.*" type="text" style="float:left;width:195px;"/>
					<input id="txtOrdeno.*" type="text" style="float:left;width:145px;" />
					<input id="txtNo2.*" type="text" style="float:left;width:40px;" />
					</td>
					<td align="center">
					<input class="btn"  id="btnRc2record.*" type="button" value='.' style=" font-weight: bold;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
