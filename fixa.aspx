<%@ Page Language="C#" AutoEventWireup="true" %>
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

            q_tables = 's';
            var q_name = "fixa";
            var decbbs = ['mount', 'price'];
            var decbbm = ['wmoney', 'imoney', 'total', 'money', 'tax', 'cmoney'];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            //ajaxPath = "";
			aPop = new Array(['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'],['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],['txtProductno_', 'btnProductno_', 'fixucc', 'noa,namea', 'txtProductno_,txtProduct_', 'fixucc_b.aspx']);
            
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)

            });
            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);

            }///  end Main()

            function pop(form) {
                b_pop = form;
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
                fbbm[fbbm.length] = 'txtMemo'; 
            }

            function q_boxClose(s2) {
            }

            function q_gtPost(t_name) {
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('A' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('worka_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProductno').focus();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['productno'] && !as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['date'] = abbm2['date'];
                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                for(var j = 0; j < q_bbsCount; j++) {

                }// j
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
                if(q_tables == 's')
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
		</script>
		<style type="text/css">
            .tview {
                font-size: 12pt;
                color: blue;
                background: #FFCC00;
                padding: 3px;
                text-align: center;
            }
            .tbbm {
                font-size: 12pt;
                color: blue;
                text-align: left;
                border-color: white;
                width: 100%;
                border-collapse: collapse;
                background: #cad3ff;
            }
            .tbbs {
                font-size: 12pt;
                color: blue;
                text-align: left;
                border: 1px #DDDDDD solid;
                width: 100%;
                height: 100%;
            }
            .td1, .td3, .td5, .td7 {
                width: 10%;
            }
            .td2, .td4, .td6, .td8 {
                width: 15%;
            }
            td a.label {
                float: right;
            }
            td a.label.button {
                color: #1D1BA3;
                font-weight: bold;
            }
            td a.label.button:hover {
                color: #FF0000;
            }
            .txt.c1 {
                width: 95%;
            }
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }

		</style>
	</head>
	<body>
			<!--#include file="../inc/toolbar.inc"-->
			<div id='dmain' >
			<div class="dview" id="dview" style="float: left;  width:32%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:20%"><a id='vewDatea'></a></td>
						<td align="center" style="width:20%"><a id='vewCarno'></a></td>
						<td align="center" style="width:20%"><a id='vewDriver'></a></td>
						<td align="center" style="width:20%"><a id='vewTgg'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='carno'>~carno</td>
						<td align="center" id='driver'>~driver</td>
						<td align="center" id='tgg'>~tgg</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr class="tr1">
						<td class="td1"><a id="lblDatea" class="label"></a></td>
						<td class="td2">
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td class="td3"><a id="lblNoa" class="label"></a></td>
						<td class="td4">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td5"><a id="lblCarno" class="label"></a></td>
						<td class="td6">
						<input id="txtCarno" type="text" class="txt c1"/>
						</td>
						<td class="td7"></td>
						<td class="td8"></td>
					</tr>
					<tr class="tr2">
						<td class="td1"><a id="lblPalno" class="label"></a></td>
						<td class="td2">
						<input id="txtPalno" type="text" class="txt c1"/>
						</td>
						<td class="td3"><a id="lblOdometer" class="label"></a></td>
						<td class="td4">
						<input id="txtOdometer" type="text" class="txt c1"/>
						</td>
						<td class="td5"><a id="lblCartype" class="label"></a></td>
						<td class="td6">
						<input id="txtCartype" type="text" class="txt c1"/>
						</td>
						<td class="td7"></td>
						<td class="td8"></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><a id="lblDriver" class="label button"></a></td>
						<td class="td2">
						<input id="txtDriverno" type="text" class="txt c2"/>
						<input id="txtDriver" type="text" class="txt c3"/>
						</td>
						<td class="td3"><a id="lblTgg" class="label button"></a></td>
						<td class="td4">
						<input id="txtTggno" type="text" class="txt c2"/>
						<input id="txtTgg" type="text" class="txt c3"/>
						</td>
						<td class="td5"><a id="lblMon" class="label"></a></td>
						<td class="td6">
						<input id="txtMon" type="text" class="txt c1"/>
						</td>
						<td class="td7"></td>
						<td class="td8"></td>
					</tr>
					<tr class="tr4">
						<td class="td1"><a id="lblWmoney" class="label"></a></td>
						<td class="td2">
						<input id="txtWmoney" type="text" class="txt c1" style="text-align: right;"/>
						</td>
						<td class="td3"><a id="lblCmoney" class="label"></a></td>
						<td class="td4">
						<input id="txtCmoney" type="text" class="txt c1" style="text-align: right;"/>
						</td>
						<td class="td5"><a id="lblMoney" class="label"></a></td>
						<td class="td6">
						<input id="txtMoney" type="text" class="txt c1" style="text-align: right;"/>
						</td>
						<td class="td7"></td>
						<td class="td8"></td>
					</tr>
					<tr class="tr5">
                        <td class="td1"><a id="lblAcomp" class="label button"></a></td>
                        <td class="td2">
                        <input id="txtCno" type="text" class="txt c2" /> <input id="txtAcomp" type="text" class="txt c3" />                       
                        </td>
                        <td class="td3"><a id="lblTax" class="label"></a></td>
                        <td class="td4">
                        <input id="txtTax" type="text" class="txt c1" style="text-align: right;"/>
                        </td>
                        <td class="td5"><a id="lblTotal" class="label"></a></td>
                        <td class="td6">
                        <input id="txtTotal" type="text" class="txt c1" style="text-align: right;"/>
                        </td>
                        <td class="td7"></td>
                        <td class="td8"></td>
                    </tr>
                    <tr class="tr6">
                        <td class="td1"><a id="lblMemo" class="label"></a></td>
                        <td class="td2" colspan="5">
                        <textarea id="txtMemo" type="text" rows="5" cols="10" style="width: 98%; height: 127px;" ></textarea>           
                        </td>
                        <td class="td3"></td>
                        <td class="td4"></td>
                        <td class="td5"></td>
                        <td class="td6"></td>
                        <td class="td7"></td>
                        <td class="td8"></td>
                    </tr>
				</table>
			</div>
			<div class='dbbs' >
				<table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
					<tr style='color:white; background:#003366;' >
						<td align="center" style="width:3%;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
						</td>
						<td align="center" style="width:5%;"><a id='lblWtype'></a></td>
						<td align="center" style="width:25%;"><a id='lblProduct'></a></td>
						<td align="center" style="width:5%;"><a id='lblUnit'></a></td>
						<td align="center" style="width:7%;"><a id='lblSpec'></a></td>
						<td align="center" style="width:7%;"><a id='lblMount'></a></td>
						<td align="center" style="width:7%;"><a id='lblPrice'></a></td>
						<td align="center" style="width:40%;"><a id='lblMemos'></a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						</td>
						<td>
						<input class="txt c1" id="txtWtype.*" type="text" />
						</td>
						<td>
						<input class="txt" id="txtProductno.*" type="text" style="width:25%;"/>
						<input class="txt" id="txtProduct.*"type="text" style="width:55%;"/>
						<input id="btnProductno.*" type="button" value="..." style="width: 10%;" />
						</td>
						<td>
						<input class="txt c1" id="txtUnit.*" type="text" style="text-align: center;"/>
						</td>
						<td>
						<input class="txt c1" id="txtSpec.*" type="text" />
						</td>
						<td>
						<input class="txt c1" id="txtMount.*" type="text" style=" text-align: right;"/>
						</td>
						<td>
						<input class="txt c1" id="txtPrice.*" type="text" style="text-align: right;"/>
						</td>
						<td>
						<input class="txt c1" id="txtMemo.*" type="text" />
						<input id="txtNoq.*" type="hidden" />
						</td>
					</tr>
				</table>
			</div>
			</div>
			<input id="q_sys" type="hidden" />
	</body>
</html>
