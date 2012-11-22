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

		    var q_name = "sssp";
		    var q_readonly = [ ];
		    var bbmNum = [];
		    var bbmMask = [];
		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'noa';
		    //ajaxPath = ""; //  execute in Root
		    aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtComp', 'acomp_b.aspx'],
		    							['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'],
		    							['txtJobno', 'lblJob', 'salm', 'noa,job', 'txtJobno,txtJob', 'salm_b.aspx']);

		    $(document).ready(function () {
		        bbmKey = ['noa'];
		        q_brwCount();

		        q_gt('authority', "where=^^a.noa='sss' and a.sssno='" + r_userno + "'^^", q_sqlCount, 1)

		    });

		    //////////////////   end Ready
		    function main() {
		        if (dataErr) {
		            dataErr = false;
		            return;
		        }
		        mainForm(0);
		        // 1=Last  0=Top
		    } ///  end Main()

		    function mainPost() {
		        q_getFormat();
		        bbmMask = [['txtBirthday', r_picd], ['txtFt_date', r_picd], ['txtIndate', r_picd], ['txtOutdate', r_picd], ['txtMobile1', '9999999999'], ['txtMobile2', '9999999999'], ['txtHealth_bdate', r_picd], ['txtHealth_edate', r_picd], ['txtLabor1_bdate', r_picd], ['txtLabor1_edate', r_picd], ['txtLabor2_bdate', r_picd], ['txtLabor2_edate', r_picd]];
		        q_mask(bbmMask);
		        
		        q_cmbParse("cmbTypea", q_getPara('sss.typea'));
		        q_cmbParse("cmbSex", q_getPara('sss.sex'));
		        q_cmbParse("cmbPerson", q_getPara('person.typea'));
		        q_cmbParse("cmbRecord", ('').concat(new Array('��p', '�ꤤ', '����', '��¾', '�j�M', '�j��', '�Ӥh', '�դh')));
		        q_cmbParse("cmbBlood", ('').concat(new Array('A', 'B', 'AB', 'O')));
		        $('#btnLabases').click(function (e) {
		            q_box("labases_b.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'labases', "850px", "600px", q_getMsg("popLabases"));
		        });
		        $('#btnSaladjust').click(function (e) {
		            q_box("salAdjust.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'saladjust', "850px", "600px", q_getMsg("popSaladjust"));
		        });

		        $('#txtIndate').change(function (e) {
		            if (!emp($('#txtIndate').val())) {
		                $('#txtHealth_bdate').val($('#txtIndate').val());
		                $('#txtLabor1_bdate').val($('#txtIndate').val());
		                $('#txtLabor2_bdate').val($('#txtIndate').val());
		            }
		        });
		        $('#txtOutdate').change(function (e) {
		            if (!emp($('#txtOutdate').val())) {
		                $('#txtHealth_edate').val($('#txtOutdate').val());
		                $('#txtLabor1_edate').val($('#txtOutdate').val());
		                $('#txtLabor2_edate').val($('#txtOutdate').val());
		            }
		        });
		    }

		    function txtCopy(dest, source) {
		        var adest = dest.split(',');
		        var asource = source.split(',');
		        $('#' + adest[0]).focus(function () {
		            if (trim($(this).val()).length == 0)
		                $(this).val(q_getMsg('msgCopy'));
		        });
		        $('#' + adest[0]).focusout(function () {
		            var t_copy = ($(this).val().substr(0, 1) == '=');
		            var t_clear = ($(this).val().substr(0, 2) == ' =');
		            for (var i = 0; i < adest.length; i++) {

		                {
		                    if (t_copy)
		                        $('#' + adest[i]).val($('#' + asource[i]).val());

		                    if (t_clear)
		                        $('#' + adest[i]).val('');
		                }
		            }
		        });
		    }

		    function q_boxClose(s2) {
		        var ret;
		        switch (b_pop) {
		            case 'conn':
		                break;

		            case 'sss':
		                ret = getb_ret();
		                if (q_cur > 0 && q_cur < 4)
		                    q_browFill('txtSalesno,txtSales', ret, 'noa,namea');
		                break;

		            case 'sss':
		                ret = getb_ret();
		                if (q_cur > 0 && q_cur < 4)
		                    q_browFill('txtGrpno,txtGrpname', ret, 'noa,comp');
		                break;

		            case q_name + '_s':
		                q_boxClose2(s2);
		                ///   q_boxClose 3/4
		                break;
		        }   /// end Switch
		    }

		    function q_gtPost(t_name) {
		        switch (t_name) {
		            case 'authority':
		                var as = _q_appendData('authority', '', true);
		                if (as.length > 0 && as[0]["pr_run"] == "true")
		                    q_content = "";
		                else
		                    q_content = "where=^^noa='" + r_userno + "'^^";

		                q_gt(q_name, q_content, q_sqlCount, 1)
		                break;
		            case 'sss':
		                q_changeFill(t_name, ['txtSalesno', 'txtSales'], ['noa', 'namea']);
		                break;

		            case q_name:
		                if (q_cur == 4)
		                    q_Seek_gtPost();

		                if (q_cur == 1 || q_cur == 2)
		                    q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

		                break;
		        }  /// end switch
		    }

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)// 1-3
		            return;

		        q_box('sssp_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
		    }

		    function combPay_chg() {
		        var cmb = document.getElementById("combPay")
		        if (!q_cur)
		            cmb.value = '';
		        else
		            $('#txtPay').val(cmb.value);
		        cmb.value = '';
		    }

		    function btnIns() {
		        _btnIns();
		       $('#cmbTypea').val('寄保');
		        $('#txtNoa').focus();
		        $('#cmbTypea').attr('disabled', 'disabled');
		            	$('#cmbTypea').css('background', t_background2);
		    }

		    function btnModi() {
		        if (emp($('#txtNoa').val()))
		            return;

		        _btnModi(1);   /// ���\�ק�
		        $('#txtComp').focus();
		        $('#txtNoa').attr('disabled', 'disabled');
		        $('#cmbTypea').attr('disabled', 'disabled');
		            	$('#cmbTypea').css('background', t_background2);
		    }

		    function btnPrint() {

		    }

		    function btnOk() {
		        var t_noa = $.trim($('#txtNoa').val());
				
				if(!emp($('#txtId').val()))
               		$('#txtId').val($('#txtId').val().toUpperCase());
				
		        if (t_noa.length == 0)
		            q_gtnoa(q_name, t_noa);
		        else
		            wrServer(t_noa);
		    }

		    function wrServer(key_value) {
		        var i;

		        xmlSql = '';
		        if (q_cur == 2)/// popSave
		            xmlSql = q_preXml();

		        $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
		        _btnOk(key_value, bbmKey[0], '', '', 2);
		    }

		    function refresh(recno) {
		        _refresh(recno);
		    }

		    function readonly(t_para, empty) {
		        _readonly(t_para, empty);
		    }

		    function btnMinus(id) {
		        _btnMinus(id);
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
				width: 36%;
				float: right;
			}
			.txt.c3 {
				width: 62%;
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
				width: 25%;
			}
			.txt.c7 {
				width: 95%;
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
			.tbbm td input[type="button"] {
				float: left;
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.tbbm select {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left;  width:25%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:25%"><a id='vewNoa'></a></td>
						<td align="center" style="width:40%"><a id='vewNamea'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='namea'>~namea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 73%;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr>
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td class="td2"><input id="txtNoa"  type="text" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblNamea' class="lbl"></a></td>
						<td class="td4"><input id="txtNamea" type="text" class="txt c1" />	</td>
						<td class="td5"><span> </span><a id="lblPerson" class="lbl"></a></td>
            			<td class="td6"><select id="cmbPerson" class="txt c1"></select></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblId' class="lbl"></a></td>
						<td class="td2"><input id="txtId"  type="text"  class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblBirthday' class="lbl"></a></td>
						<td class="td4"><input id="txtBirthday"  type="text" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblBlood' class="lbl"></a></td>
						<td class="td6"><select id="cmbBlood" class="txt c2" style="width: 50%;float: left;"></select></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblSex' class="lbl"></a></td>
						<td class="td2"><select id="cmbSex" class="txt c1"></select></td>
						<td class="td3"><span> </span><a id='lblTel' class="lbl"></a></td>
						<td class="td4"><input id="txtTel" type="text"  class="txt c1"/></td>
						<td class="td5 num"><input id="chkMarried" type="checkbox"/>	</td>
						<td class="td6"><a id='vewMarried'></a></td>
						<!--<td class="td5 num">
						<input id="chkIsclerk" type="checkbox" style=" "/>
						</td>
						<td class="td6"><a id='vewIsclerk' ></a></td>-->
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMobile1' class="lbl"></a></td>
						<td class="td2"><input id="txtMobile1" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblMobile2' class="lbl"></a></td>
						<td class="td4"><input id="txtMobile2"  type="text"  class="txt c1"/></td>
						<td class="td5 num"><input id="chkIswelfare" type="checkbox" style=" "/>	</td>
						<td class="td6"><a id='vewIswelfare'></a></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTypea' class="lbl"></a></td>
						<td class="td2"><select id="cmbTypea" class="txt c1"></select></td>
						<td class="td3"><span> </span><a id='lblFt_date' class="lbl"></a></td>
						<td class="td4"><input id="txtFt_date" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblIndate' class="lbl"></a></td>
						<td class="td2"><input id="txtIndate" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblOutdate' class="lbl"></a></td>
						<td class="td4"><input id="txtOutdate"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblHealth_bdate' class="lbl"></a></td>
						<td class="td2"><input id="txtHealth_bdate" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblHealth_edate' class="lbl"></a></td>
						<td class="td4"><input id="txtHealth_edate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblLabor1_bdate' class="lbl"></a></td>
						<td class="td2"><input id="txtLabor1_bdate" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblLabor1_edate' class="lbl"></a></td>
						<td class="td4"><input id="txtLabor1_edate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblLabor2_bdate' class="lbl"></a></td>
						<td class="td2"><input id="txtLabor2_bdate" type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblLabor2_edate' class="lbl"></a></td>
						<td class="td4"><input id="txtLabor2_edate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblPart" class="lbl btn"></a></td>
						<td class="td2">
							<input id="txtPartno"  type="text" class="txt c2"/>
							<input id="txtPart"  type="text" class="txt c3"/>
						</td>
						<td class="td3"><span> </span><a id='lblJob' class="lbl btn"></a></td>
						<td class="td4">
							<input id="txtJobno"  type="text" class="txt c2" />
							<input id="txtJob"  type="text" class="txt c3" />	
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAcomp' class="lbl btn" ></a></td>
						<td class="td2" colspan="3">
							<input id="txtCno"type="text" class="txt c2" style="width: 30%"/>
							<input id="txtComp"  type="text"  class="txt c3" style="width: 69%"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblRecord' class="lbl"></a></td>
						<td class="td2">
							<!--<select id="cmbRecord" class="txt c2"></select>-->
							<input id="txtSchool" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblAccount' class="lbl"></a></td>
						<td class="td4"><input id="txtAccount"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblAddr_home" class="lbl"></a></td>
						<td class="td2" colspan="5">
							<input id="txtAddr_home"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblAddr_conn" class="lbl"></a></td>
						<td class="td2" colspan="5">
							<input id="txtAddr_conn"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td class="td1"></td>
						<td class="td2"></td>
						<td class="td4"><input id='btnLabases' type="button" /></td>
						<td class="td5"></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

