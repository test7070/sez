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
            var q_name = "tranquat";
            var q_readonly = ['txtNoa'];
            var q_readonlys = ['txtNoq'];
            var bbmNum = new Array(['txtThirdprice',10,3]);
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'], ['txtStraddrno_', 'btnStraddr_', 'addr', 'noa,addr', 'txtStraddrno_,txtStraddr_', 'addr_b2.aspx'], ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'], ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'], ['txtCno', 'btnAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']);
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
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbStype", q_getPara('vcc.stype'));

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

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if(t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranquat') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('tranquat_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                _bbsAssign();
                for(var j = 0; j < q_bbsCount; j++) {
                }
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
            }

            function btnPrint() {
                q_box("z_tranQuat.aspx", '', "95%", "95%", "")
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['productno']) {
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

                }  // j

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
            #dmain {
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
		<div id='dmain'>
			<div style="float: left;">
				<div class="dview" id="dview">
					<table class="tview" id="tview">
						<tr>
							<td align="center" style="width:5%"><a id='vewChk'></a></td>
							<td align="center" style="width:25%"><a id='vewDatea'></a></td>
							<td align="center" style="width:25%"><a id='vewNoa'></a></td>
							<td align="center" style="width:40%"><a id='vewComp'></a></td>
						</tr>
						<tr>
							<td >
							<input id="chkBrow.*" type="checkbox" style=''/>
							</td>
							<td align="center" id='datea'>~datea</td>
							<td align="center" id='noa'>~noa</td>
							<td align="center" id='custno comp,4'>~custno ~comp,4</td>
						</tr>
					</table>
				</div>
				<div class='dbbm'>
					<table class="tbbm"  id="tbbm">
						<tr class="tr1">
							<td class="td1" ><span> </span></span><a id='lblNoa' class="lbl"></a></td>
							<td class="td2" >
							<input id="txtNoa" type="text" class="txt c1"/>
							</td>
							<td class="td3" ><span> </span><a id='lblDatea' class="lbl"></a></td>
							<td class="td4">
							<input id="txtDatea" type="text"  class="txt c1"/>
							</td>
							<td class="td5" ><span> </span><a id="lblStype" class="lbl"></a></td>
							<td class="td6"><select id="cmbStype" class="txt c1"></select></td>
							<td class="td7"><span> </span><a id='lblContract' class="lbl"></a></td>
							<td class="td8">
							<input id="txtContract"  type="text"  class="txt c1"/>
							</td>
							<td class="tdZ"></td>
						</tr>
						<tr class="tr2">
							<td class="td1" ><span> </span><a id='lblThirdprice' class="lbl"></a></td>
							<td class="td2">
							<input id="txtThirdprice" type="text"  class="txt c1 num"/>
							</td>
							<td class="td3" ><span> </span><a id='lblOil1' class="lbl"></a></td>
							<td class="td4" colspan="2">
							<input id="txtOil1" type="text"  class="txt c2 num"/>
							<a id="lblOil2" style="float:left;width:25px;height:25px;text-align: center;"></a>
							<input id="txtOil2" type="text"  class="txt c2 num"/>
							</td>
						</tr>
						<tr class="tr3">
							<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"></a></td>
							<td class="td2">
							<input id="txtCno"  type="text"  class="txt c1"/>
							</td>
							<td class="td3" colspan="2">
							<input id="txtAcomp"  type="text" class="txt c1"/>
							</td>
							<td class="td5"><span> </span><a id="lblConn_acomp" class="lbl"></a></td>
							<td class="td6" >
							<input id="txtConn_acomp"  type="text"  class="txt c1"/>
							</td>
							<td class="td7"><span> </span><a id="lblAssistant" class="lbl"></a></td>
							<td class="td8" >
							<input id="txtAssistant"  type="text"  class="txt c1"/>
							</td>
						</tr>
						<tr class="tr4">
							<td class="td1"><span> </span><a id='lblAddr_acomp' class="lbl btn"></a></td>
							<td >
							<input id="txtZip_acomp" type="text"  class="txt c1"/>
							</td>
							<td class='td2' colspan="2">
							<input id="txtAddr_acomp" type="text"  class="txt c1" />
							</td>
							<td class="td4"><span> </span><a id="lblTel_acomp"  class="lbl"></a></td>
							<td class="td8">
							<input id="txtTe5_acomp"  type="text"  class="txt c1"/>
							</td>
							<td class="td5"><span> </span><a id='lblFax_acomp' class="lbl"></a></td>
							<td class="td6">
							<input id="txtFax_acomp"  type="text"  class="txt c1"/>
							</td>
						</tr>
						<tr  class="tr5">
							<td class="td1"><span> </span><a id='lblSales' class="lbl btn"></a></td>
							<td class="td2">
							<input id="txtSalesno" type="text" class="txt c1"/>
							</td>
							<td class="td3" colspan='2'>
							<input id="txtSales" type="text" class="txt c1"/>
							</td>
						</tr>
						<tr class="tr6">
							<td class="td1"><span> </span><a id='lblCust' class="lbl btn"></a></td>
							<td class="td2">
							<input id="txtCustno" type="text" class="txt c1"/>
							</td>
							<td class="td3" colspan="2">
							<input id="txtComp"  type="text" class="txt c1"/>
							</td>
							<td class="td4"><span> </span><a id='lblConn_cust'  class="lbl"></a></td>
							<td class="td5">
							<input id="txtConn_cust"  type="text"  class="txt c1"/>
							</td>
							<td class="td6"><span> </span><a id='lblTel_cust'  class="lbl"></a></td>
							<td >
							<input id="txtTel_cust"  type="text"  class="txt c1"/>
							</td>
						</tr>
						<tr class="tr7">
							<td class="td1"><span> </span><a id='lblAddr_cust' class="lbl"></a></td>
							<td >
							<input id="txtZip_cust" type="text"  class="txt c1">
							</td>
							<td class="td2" colspan='2' >
							<input id="txtAddr_cust" type="text"  class="txt c1" />
							</td>
							<td class="td4"><span> </span><a id='lblFax_cust'  class="lbl"></a></td>
							<td >
							<input id="txtFax_cust"  type="text"  class="txt c1"/>
							</td>
						</tr>
						<tr class="tr8">
							<td class="td1"><span> </span><a id='lblAddr_car'  class="lbl"></a></td>
							<td >
							<input id="txtZip_car" type="text"  class="txt c1">
							</td>
							<td class="td2" colspan='2'>
							<input id="txtAddr_car" type="text"  class="txt c1" />
							</td>
							<td class="td4"><span> </span><a id='lblConn_car' class="lbl"></a></td>
							<td class="td5">
							<input id="txtConn_car"  type="text"  class="txt c1"/>
							</td>

						</tr>
						<tr class="tr9">
							<td class="td1"><span> </span><a id='lblArrange_car'  class="lbl"></a></td>
							<td class="td2">
							<input id="txtArrange_car"  type="text"  class="txt c1"/>
							</td>
							<td class="td3"><span> </span><a id='lblTel_car' class="lbl"></a></td>
							<td class="td4">
							<input id="txtTel_car"  type="text"  class="txt c1"/>
							</td>
							<td class="td5"><span> </span><a id='lblWorker' class="lbl"></a></td>
							<td class="td6">
							<input id="txtWorker"  type="text" class="txt c1" />
							</td>
							<td class="td7"><span> </span><a id='lblApv' class="lbl"></a></td>
							<td class="td8">
							<input id="txtApv"  type="text" class="txt c1" />
							</td>
						</tr>
						<tr class="tr10">
							<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
							<td class="td2" colspan='7' >
							<input id="txtMemo"  type="text" class="txt c1"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td align="center" style="width:1%;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
						</td>
						<td align="center" style="width:3%;"><a id="lblNoq_s"></a></td>
						<td align="center" style="width:20%;"><a id='lblProduct_s'></a></td>
						<td align="center" style="width:15%;"><a id="lblStraddr_s"></a></td>
						<td align="center" style="width:5%;"><a id='lblMount_s'></a></td>
						<td align="center" style="width:3%;"><a id='lblUnit_s'></a></td>
						<td align="center" style="width:5%;"><a id='lblPrice_s'></a></td>
						<td align="center" style="width:10%;"><a id='lblMemo_s'></a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td>
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						</td>
						<td>
						<input id="txtNoq.*" type="text" class="txt"/>
						</td>
						<td>
						<input id="txtProductno.*" type="text" style="width: 30%; float: left;"/>
						<input id="txtProduct.*" type="text" style="width: 65%; float: left;"/>
						</td>
						<td>
						<input id="txtStraddrno.*" type="text" style="width: 30%; float: left;"/>
						<input id="txtStraddr.*" type="text" style="width: 60%; float: left;"/>
						</td>						
						<td>
						<input id="txtMount.*" type="text" style="width: 95%;text-align:right;"/>
						</td>
						<td>
						<input id="txtUnit.*" type="text" style="width: 95%;"/>
						</td>
						<td>
						<input id="txtPrice.*" type="text" style="width: 95%;text-align:right;"/>
						</td>
						<td>
						<input id="txtMemo.*" type="text" style="width: 95%;"/>
						<input id="recno.*" type="hidden" />
						</td>
					</tr>
				</table>
			</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
