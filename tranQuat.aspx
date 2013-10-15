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
            var q_readonly = ['txtNoa', 'txtWorker', 'txtApv'];
            var q_readonlys = ['txtNoq'];
            var bbmNum = new Array(['txtThirdprice', 10, 3], ['txtOil1', 5, 2], ['txtOil2', 5, 2]);
            var bbsNum = new Array(['txtMount', 10, 3], ['txtPrice', 10, 3]);
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
            brwCount2 = 10;
            
            aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            , ['txtStraddrno_', 'btnStraddr_', 'addr', 'noa,addr', 'txtStraddrno_,txtStraddr_', 'addr_b2.aspx']
            , ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,conn,tel,fax,zip_comp,addr_comp', 'txtCustno,txtComp,txtNick,txtConn_cust,txtTel_cust,txtFax_cust,txtZip_cust,txtAddr_cust', 'cust_b.aspx']
            , ['txtConn_acomp', 'lblConn_acomp', 'sss', 'namea,noa', 'txtConn_acomp', 'sss_b.aspx']
            , ['txtAssistant', 'lblAssistant', 'sss', 'namea,noa', 'txtAssistant', 'sss_b.aspx']
            , ['txtCar_conn', 'lblCar_conn', 'sss', 'namea,noa', 'txtCar_conn', 'sss_b.aspx']
            , ['txtDisatcher', 'lblDisatcher', 'sss', 'namea,noa', 'txtDisatcher', 'sss_b.aspx']
            , ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']);
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

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtZip_cust', '999-99']];
                q_mask(bbmMask);
                q_cmbParse("cmbStype", q_getPara('vcc.stype'));
                $("#cmbStype").focus(function() {
                    var len = $("#cmbStype").children().length > 0 ? $("#cmbStype").children().length : 1;
                    $("#cmbStype").attr('size', len + "");
                }).blur(function() {
                    $("#cmbStype").attr('size', '1');
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);

                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
            	if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                if($('#txtNick').val().length==0)
                	$('#txtNick').val($('#txtComp').val().substring(0,4));
                $('#txtWorker').val(r_name);
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranquat') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('tranquat_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                _bbsAssign();
                for (var j = 0; j < q_bbsCount; j++) {
                	 $('#lblNo_' + j).text(j + 1);
                }
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
                q_box('z_tranQuat.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                for (var j = 0; j < q_bbsCount; j++) {

                } // j

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
                width: 210px; 
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
                width: 9%;
            }
            .tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
                background-color: #FFEC8B;
            }
            .tbbm  .tr_import {
                background-color: #DAA520;
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
            .dbbs {
                width: 1000px;
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
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
						<tr>
							<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
							<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
							<td align="center" style="width:100px; color:black;"><a id='vewComp'> </a></td>
						</tr>
						<tr>
							<td><input id="chkBrow.*" type="checkbox" style=''/></td>
							<td id='datea' style="text-align: center;">~datea</td>
							<td id='nick' style="text-align: center;">~nick</td>
						</tr>
					</table>
				</div>
				<div class='dbbm'>
					<table class="tbbm"  id="tbbm">
						<tr style="height:1px;">
							<td style="width:10%;"> </td>
							<td style="width:10%;"> </td>
							<td style="width:10%;"> </td>
							<td style="width:10%;"> </td>
							<td style="width:10%;"> </td>
							<td style="width:10%;"> </td>
							<td style="width:8%;"> </td>
							<td style="width:15%;"> </td>
							<td  style="width:1%;"> </td>
						</tr>
						<tr>
							<td><span> </span></span><a id='lblNoa' class="lbl"> </a></td>
							<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/>	</td>
							<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
							<td><input id="txtDatea" type="text"  class="txt c1"/></td>
							<td><span> </span><a id="lblStype" class="lbl"> </a></td>
							<td><select id="cmbStype" class="txt c1"> </select></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblContract' class="lbl"> </a></td>
							<td colspan="2"><input id="txtContract"  type="text"  class="txt c1"/></td>
						</tr>
						<tr>
							<td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
							<td colspan="3">
								<input id="txtCno"  type="text" class="txt" style="width:20%; float: left;"/>
								<input id="txtAcomp"  type="text" class="txt" style="width:80%; float: left;"/>
							</td>
							<td><span> </span><a id="lblConn_acomp" class="lbl btn"> </a></td>
							<td><input id="txtConn_acomp"  type="text"  class="txt c1"/></td>
							<td><span> </span><a id="lblConn_acomp_tel" class="lbl"> </a></td>
							<td><input id="txtConn_acomp_tel"  type="text"  class="txt c1"/></td>
						</tr>
						<tr>
							<td> </td>
							<td> </td>
							<td> </td>
							<td> </td>
							<td><span> </span><a id="lblAssistant" class="lbl btn"> </a></td>
							<td><input id="txtAssistant"  type="text"  class="txt c1"/>	</td>
							<td><span> </span><a id="lblAssistanttel" class="lbl"> </a></td>
							<td><input id="txtAssistanttel"  type="text"  class="txt c1"/>	</td>
						</tr>
						<tr>
							<td> </td>
							<td> </td>
							<td> </td>
							<td> </td>
							<td><span> </span><a id="lblCar_conn" class="lbl btn"> </a></td>
							<td><input id="txtCar_conn"  type="text"  class="txt c1"/>	</td>
							<td><span> </span><a id="lblDisatcher" class="lbl"> </a></td>
							<td><input id="txtDisatcher"  type="text"  class="txt c1"/></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
							<td colspan="3">
								<input id="txtCustno"  type="text" class="txt" style="width:20%; float: left;"/>
								<input id="txtComp"  type="text" class="txt" style="width:80%; float: left;"/>
								<input id="txtNick"  type="text" style="display: none;"/>
							</td>
							<td><span> </span><a id='lblConn_cust'  class="lbl"> </a></td>
							<td><input id="txtConn_cust"  type="text"  class="txt c1"/></td>
							<td><span> </span><a id='lblConn_cust_tel'  class="lbl"> </a></td>
							<td><input id="txtConn_cust_tel"  type="text"  class="txt c1"/>	</td>
						</tr>
						<tr>
							<td><span> </span><a id='lblAddr_cust' class="lbl"> </a></td>
							<td colspan="5" >
								<input id="txtZip_cust"  type="text" class="txt" style="width:12.5%; float: left;"/>
								<input id="txtAddr_cust"  type="text" class="txt" style="width:87.5%; float: left;"/>
							</td>
						</tr>
						<tr>
							<td><span> </span><a id='lblTel_cust'  class="lbl"> </a></td>
							<td colspan="2"><input id="txtTel_cust"  type="text"  class="txt c1"/></td>
							<td><span> </span><a id='lblFax_cust'  class="lbl"> </a></td>
							<td colspan="2"><input id="txtFax_cust"  type="text"  class="txt c1"/></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblOil1' class="lbl"> </a></td>
							<td colspan="2">
								<input id="txtOil1" type="text" style="float:left;width:80px;text-align: right;"/>
								<a id="lblOil2" style="float:left;width:20px;height:25px;text-align: center;"> </a>
								<input id="txtOil2" type="text" style="float:left;width:80px;text-align: right;"/>
							</td>
							<td colspan="2"><span> </span><a id='lblThirdprice' class="lbl"> </a></td>
							<td><input id="txtThirdprice" type="text"  class="txt c1 num"/></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
							<td colspan='7'><input id="txtMemo"  type="text" class="txt c1"/></td>
						</tr>
						<tr>
							<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
							<td><input id="txtWorker"  type="text" class="txt c1" /></td>
							<td><span> </span><a id='lblApv' class="lbl"> </a></td>
							<td><input id="txtApv"  type="text" class="txt c1" /></td>
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
					<td align="center" style="width:200px;"><a id='lblProduct_s'></a></td>
					<td align="center" style="width:200px;"><a id="lblStraddr_s"></a></td>
					<td align="center" style="width:40px;"><a id='lblUnit_s'></a></td>
					<td align="center" style="width:80px;"><a id='lblMount_s'></a></td>
					<td align="center" style="width:80px;"><a id='lblPrice_s'></a></td>
					<td align="center" style="width:200px;"><a id='lblMemo_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					<input id="txtProductno.*" type="text" style="width: 25%; float: left;"/>
					<input id="txtProduct.*" type="text" style="width: 70%; float: left;"/>
					</td>
					<td>
					<input id="txtStraddrno.*" type="text" style="width: 25%; float: left;"/>
					<input id="txtStraddr.*" type="text" style="width: 70%; float: left;"/>
					</td>
					<td>
					<input id="txtUnit.*" type="text" style="width: 95%;text-align:center;"/>
					</td>
					<td>
					<input id="txtMount.*" type="text" style="width: 95%;text-align:right;"/>
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
