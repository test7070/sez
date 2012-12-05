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

		    var q_name = "lab_accc";
		    var q_readonly = ['txtWorker'];
		    var bbmNum = [];
		    var bbmMask = [];
		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'noa';
		    //ajaxPath = ""; //  execute in Root
		    aPop = new Array(['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'],
		    				['txtSalesno', 'lblSalesno', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
		    				['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);

		    $(document).ready(function () {
		        bbmKey = ['noa'];
		        q_brwCount();

		       q_gt(q_name, q_content, q_sqlCount, 1) 

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
		        bbmMask = [ ['txtDatea', r_picd],['txtBdate', r_picd],['txtEdate', r_picd],['txtMon', r_picm]];
		        q_mask(bbmMask);
		        q_cmbParse("cmbTypea", ('').concat(new Array('發票', '會計-營業稅', '會計-營所稅', '會計-綜所稅', '利息收入', '佣金收入', '其他收入', '保證金','票貼','借支','勞健保')));
		        $('#btnAccno').click(function () {
		            q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "97%", "1054px", q_getMsg('btnAccno'), true);
		        });
		        $('#btnPaybno').click(function () {
		             q_box('payb.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtPaybno').val()), '', "97%", "1054px", " ");

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

		        q_box('sss_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
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
		        $('#txtNoa').focus();
		    }

		    function btnModi() {
		        if (emp($('#txtNoa').val()))
		            return;

		        _btnModi(1);   /// ���\�ק�
		        $('#txtComp').focus();
		        $('#txtNoa').attr('disabled', 'disabled');
		    }

		    function btnPrint() {

		    }

		    function btnOk() {
		        var t_noa = $.trim($('#txtNoa').val());
		         $('#txtWorker').val(r_name);
				
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
				width: 4%;
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
				width: 40%;
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
				float: right;
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
						<td align="center" style="width:25%"><a id='vewDatea'></a></td>
						<td align="center" style="width:40%"><a id='vewNoa'></a></td>
						<td align="center" style="width:40%"><a id='vewTypea'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='typea'>~typea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 73%;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr class="tr1">
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2"><input id="txtDatea"  type="text" class="txt c1"/>	</td>
						<td class="tdZ"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td4"><input id="txtNoa" type="text" class="txt c1" />	</td>
						
						<td class="td7"> </td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblMon' class="lbl"></a></td>
						<td class="td2"><input id="txtMon"  type="text" class="txt c1"/>	</td>
						<td class="tdZ"><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td class="td6"><select id="cmbTypea" class="txt c1" > </select></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblBdate' class="lbl"></a></td>
						<td class="td2" ><input id="txtBdate"  type="text" class="txt c1"/></td>
						<td class="tdZ" align="center"><a id="lblSymbol3"  style="font-weight: bold;font-size: 24px;"> </a></td>
						<td class="td3"><input id="txtEdate" type="text" class="txt c1" /></td>
					</tr>
					
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblCustno' class="lbl"></a></td>
						<td class="td2"><input id="txtBcustno" type="text" class="txt c1" /></td>
            			<td class="tdZ" align="center"><a id="lblSymbol2"  style="font-weight: bold;font-size: 24px;"> </a></td>
						<td class="td6"><input id="txtEcustno" type="text" class="txt c1" /></td>
						</tr>
						<tr class="tr3">
						<td class="td1"><span> </span><a id='lblSalesno' class="lbl btn"></a></td>
						<td class="td2" colspan="2"><input id="txtSalesno"  type="text" class="txt c2"/>
							<input id="txtSales"  type="text" class="txt c3"/>	</td>
					
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblPart' class="lbl btn"></a></td>
						<td class="td2" colspan="2"><input id="txtPartno"  type="text" class="txt c2"/>
							<input id="txtPart"  type="text" class="txt c3"/>	</td>
					
					</tr>
					<tr>
							<td class="td5"><span> </span><a id='lblAcc1' class="lbl btn"></a></td>
						<td class="td6" colspan="2"><input id="txtAcc1" type="text" class="txt c2" />
							<input id="txtAcc2" type="text" class="txt c3" />
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblBvccno' class="lbl"></a></td>
						<td class="td2"><input id="txtBvccno"  type="text" class="txt c1"/></td>
						<td class="tdZ" align="center"><a id="lblSymbol"  style="font-weight: bold;font-size: 24px;"> </a></td>
						<td class="td4"><input id="txtEvccno" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td class="td1"><input type="button" id="btnPaybno" class="txt c1 " /></td>
						<td class="td2"><input id="txtPaybno"  type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr5">
						<td class="td1"><input type="button" id="btnAccno" class="txt c1 " /></td>
						<td class="td2"><input id="txtAccno"  type="text" class="txt c1"/></td>
						<td class="tdZ"><span> </span><a id='lblWorker' class="lbl"></a></td>
						<td class="td2"><input id="txtWorker"  type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

