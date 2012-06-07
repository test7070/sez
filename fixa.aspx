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

           function q_boxClose( s2) { 
            var ret; 
            switch (b_pop) {   
                case 'conn':

                    break;

                case 'sss':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtSalesno,txtSales', ret, 'noa,namea');
                    break;

                case 'sss':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtGrpno,txtGrpname', ret, 'noa,comp');
                    break;
                
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }

           
             function q_gtPost(t_name) {  
            switch (t_name) {
                case 'sss': 
                    q_changeFill(t_name, ['txtSalesno', 'txtSales'], ['noa', 'namea']);
                    break;

                case q_name: if (q_cur == 4)   
                        q_Seek_gtPost();

                    if (q_cur == 1 || q_cur == 2) 
                        q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                    break;
            }  /// end switch
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

                q_box('fixa_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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
 			#dmain
 			 {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 23%;
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
                width: 75%;
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
                width: 10%;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
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
            .tbbs input[type="text"] {
                width: 95%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs{
            	float:left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
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
						<td class="td1"><span> </span><a id="lblDatea" class="lbl"></a></td>
						<td class="td2">
						<input id="txtDatea" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblNoa" class="lbl"></a></td>
						<td class="td4">
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblCarno" class="lbl"></a></td>
						<td class="td6">
						<input id="txtCarno" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id="lblPalno" class="lbl"></a></td>
						<td class="td2">
						<input id="txtPalno" type="text" class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id="lblOdometer" class="lbl"></a></td>
						<td class="td4">
						<input id="txtOdometer" type="text" class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id="lblCartype" class="lbl"></a></td>
						<td class="td6">
						<input id="txtCartype" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id="lblDriver" class="lbl btn"></a></td>
						<td class="td2">
						<input id="txtDriverno" type="text" class="txt c2"/>
						<input id="txtDriver" type="text" class="txt c3"/>
						</td>
						<td class="td3"><span> </span><a id="lblTgg" class="lbl btn"></a></td>
						<td class="td4">
						<input id="txtTggno" type="text" class="txt c2"/>
						<input id="txtTgg" type="text" class="txt c3"/>
						</td>
						<td class="td5"><span> </span><a id="lblMon" class="lbl"></a></td>
						<td class="td6">
						<input id="txtMon" type="text" class="txt c1"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id="lblWmoney" class="lbl"></a></td>
						<td class="td2">
						<input id="txtWmoney" type="text" class="txt num c1" />
						</td>
						<td class="td3"><span> </span><a id="lblCmoney" class="lbl"></a></td>
						<td class="td4">
						<input id="txtCmoney" type="text" class="txt num c1" />
						</td>
						<td class="td5"><span> </span><a id="lblMoney" class="lbl"></a></td>
						<td class="td6">
						<input id="txtMoney" type="text" class="txt num c1" />
						</td>
					</tr>
					<tr class="tr5">
                        <td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"></a></td>
                        <td class="td2">
                        <input id="txtCno" type="text" class="txt c2" /> <input id="txtAcomp" type="text" class="txt c3" />                       
                        </td>
                        <td class="td3"><span> </span><a id="lblTax" class="lbl"></a></td>
                        <td class="td4">
                        <input id="txtTax" type="text" class="txt num c1" />
                        </td>
                        <td class="td5"><span> </span><a id="lblTotal" class="lbl"></a></td>
                        <td class="td6">
                        <input id="txtTotal" type="text" class="txt num c1" />
                        </td>
                    </tr>
                    <tr class="tr6">
                        <td class="td1"><span> </span><a id="lblMemo" class="lbl"></a></td>
                        <td class="td2" colspan="5">
                        <textarea id="txtMemo" type="text" rows="5" cols="10" style="width: 98%; height: 50px;" ></textarea>           
                        </td>
                    </tr>
				</table>
			</div>
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
						<input class="txt num c1" id="txtMount.*" type="text" />
						</td>
						<td>
						<input class="txt num c1" id="txtPrice.*" type="text" />
						</td>
						<td>
						<input class="txt c1" id="txtMemo.*" type="text" />
						<input id="txtNoq.*" type="hidden" />
						</td>
					</tr>
				</table>
			</div>
			<input id="q_sys" type="hidden" />
	</body>
</html>
