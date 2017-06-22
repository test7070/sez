<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
		    this.errorHandler = null;
		    function onPageError(error) {
		        alert("An error occurred:\r\n" + error.Message);
		    }
		    var q_name = "tranprice";
		    var q_readonly = [];
		    var bbmNum = new Array(['txtPricecust', 10, 3], ['txtPricedriver', 10, 3], ['txtPricecar', 10, 3]);
		    var bbmMask = new Array(['txtKdate', '999/99/99'], ['txtDatea', '999/99/99']);
		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'noa';
		    q_alias = 'a';
		    aPop = new Array(['txtStraddno', 'lblStradd', 'addr', 'noa,addr', 'txtStraddno,txtStradd', 'addr_b.aspx'],
		    ['txtEndaddno', 'lblEndadd', 'addr', 'noa,addr', 'txtEndaddno,txtEndadd', 'addr_b.aspx']);
		    $(document).ready(function () {
		        bbmKey = ['noa'];
		        q_brwCount();
		        q_gt(q_name, q_content, q_sqlCount, 1)
		    });
		    function main() {
		        if (dataErr) {
		            dataErr = false;
		            return;
		        }
		        mainForm(0);
		    }

		    function q_funcPost(t_func, result) {
		    	q_mask(bbmMask);
		        if (result.substr(0, 5) == '<Data') {
		            var tmp = _q_appendData('carteam', '', true);
		            var value = '';
		            for (var z = 0; z < tmp.length; z++) {
		                value = value + (value.length > 0 ? ',' : '') + tmp[z].noa + '@' + tmp[z].team;
		            }
		            q_cmbParse("cmbCarteamno", value);
		            refresh(q_recno);
		        } else
		            alert('Error!' + '\r' + t_func + '\r' + result);
		    }

		    function mainPost() {
		       // fbbm[fbbm.length] = 'txtMemo';
		      //  q_cmbParse("cmbCalctype", q_getPara('trans.calctype'));
		      //  q_cmbParse("cmbTtype", q_getPara('trans.ttype'));
		       // q_func('car2.getItem', '3,4,5');
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
		            case q_name + '_s':
		                q_boxClose2(s2);
		                break;
		        }
		    }

		    function q_gtPost(t_name) {

		        switch (t_name) {
		            case q_name:
		                if (q_cur == 4)
		                    q_Seek_gtPost();

		                if (q_cur == 1 || q_cur == 2)
		                    q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

		                break;
		        }
		    }

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)
		            return;

		        q_box('tranprice_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
		    }

		    function btnIns() {
		        _btnIns();
		        $('#txtNoa').focus();
		    }

		    function btnModi() {
		        if (emp($('#txtNoa').val()))
		            return;
		        _btnModi();
		    }

		    function btnPrint() {

		    }

		    function btnOk() {
		        var t_err = '';
		        t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')]]);

		        if (t_err.length > 0) {
		            alert(t_err);
		            return;
		        }
		        var t_noa = trim($('#txtNoa').val());

		        if (t_noa.length == 0)
		            q_gtnoa(q_name, t_noa);
		        else
		            wrServer(t_noa);
		    }

		    function wrServer(key_value) {
		        var i;

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
                width: 38%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 60%;
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
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
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
                width: 50%;
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
                font-size:medium;
            }
            .tbbm textarea {
            	font-size: medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }  
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%;"><a id='vewChk'></a></td>
						<td align="center" style="width:15%;"><a id='vewNoa'></a></td>
						<td align="center" style="width:15%;"><a id='vewCarno'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='carno'>~carno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<div style="border: 1px solid #000000;border-radius: 5px;">
					<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
						<tr class="tr1">
							<td class="td1"><span> </span><a id="lblNoa" class="lbl"></a></td>
							<td class="td2"><input id="txtNoa" type="text" class="txt c1" /></td>
							<td class="td3"></td>
							<td class="td4"></td>
							<td class="td5"></td>
							<td class="td6"></td>
						</tr>
						<tr class="tr2">
							<td class="td1"><span> </span><a id="lblCarno" class="lbl"></a></td>
							<td class="td2"><input id="txtCarno" type="text" class="txt c1" /></td>
							<td class="td3"></td>
							<td class="td4"></td>
							<td class="td5"></td>
							<td class="td6"></td>
						</tr>
						<tr class="tr3">
							<td class="td1"><span> </span><a id="lblPricecust" class="lbl"></a></td>
							<td class="td2"><input id="txtPricecust" type="text" class="txt num c1" /></td>
							<td class="td3"></td>
							<td class="td4"></td>
							<td class="td5"></td>
							<td class="td6"></td>
						</tr>
						<tr class="tr3">
							<td class="td1"><span> </span><a id="lblPricedriver" class="lbl"></a></td>
							<td class="td2"><input id="txtPricedriver" type="text" class="txt num c1" /></td>
							<td class="td3"></td>
							<td class="td4"></td>
							<td class="td5"></td>
							<td class="td6"></td>
						</tr>
						<tr class="tr4">
							<td class="td1"><span> </span><a id="lblPricecar" class="lbl"></a></td>
							<td class="td2"><input id="txtPricecar" type="text" class="txt num c1" /></td>
							<td class="td3"></td>
							<td class="td4"></td>
							<td class="td5"></td>
							<td class="td6"></td>
						</tr>
						<tr class="tr5">
							<td class="td1"><span> </span><a id="lblCommission" class="lbl"></a></td>
							<td class="td2"><input id="txtCommission" type="text" class="txt num c1" /></td>
							<td class="td3"></td>
							<td class="td4"></td>
							<td class="td5"></td>
							<td class="td6"></td>
						</tr>
						<tr class="tr6">
							<td class="td1"><span> </span><a id="lblStradd" class="lbl btn"></a></td>
							<td class="td2"><input id="txtStraddno" type="text" class="txt c1" /></td>
							<td class="td3" colspan="2" ><input id="txtStradd" type="text" class="txt c1" /></td>
							<td class="td5"></td>
							<td class="td6"></td>
						</tr>
						<tr class="tr7">
							<td class="td1"><span> </span><a id="lblEndadd" class="lbl btn"></a></td>
							<td class="td2"><input id="txtEndaddno" type="text" class="txt c1" /></td>
							<td class="td3"colspan="2" ><input id="txtEndadd" type="text" class="txt c1" /></td>
							<td class="td5"></td>
							<td class="td6"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
