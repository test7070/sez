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
			var q_name = "rc2e";
			var q_readonly = ['txtNoa', 'txtWorker'];
			var q_readonlys = [];
			var bbmNum = [['txtWeight', 15, 3, 1], ['txtTotal', 15, 0, 1]];
			var bbsNum = [['textSize1', 10, 3, 1], ['textSize2', 10, 2, 1], ['textSize3', 10, 3, 1], ['textSize4', 10, 2, 1], ['txtMount', 10, 0, 1], ['txtWeight', 15, 3, 1], ['txtPrice', 10, 2, 1]];
			var bbmMask = [];
			var bbsMask = [['txtStyle', 'A']];
			var bbmKey = ['noa'];
			var bbsKey = ['noa', 'noq'];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'Datea';
			aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx']
			, ['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
			, ['txtUno_', 'btnUno_', 'view_uccc', 'uno', 'txtUno_', 'uccc_seek_b.aspx?;;;1=0', '95%', '60%']
			, ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_', 'ucc_b.aspx']
			, ['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']
			, ['txtSpec_', '', 'spec', 'noa,product', '0txtSpec_,txtSpec_', 'spec_b.aspx', '95%', '95%']);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				q_brwCount();
				q_gt('style', '', 0, 0, 0, '');
				q_gt(q_name, q_content, q_sqlCount, 1, r_accy);
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(1);
			}
			function sum() {
				var tot_Weight = 0;
				var tot_Money = 0;
				var t_Weight, t_Mount, t_Price;
				for (var j = 0; j < q_bbsCount; j++) {
					t_Weight = dec($('#txtWeight_' + j).val());
					t_Mount = dec($('#txtMount_' + j).val());
					t_Price = dec($('#txtPrice_' + j).val());
					tot_Weight += dec($('#txtWeight_' + j).val());
					tot_Money += round((q_mul(q_mul(t_Weight, t_Mount), t_Price)), 0);
				}
				$('#txtWeight').val(tot_Weight);
				$('#txtTotal').val(tot_Money);
			}
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbKind", q_getPara('sys.stktype'));
				//變動尺寸欄位
				$('#cmbKind').change(function() {
					size_change();
				});
			}
			function q_boxClose(s2) {///   q_boxClose 2/4
				var
				ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						///   q_boxClose 3/4
						break;
				}/// end Switch
				b_pop = '';
			}
			var StyleList = '';
			var t_uccArray = new Array;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
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
				Lock(1, {
					opacity : 0
				});
				if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				sum();
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_rc2e') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('rc2e_s.aspx', q_name + '_s', "500px", "360px", q_getMsg("popSeek"));
			}
			function getTheory(b_seq) {
				t_Radius = $('#txtRadius_' + b_seq).val();
				t_Width = $('#txtWidth_' + b_seq).val();
				t_Dime = $('#txtDime_' + b_seq).val();
				t_Lengthb = $('#txtLengthb_' + b_seq).val();
				t_Mount = $('#txtMount_' + b_seq).val();
				t_Style = $('#txtStyle_' + b_seq).val();
				t_Productno = $('#txtProductno_' + b_seq).val();
				var theory_setting = {
					calc : StyleList, ucc : t_uccArray, radius : t_Radius, width : t_Width, dime : t_Dime, lengthb : t_Lengthb, mount : t_Mount, style : t_Style, productno : t_Productno, round : 3
				};
				return theory_st(theory_setting);
			}
			function bbsAssign() {/// 表身運算式
                $('.btnCert').val($('#lblCert_st').text());
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#btnCert_' + j).click(function() {
                            var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                            btnCert_Seq = n;
                            t_where = '';
                            t_uno = $('#txtUno_' + n).val();
                            if (t_uno.length > 0) {
                                t_where = "noa='" + t_uno + "'";
                                q_box("cert_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'cert', "95%", "95%", q_getMsg('popCert'));
                            }
                        });
                        $('#txtUno_' + j).change(function(e) {
                            if ($('#cmbTypea').val() != '2') {
                                var n = $(this).attr('id').replace('txtUno_', '');
                                var t_uno = $.trim($(this).val());
                                var t_noa = $.trim($('#txtNoa').val());
                                q_gt('view_uccb', "where=^^uno='" + t_uno + "' and not(accy='" + r_accy + "' and tablea='rc2s' and noa='" + t_noa + "')^^", 0, 0, 0, 'checkUno_' + n);
                            }
                        });
                        $('#txtMount_' + j).change(function() {
                            sum();
                        });
                        $('#txtWeight_' + j).change(function() {
                            sum();
                        });
                        $('#txtPrice_' + j).change(function() {
                            sum();
                        });
                        $('#txtTotal_' + j).change(function() {
                            sum();
                        });
                        $('#txtStyle_' + j).blur(function() {
                            $('input[id*="txtProduct_"]').each(function() {
                                thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                                $(this).attr('OldValue', $('#txtProductno_' + thisId).val());
                            });
                            var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
                            ProductAddStyle(n);
                            sum();
                        });
                        //計算理論重
                        $('#textSize1_' + j).change(function() {
                            sum();
                        });
                        $('#textSize2_' + j).change(function() {
                            sum();
                        });
                        $('#textSize3_' + j).change(function() {
                            sum();
                        });
                        $('#textSize4_' + j).change(function() {
                            sum();
                        });
                        $('#txtSize_' + j).change(function(e) {
                            if ($.trim($(this).val).length == 0)
                                return;
                            var n = $(this).attr('id').replace('txtSize_', '');
                            var data = tranSize($.trim($(this).val()));
                            $(this).val(tranSize($.trim($(this).val()), 'getsize'));
                            $('#textSize1_' + n).val('');
                            $('#textSize2_' + n).val('');
                            $('#textSize3_' + n).val('');
                            $('#textSize4_' + n).val('');
                            if ($('#cmbKind').val() == 'A1') {//鋼捲鋼板
                                if (!(data.length == 2 || data.length == 3)) {
                                    alert(q_getPara('transize.error01'));
                                    return;
                                }
                                $('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
                                $('#textSize2_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
                                $('#textSize3_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
                                sum();
                            } else if ($('#cmbKind').val() == 'A4') {//鋼胚
                                if (!(data.length == 2 || data.length == 3)) {
                                    alert(q_getPara('transize.error04'));
                                    return;
                                }
                                $('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
                                $('#textSize2_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
                                $('#textSize3_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
                            } else if ($('#cmbKind').val() == 'B2') {//鋼管
                                if (!(data.length == 3 || data.length == 4)) {
                                    alert(q_getPara('transize.error02'));
                                    return;
                                }
                                if (data.length == 3) {
                                    $('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
                                    $('#textSize3_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
                                    $('#textSize4_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
                                } else {
                                    $('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
                                    $('#textSize2_' + n).val((data[1] != undefined ? (data[1].toString().length > 0 ? (isNaN(parseFloat(data[1])) ? 0 : parseFloat(data[1])) : 0) : 0));
                                    $('#textSize3_' + n).val((data[2] != undefined ? (data[2].toString().length > 0 ? (isNaN(parseFloat(data[2])) ? 0 : parseFloat(data[2])) : 0) : 0));
                                    $('#textSize4_' + n).val((data[3] != undefined ? (data[3].toString().length > 0 ? (isNaN(parseFloat(data[3])) ? 0 : parseFloat(data[3])) : 0) : 0));
                                }
                            } else if ($('#cmbKind').val() == 'C3') {//鋼筋
                                if (data.length != 1) {
                                    alert(q_getPara('transize.error03'));
                                    return;
                                }
                                $('#textSize1_' + n).val((data[0] != undefined ? (data[0].toString().length > 0 ? (isNaN(parseFloat(data[0])) ? 0 : parseFloat(data[0])) : 0) : 0));
                            } else {
                                //nothing
                            }
                            sum();
                        });
                    }
                }
                _bbsAssign();
                size_change();
            }
			function btnIns() {
				_btnIns();
				size_change();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#txtDatea').focus();
			}
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtProduct').focus();
				size_change();
			}
			function btnPrint() {
			}
			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			function bbsSave(as) {
				if (!as['uno'] && !as['productno'] && !as['product']) {//不存檔條件
                    as[bbsKey[1]] = '';
                    return;
                }
				q_nowf();
				return true;
			}
			function refresh(recno) {
				_refresh(recno);
				size_change();
				//q_popPost('txtProductno_');
				$('input[id*="txtProduct_"]').each(function() {
					thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
					$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
				});
			}
			function q_popPost(s1) {
				switch (s1) {
					case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function() {
							thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
							$(this).attr('OldValue', $('#txtProductno_' + thisId).val());
						});
						if (trim($('#txtStyle_' + b_seq).val()).length != 0)
							ProductAddStyle(b_seq);
						$('#txtStyle_' + b_seq).focus();
						break;
				}
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
				_btnDele();
			}
			function btnCancel() {
				_btnCancel();
			}
			function size_change() {
                if (q_cur == 1 || q_cur == 2) {
                    $('input[id*="textSize"]').removeAttr('disabled');
                } else {
                    $('input[id*="textSize"]').attr('disabled', 'disabled');
                }
                $('#cmbKind').val((($('#cmbKind').val()) ? $('#cmbKind').val() : q_getPara('vcc.kind')));
                var t_kind = (($('#cmbKind').val()) ? $('#cmbKind').val() : '');
                t_kind = t_kind.substr(0, 1);
                if (t_kind == 'A') {
                    $('#lblSize_help').text(q_getPara('sys.lblSizea'));
                    $('#Size').css('width', '220px');
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).show();
                        $('#textSize2_' + j).show();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).hide();
                        $('#x1_' + j).show();
                        $('#x2_' + j).show();
                        $('#x3_' + j).hide();
                        $('#txtSpec_' + j).css('width', '220px');
                        $('#textSize1_' + j).val($('#txtDime_' + j).val());
                        $('#textSize2_' + j).val($('#txtWidth_' + j).val());
                        $('#textSize3_' + j).val($('#txtLengthb_' + j).val());
                        $('#textSize4_' + j).val(0);
                        $('#txtRadius_' + j).val(0);
                    }
                } else if (t_kind == 'B') {
                    $('#lblSize_help').text(q_getPara('sys.lblSizeb'));
                    $('#Size').css('width', '300px');
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).show();
                        $('#textSize2_' + j).show();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).show();
                        $('#x1_' + j).show();
                        $('#x2_' + j).show();
                        $('#x3_' + j).show();
                        $('#txtSpec_' + j).css('width', '300px');
                        $('#textSize1_' + j).val($('#txtRadius_' + j).val());
                        $('#textSize2_' + j).val($('#txtWidth_' + j).val());
                        $('#textSize3_' + j).val($('#txtDime_' + j).val());
                        $('#textSize4_' + j).val($('#txtLengthb_' + j).val());
                    }
                } else {//鋼筋和鋼胚
                    $('#lblSize_help').text(q_getPara('sys.lblSizec'));
                    $('#Size').css('width', '55px');
                    for (var j = 0; j < q_bbsCount; j++) {
                        $('#textSize1_' + j).hide();
                        $('#textSize2_' + j).hide();
                        $('#textSize3_' + j).show();
                        $('#textSize4_' + j).hide();
                        $('#x1_' + j).hide();
                        $('#x2_' + j).hide();
                        $('#x3_' + j).hide();
                        $('#txtSpec_' + j).css('width', '55px');
                        $('#textSize1_' + j).val(0);
                        $('#txtDime_' + j).val(0);
                        $('#textSize2_' + j).val(0);
                        $('#txtWidth_' + j).val(0);
                        $('#textSize3_' + j).val($('#txtLengthb_' + j).val());
                        $('#textSize4_' + j).val(0);
                        $('#txtRadius_' + j).val(0);
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
                color: black;
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
                width: 1600px;
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
                width: 1600px;
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
    <body ondragstart="return false" draggable="false" ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
        <div style="overflow: auto;display:block;">
            <!--#include file="../inc/toolbar.inc"-->
        </div>
        <div style="overflow: auto;display:block;width:1280px;">
            <div class="dview" id="dview"  >
                <table class="tview" id="tview" >
                    <tr>
                        <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                        <td align="center" style="width:20%"><a id='vewDatea'> </a></td>
                        <td align="center" style="width:25%"><a id='vewTgg'> </a></td>
                    </tr>
                    <tr>
                        <td >
                        <input id="chkBrow.*" type="checkbox" style=' '/>
                        </td>
                        <td align="center" id='datea'>~datea</td>
                        <td align="center" id='tgg,4'>~tgg,4</td>
                    </tr>
                </table>
            </div>
            <div class="dbbm">
                <table class="tbbm" id="tbbm">
                    <tr style="height:1px;"><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td class="tdZ"></td></tr>
                    <tr>
                        <td><span> </span><a id="lblDatea" class="lbl"> </a></td>
                        <td><input id="txtDatea"  type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblNoa" class="lbl"> </a></td>
                        <td><input id="txtNoa"  type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblKind" class="lbl"> </a></td>
                        <td><select id="cmbKind" class="txt c1"></select></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblTggno" class="lbl btn"> </a></td>
                        <td colspan="4">
                            <input id="txtTggno"  type="text" class="txt" style="width:35%;"/>
                            <input id="txtTgg"  type="text" class="txt" style="width:65%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
                        <td colspan="4">
                            <input id="txtCustno"  type="text" class="txt" style="width:35%;"/>
                            <input id="txtComp"  type="text" class="txt" style="width:65%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblTel" class="lbl"> </a></td>
                        <td colspan="4"><input id="txtTel"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblAddr_post" class="lbl"> </a></td>
                        <td colspan="4"><input id="txtAddr_post"  type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblEnda" class="lbl"> </a></td>
                        <td><input id="chkEnda" type="checkbox"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblDeivery_addr" class="lbl"> </a></td>
                        <td colspan="4"><input id="txtDeivery_addr"  type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
                        <td><input id="txtOrdeno"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblWeight" class="lbl"> </a></td>
                        <td><input id="txtWeight"  type="text" class="txt num c1"/></td>
                        <td><span> </span><a id="lblTotal" class="lbl"> </a></td>
                        <td><input id="txtTotal"  type="text" class="txt num c1"/></td>
                        <td><span> </span><a id="lblWorker" class="lbl"> </a></td>
                        <td><input id="txtWorker"  type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMemo" class="lbl"> </a></td>
                        <td colspan="6"><textarea id="txtMemo" cols="5" rows="10" style="width: 99%;height: 50px;"> </textarea></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="dbbs">
            <table id="tbbs" class="tbbs" style="text-align:center">
                <tr style='color:white; background:#003366;'>
                    <td align="center" style="width:30px;"><input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;" /></td>
                    <td align="center" style="width:20px;"></td>
                    <td align="center" style="width:120px;"><a id='lblStoreno_st2'>儲區</a></td>
                    <td align="center" style="width:250px;"><a id='lblUno_st2'>鋼捲編號</a></td>
                    <td align="center" style="width:120px;"><a id='lblProductno_st'> </a></td>
                    <td align="center" style="width:30px;"><a id='lblStyle_st'> </a></td>
                    <td align="center" style="width:100px;"><a id='lblProduct_st'> </a></td>
                    <td align="center" style="width:340px;" id='Size'><a id='lblSize_help'> </a><BR><a id='lblSize_st'> </a></td>
                    <td align="center" style="width:150px;"><a id='lblSizea_st'> </a></td>
                    <td align="center" style="width:50px;"><a id='lblUnit'>單位</a></td>
                    <td align="center" style="width:80px;"><a id='lblMount_st'> </a></td>
                    <td align="center" style="width:80px;"><a id='lblWeights_st'>重量</a></td>
                    <td align="center" style="width:80px;"><a id='lblPrices_st'>單價</a></td>
                    <td align="center" style="width:220px;"><a id='lblMemos_st'>備註</a><br><a id='lblCert_st' style="display:none;"></a></td>
                </tr>
                <tr style='background:#cad3ff;'>
                    <td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td>
						<input class="btn"  id="btnStoreno.*" type="button" value='.' style=" font-weight: bold;width:20px;float:left;" />
						<input type="text" id="txtStoreno.*"  style="width:70px; float:left;"/>
						<span style="display:block; width:20px;float:left;"> </span>
						<input type="text" id="txtStore.*"  style="width:70px; float:left;"/>
                    </td>
                    <td>
						<input id="btnUno.*" type="button" value="." style="float:left;width:20px;display:none;"/>
						<input id="txtUno.*" type="text" style="float:left;width:95%;" />
                    </td>
                    <td>
						<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:20px;float:left;" />
						<input type="text" id="txtProductno.*"  style="width:70%; float:left;"/>
						<span style="display:block; width:20px;float:left;"> </span>
						<input type="text" id="txtClass.*"  style="width:93%; float:left;"/>
					</td>
                    <td><input id="txtStyle.*" type="text" style="width:90%;text-align:center;"/></td>
                    <td><input id="txtProduct.*" type="text" style="width:90%;"/></td>
					<td>
						<input class="txt num" id="textSize1.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x1.*" style="float: left;display:block;width:20px;padding-top: 4px;">x</div>
						<input class="txt num" id="textSize2.*" type="text" style="float: left;width:55px;"  disabled="disabled"/>
						<div id="x2.*" style="float: left;display:block;width:20px;padding-top: 4px;">x</div>
						<input class="txt num" id="textSize3.*" type="text" style="float: left;width:55px;" disabled="disabled"/>
						<div id="x3.*" style="float: left;display:block;width:20px;padding-top: 4px;">x</div>
						<input class="txt num" id="textSize4.*" type="text"  style="float: left;width:55px;" disabled="disabled"/>
						<!--上為虛擬下為實際-->
						<input id="txtRadius.*" type="text" style="display:none;"/>
						<input id="txtWidth.*" type="text" style="display:none;"/>
						<input id="txtDime.*" type="text" style="display:none;"/>
						<input id="txtLengthb.*" type="text" style="display:none;"/>
						<input id="txtSpec.*" type="text" style="float:left;"/>
                    </td>
                    <td><input id="txtSize.*" type="text" style="width:95%;"/></td>
                    <td><input id="txtUnit.*" type="text" style="width:90%;"/></td>
                    <td><input id="txtMount.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td><input id="txtWeight.*" type="text" class="txt num" style="width:95%;"/></td>
                    <td><input id="txtPrice.*" type="text"  class="txt num" style="width:95%;"/></td>
                    <td>
						<input id="txtMemo.*" type="text" style="width:95%;"/>
						<input id="btnCert.*" class="btnCert" type="button" style="width:95%;"/>
                    </td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
 
