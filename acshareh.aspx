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
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "acshareh";
            var q_readonly = [];
            var q_readonlys = ['txtC3', 'txtD2', 'txtF', 'txtTotal'];
            var bbmNum = new Array();
            var bbsNum = new Array();
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            //ajaxPath = "";
            q_desc = 1;
            brwCount2 = 3;
            /*			var defaultTxt = ['期初餘額','員工股票紅利','本期損益','盈餘指撥及分配','提列法定盈餘公積','普通股現金股利'
             ,'備供出售金融資產未實現損益增減','外幣財務報表換算所產生兌換差額增減','採權益法評價之被投資公司股權淨值增減','期末餘額'];*/
            var defaultTxt = ['期初餘額',
							  '採用權益法認列之關聯企業之變動數', 
							  '淨利', 
							  '稅後其他綜和損益', 
							  '綜和損益總和',
							  '盈餘指撥及分配：提列法定盈餘公積', 
							  '　　　　　　　：普通股現金股利',
							  '盈餘指撥及分配總合',
							  '現金增資', 
							  '可轉換公司債轉換', 
							  '發放予子公司股利調整資本公積', 
							  '取得或處分公司股權價格與帳面價值差額', 
							  '對子公司所有權權益變動', 
							  '股份基礎給付交易', 
							  '取得子公司所增加之非控制權益', 
							  '子公司股東現金股利', 
							  '子公司員工認股權', 
							  '期末餘額'];
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
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

            function pop(form) {
                b_pop = form;
            }

            function mainPost() {
                q_getFormat();
                q_mask(bbmMask);

                $('#btnImport').click(function(e) {
                    if ($.trim($('#txtNoa').val()).length > 0)
                        q_gt('acshareh_import', '', 0, 0, 0, "", $.trim($('#txtNoa').val()-1911) + '_' + r_cno);
                    else
                        alert('請輸入' + q_getMsg('lblNoa'));
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'acshareh_import':
                        var as = _q_appendData("acccs", "", true);
                        if (as[0] != undefined) {
                            for (var i = 0; i < q_bbsCount; i++) {
                                if ($('#txtTxt_' + i).val() == defaultTxt[0]) {
                                    $('#txtA_' + i).val(as[0].a);
                                    $('#txtA1_' + i).val(as[0].a1);
                                    $('#txtB_' + i).val(as[0].b);
                                    $('#txtC_' + i).val(as[0].c);
                                    $('#txtC1_' + i).val(as[0].c1);
                                    $('#txtC2_' + i).val(as[0].c2);
                                    $('#txtC3_' + i).val(as[0].c3);
                                    $('#txtD_' + i).val(as[0].d);
                                    $('#txtD1_' + i).val(as[0].d1);
                                    $('#txtD2_' + i).val(as[0].d2);
                                    $('#txtE_' + i).val(as[0].e);
                                    $('#txtF_' + i).val(as[0].f);
                                    $('#txtG_' + i).val(as[0].g);
                                    break;
                                }
                            }
                            sum();
                        }
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                        break;
                }  /// end switch
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }

            function btnOk() {
                Lock(1, {
                    opacity : 0
                });
                sum();
                var t_noa = trim($('#txtNoa').val());
                wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('acshaerh_s.aspx', q_name + '_s', "550px", "560px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                        $('#txtA_' + i).change(function(e) {
                            sum();
                        });
                        $('#txtA1_' + i).change(function(e) {
                            sum();
                        });
                        $('#txtB_' + i).change(function(e) {
                            sum();
                        });
                        $('#txtC_' + i).change(function(e) {
                            sum();
                        });
                        $('#txtC1_' + i).change(function(e) {
                            sum();
                        });
                        $('#txtC2_' + i).change(function(e) {
                            sum();
                        });
                        $('#txtC3_' + i).change(function(e) {
                            sum();
                        });
                        $('#txtD_' + i).change(function(e) {
                            sum();
                        });
                        $('#txtD1_' + i).change(function(e) {
                            sum();
                        });
                        $('#txtD2_' + i).change(function(e) {
                            sum();
                        });
                        $('#txtE_' + i).change(function(e) {
                            sum();
                        });
                        $('#txtF_' + i).change(function(e) {
                            sum();
                        });
                        $('#txtG_' + i).change(function(e) {
                            sum();
                        });
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                while (q_bbsCount < defaultTxt.length) {
                    $('#btnPlus').click();
					$('#txtNoa').val(r_accya);
					var t_date = new Date();
					var r_accya = t_date.getFullYear();
                }
                for (var i = 0; i < defaultTxt.length; i++)
                    $('#txtTxt_' + i).val(defaultTxt[i]);
            }
			

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                if (q_chkClose())
                    return;
                _btnModi();
                sum();
            }

            function btnPrint() {
                q_box("z_accc3.aspx?;;;;" + r_accy, 'z_accc3', "95%", "95%", q_getMsg("popAccc3"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['txt']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function q_popPost(t_id) {
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                var endN = -1;
                for (var i = 0; i < q_bbsCount; i++) {
                    if ($('#txtTxt_' + i).val() == defaultTxt[defaultTxt.length - 1]) {
                        endN = i;
                        $('#txtA_' + i).val(0);
                        $('#txtA1_' + i).val(0);
                        $('#txtB_' + i).val(0);
                        $('#txtC_' + i).val(0);
                        $('#txtC1_' + i).val(0);
                        $('#txtC2_' + i).val(0);
                        $('#txtC3_' + i).val(0);
                        $('#txtD_' + i).val(0);
                        $('#txtD1_' + i).val(0);
                        $('#txtD2_' + i).val(0);
                        $('#txtE_' + i).val(0);
                        $('#txtF_' + i).val(0);
                        $('#txtG_' + i).val(0);
                        break;
                    }
                }
                if (endN >= 0) {
                    for (var i = 0; i < q_bbsCount; i++) {
                        if (i != endN) {
                            /*$('#txtA_' + endN).val(q_float('txtA_' + endN) + q_float('txtA_' + i));
                            $('#txtA1_' + endN).val(q_float('txtA1_' + endN) + q_float('txtA1_' + i));
                            $('#txtB_' + endN).val(q_float('txtB_' + endN) + q_float('txtB_' + i));
                            $('#txtC_' + endN).val(q_float('txtC_' + endN) + q_float('txtC_' + i));
                            $('#txtC1_' + endN).val(q_float('txtC1_' + endN) + q_float('txtC1_' + i));
                            $('#txtC2_' + endN).val(q_float('txtC2_' + endN) + q_float('txtC2_' + i));
							$('#txtC3_' + endN).val(q_float('txtC3_' + endN) + q_float('txtC3_' + i));
                            $('#txtD_' + endN).val(q_float('txtD_' + endN) + q_float('txtD_' + i));
							$('#txtD1_' + endN).val(q_float('txtD1_' + endN) + q_float('txtD1_' + i));
                            $('#txtD2_' + endN).val(q_float('txtD2_' + endN) + q_float('txtD2_' + i));
                            $('#txtE_' + endN).val(q_float('txtE_' + endN) + q_float('txtE_' + i));
                            $('#txtF_' + endN).val(q_float('txtF_' + endN) + q_float('txtF_' + i));
                            $('#txtG_'+endN).val(q_float('txtG_'+endN)+q_float('txtG_'+i));*/
							
							$('#txtA_4').val(q_float('txtA_2')+q_float('txtA_3'));
							$('#txtA_7').val(q_float('txtA_5')+q_float('txtA_6'));
							$('#txtA_'+endN).val(q_float('txtA_0')+q_float('txtA_1')+q_float('txtA_4')+q_float('txtA_7')+q_float('txtA_8')+q_float('txtA_9')+
												 q_float('txtA_10')+q_float('txtA_11')+q_float('txtA_12')+q_float('txtA_13')+q_float('txtA_14')+q_float('txtA_15')+
												 q_float('txtA_16'));
							$('#txtA1_4').val(q_float('txtA1_2')+q_float('txtA1_3'));
							$('#txtA1_7').val(q_float('txtA1_5')+q_float('txtA1_6'));
							$('#txtA1_'+endN).val(q_float('txtA1_0')+q_float('txtA1_1')+q_float('txtA1_4')+q_float('txtA1_7')+q_float('txtA1_8')+q_float('txtA1_9')+
												  q_float('txtA1_10')+q_float('txtA1_11')+q_float('txtA1_12')+q_float('txtA1_13')+q_float('txtA1_14')+q_float('txtA1_15')+
												  q_float('txtA1_16'));
							$('#txtB_4').val(q_float('txtB_2')+q_float('txtB_3'));
							$('#txtB_7').val(q_float('txtB_5')+q_float('txtB_6'));
							$('#txtB_'+endN).val(q_float('txtB_0')+q_float('txtB_1')+q_float('txtB_4')+q_float('txtB_7')+q_float('txtB_8')+q_float('txtB_9')+
												 q_float('txtB_10')+q_float('txtB_11')+q_float('txtB_12')+q_float('txtB_13')+q_float('txtB_14')+q_float('txtB_15')+
												 q_float('txtB_16'));
							$('#txtC_4').val(q_float('txtC_2')+q_float('txtC_3'));
							$('#txtC_7').val(q_float('txtC_5')+q_float('txtC_6'));
							$('#txtC_'+endN).val(q_float('txtC_0')+q_float('txtC_1')+q_float('txtC_4')+q_float('txtC_7')+q_float('txtC_8')+q_float('txtC_9')+
												 q_float('txtC_10')+q_float('txtC_11')+q_float('txtC_12')+q_float('txtC_13')+q_float('txtC_14')+q_float('txtC_15')+
												 q_float('txtC_16'));
							$('#txtC1_4').val(q_float('txtC1_2')+q_float('txtC1_3'));
							$('#txtC1_7').val(q_float('txtC1_5')+q_float('txtC1_6'));
							$('#txtC1_'+endN).val(q_float('txtC1_0')+q_float('txtC1_1')+q_float('txtC1_4')+q_float('txtC1_7')+q_float('txtC1_8')+q_float('txtC1_9')+
												  q_float('txtC1_10')+q_float('txtC1_11')+q_float('txtC1_12')+q_float('txtC1_13')+q_float('txtC1_14')+q_float('txtC1_15')+
												  q_float('txtC1_16'));
							$('#txtC2_4').val(q_float('txtC2_2')+q_float('txtC2_3'));
							$('#txtC2_7').val(q_float('txtC2_5')+q_float('txtC2_6'));
							$('#txtC2_'+endN).val(q_float('txtC2_0')+q_float('txtC2_1')+q_float('txtC2_4')+q_float('txtC2_7')+q_float('txtC2_8')+q_float('txtC2_9')+
												  q_float('txtC2_10')+q_float('txtC2_11')+q_float('txtC2_12')+q_float('txtC2_13')+q_float('txtC2_14')+q_float('txtC2_15')+
												  q_float('txtC2_16'));
							$('#txtC3_4').val(q_float('txtC3_2')+q_float('txtC3_3'));
							$('#txtC3_7').val(q_float('txtC3_5')+q_float('txtC3_6'));
							$('#txtC3_'+endN).val(q_float('txtC3_0')+q_float('txtC3_1')+q_float('txtC3_4')+q_float('txtC3_7')+q_float('txtC3_8')+q_float('txtC3_9')+
												  q_float('txtC3_10')+q_float('txtC3_11')+q_float('txtC3_12')+q_float('txtC3_13')+q_float('txtC3_14')+q_float('txtC3_15')+
												  q_float('txtC3_16'));
							$('#txtD_4').val(q_float('txtD_2')+q_float('txtD_3'));
							$('#txtD_7').val(q_float('txtD_5')+q_float('txtD_5'));
							$('#txtD_'+endN).val(q_float('txtD_0')+q_float('txtD_1')+q_float('txtD_4')+q_float('txtD_7')+q_float('txtD_8')+q_float('txtD_9')+
												 q_float('txtD_10')+q_float('txtD_11')+q_float('txtD_12')+q_float('txtD_13')+q_float('txtD_14')+q_float('txtD_15')+
												 q_float('txtD_16'));
							$('#txtD1_4').val(q_float('txtD1_2')+q_float('txtD1_3'));
							$('#txtD1_7').val(q_float('txtD1_5')+q_float('txtD1_6'));
							$('#txtD1_'+endN).val(q_float('txtD1_0')+q_float('txtD1_1')+q_float('txtD1_4')+q_float('txtD1_7')+q_float('txtD1_8')+q_float('txtD1_9')+
												  q_float('txtD1_10')+q_float('txtD1_11')+q_float('txtD1_12')+q_float('txtD1_13')+q_float('txtD1_14')+q_float('txtD1_15')+
												  q_float('txtD1_16'));
							$('#txtD2_4').val(q_float('txtD2_2')+q_float('txtD2_3'));
							$('#txtD2_7').val(q_float('txtD2_5')+q_float('txtD2_6'));
							$('#txtD2_'+endN).val(q_float('txtD2_0')+q_float('txtD2_1')+q_float('txtD2_4')+q_float('txtD2_7')+q_float('txtD2_8')+q_float('txtD2_9')+
												  q_float('txtD2_10')+q_float('txtD2_11')+q_float('txtD2_12')+q_float('txtD2_13')+q_float('txtD2_14')+q_float('txtD2_15')+
												  q_float('txtD2_16'));
							$('#txtE_4').val(q_float('txtE_2')+q_float('txtE_3'));
							$('#txtE_7').val(q_float('txtE_5')+q_float('txtE_6'));
							$('#txtE_'+endN).val(q_float('txtE_0')+q_float('txtE_1')+q_float('txtE_4')+q_float('txtE_7')+q_float('txtE_8')+q_float('txtE_9')+
												 q_float('txtE_10')+q_float('txtE_11')+q_float('txtE_12')+q_float('txtE_13')+q_float('txtE_14')+q_float('txtE_15')+
												 q_float('txtE_16'));
							$('#txtF_4').val(q_float('txtF_2')+q_float('txtF_3'));
							$('#txtF_7').val(q_float('txtF_5')+q_float('txtF_6'));
							$('#txtF_'+endN).val(q_float('txtF_0')+q_float('txtF_1')+q_float('txtF_4')+q_float('txtF_7')+q_float('txtF_8')+q_float('txtF_9')+
												 q_float('txtF_10')+q_float('txtF_11')+q_float('txtF_12')+q_float('txtF_13')+q_float('txtF_14')+q_float('txtF_15')+
												 q_float('txtF_16'));
							$('#txtG_4').val(q_float('txtG_2')+q_float('txtG_3'));
							$('#txtG_7').val(q_float('txtG_5')+q_float('txtG_6'));
							$('#txtG_'+endN).val(q_float('txtG_0')+q_float('txtG_1')+q_float('txtG_4')+q_float('txtG_7')+q_float('txtG_8')+q_float('txtG_9')+
												 q_float('txtG_10')+q_float('txtG_11')+q_float('txtG_12')+q_float('txtG_13')+q_float('txtG_14')+q_float('txtG_15')+
												 q_float('txtG_16'));
                        }
                    }
                }
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#txtC3_' + i).val(+q_float('txtC_' + i) + q_float('txtC1_' + i) + q_float('txtC2_' + i));
                    $('#txtD2_' + i).val(+q_float('txtD_' + i) + q_float('txtD1_' + i));
                    $('#txtF_' + i).val(q_float('txtA_' + i) + q_float('txtB_' + i) + q_float('txtC3_' + i) + q_float('txtD2_' + i) + q_float('txtE_' + i));
                    $('#txtTotal_' + i).val(q_float('txtF_' + i) + q_float('txtG_' + i));
                }
            }

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
                if (q_chkClose())
                    return;
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
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
                return Math.round(this * Math.pow(10, arg)) / Math.pow(10, arg);
            }
            Number.prototype.div = function(arg) {
                return accDiv(this, arg);
            }
            function accDiv(arg1, arg2) {
                var t1 = 0, t2 = 0, r1, r2;
                try {
                    t1 = arg1.toString().split(".")[1].length
                } catch (e) {
                }
                try {
                    t2 = arg2.toString().split(".")[1].length
                } catch (e) {
                }
                with (Math) {
                    r1 = Number(arg1.toString().replace(".", ""))
                    r2 = Number(arg2.toString().replace(".", ""))
                    return (r1 / r2) * pow(10, t2 - t1);
                }
            }
            Number.prototype.mul = function(arg) {
                return accMul(arg, this);
            }
            function accMul(arg1, arg2) {
                var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
                try {
                    m += s1.split(".")[1].length
                } catch (e) {
                }
                try {
                    m += s2.split(".")[1].length
                } catch (e) {
                }
                return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
            }


            Number.prototype.add = function(arg) {
                return accAdd(arg, this);
            }
            function accAdd(arg1, arg2) {
                var r1, r2, m;
                try {
                    r1 = arg1.toString().split(".")[1].length
                } catch (e) {
                    r1 = 0
                }
                try {
                    r2 = arg2.toString().split(".")[1].length
                } catch (e) {
                    r2 = 0
                }
                m = Math.pow(10, Math.max(r1, r2))
                return (arg1 * m + arg2 * m) / m
            }


            Number.prototype.sub = function(arg) {
                return accSub(this, arg);
            }
            function accSub(arg1, arg2) {
                var r1, r2, m, n;
                try {
                    r1 = arg1.toString().split(".")[1].length
                } catch (e) {
                    r1 = 0
                }
                try {
                    r2 = arg2.toString().split(".")[1].length
                } catch (e) {
                    r2 = 0
                }
                m = Math.pow(10, Math.max(r1, r2));
                n = (r1 >= r2) ? r1 : r2;
                return parseFloat(((arg1 * m - arg2 * m) / m).toFixed(n));
            }
        </script>
        <style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 110px;
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
				width: 480px;
				/*border-radius: 5px;
				 margin: -1px;
				 border: 1px black solid;*/
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
			.tbbm .trX {
				background-color: #FFEC8B;
			}
			.tbbm .trY {
				background-color: #DAA520;
			}
			.tbbm .tdZ {
				width: 1%;
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
			}
			.dbbs {
				width: 100%;
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
        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();" >
        <!--#include file="../inc/toolbar.inc"-->
        <div id="dmain">
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id="vewNoa"> </a></td>
                    </tr>
                    <tr>
                        <td >
                        <input id="chkBrow.*" type="checkbox"/>
                        </td>
                        <td id="noa" style="text-align: center;">~noa</td>
                    </tr>
                </table>
            </div>
            <div class="dbbm">
                <table class="tbbm" id="tbbm">
                    <tr style="height:1px;">
                        <td colspan="4"></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblNoa" class="lbl"> </a></td>
                        <td>
                        <input id="txtNoa" type="text" class="txt c1"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4"></td>
                        <td>
                        <input id="btnImport" type="button" class="txt c1" value="匯入期初"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class='dbbs'>
            <table id="tbbs" class='tbbs' style="width:1830px;">
                <tr style='color:white; background:#003366;' >
                    <td align="center" style="width:30px;">
                    <input class="btn"  id="btnPlus" type="button" value="+" style="font-weight: bold;" />
                    </td>
                    <td align="center" style="width:20px;"></td>

                    <td align="center" style="width:310px;"><a id='lblTxt_s'>項　　　目</a></td>
                    <td align="center" style="width:180px;" colspan="2"><a id='lblA_s' tag="3110.">普通股股本<hr>股數(千股) ｜ 金　　　額</a></td>
                    <td align="center" style="width:100px;"><a id='lblB_s' tag="3300.">資本公積</a></td>
                    <td style="width:380px;" colspan="4"><a id='lblC_s' tag="3410.">　　　　　　　　　保　留　盈　餘　　　　　　　　　
																				<hr>法定盈餘公積｜特別盈餘公積｜未分配盈餘｜合　　　計</a></td>
                    <td style="width:380px;" colspan="3"><a id='lblD_s'>　　　　其　他　權　益　項　目　　　 
																</a><hr>國外營運機構｜ 備供出售　 ｜
																	<br>財務報表換算｜ 金融資產　 ｜　合　 計
																	<br>之兌換差額　｜ 未實現損益 ｜</td>
                    <td align="center" style="width:100px;"><a id='lblE_s' tag="3500.">庫藏股票</a></td>
                    <td align="center" style="width:100px;"><a id='lblF_s'>總　　計</a></td>
                    <td align="center" style="width:100px;"><a id='lblG_s'>非控制權益</a></td>
                    <td align="center" style="width:100px;"><a id='lblTotal_s'>股東權益合計</a></td>
                </tr>
                <tr style='background:#cad3ff;'>
                    <td align="center">
						<input class="btn" id="btnMinus.*" type="button" value="-" style=" font-weight: bold;" />
						<input id="txtNoq.*" style="display:none;"/>
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>

                    <td><input class="txt" id="txtTxt.*" type="text" style="width:95%;"/></td>
                    <td><input id="txtA1.*" type="text" style="width:95%;text-align:right;"/></td>
                    <td><input id="txtA.*" type="text" style="width:95%;text-align:right;"/></td>
                    <td><input id="txtB.*" type="text" style="width:95%;text-align:right;"/></td>
                    <td><input id="txtC.*" type="text" style="width:95%;text-align:right;"/></td>
                    <td><input id="txtC1.*" type="text" style="width:95%;text-align:right;"/></td>
                    <td><input id="txtC2.*" type="text" style="width:95%;text-align:right;"/></td>
                    <td><input id="txtC3.*" type="text" style="width:95%;text-align:right;"/></td>
                    <td><input id="txtD.*" type="text" style="width:95%;text-align:right;"/></td>
                    <td><input id="txtD1.*" type="text" style="width:95%;text-align:right;"/></td>
                    <td><input id="txtD2.*" type="text" style="width:95%;text-align:right;"/></td>
                    <td><input id="txtE.*" type="text" style="width:95%;text-align:right;"/></td>
                    <td><input id="txtF.*" type="text" style="width:95%;text-align:right;"/></td>
                    <td><input id="txtG.*" type="text" style="width:95%;text-align:right;"/></td>
                    <td><input id="txtTotal.*" type="text" style="width:95%;text-align:right;"/></td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>