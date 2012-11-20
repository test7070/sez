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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "tranorde";
            var q_readonly = ['txtNoa', 'txtTranquatno', 'txtTranquatnoq', 'txtContract', 'txtCno', 'txtAcomp'];
            var q_readonlys = ['txtTranno', 'txtTrannoq'];
            var bbsNum = [];
            var bbsMask = new Array(['txtTrandate','999/99/99']);
            var bbmNum = new Array();
            var bbmMask = new Array(['txtDatea','999/99/99'],['txtDldate','999/99/99'],['txtCldate','999/99/99'],['txtNodate','999/99/99'],['txtMadate','999/99/99'],['txtRedate','999/99/99'],['txtStrdate','999/99/99']);
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_alias = '';
            q_desc = 1;
            q_xchg = 1;
            brwCount2 = 20;
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'],
            ['txtProductno', 'lblProduct', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx'],
            ['txtAddrno', 'lblAddr', 'addr', 'noa,addr', 'txtAddrno,txtAddr', 'addr_b.aspx'],
            ['txtCarno_', '', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx'],
            ['txtDriverno_', '', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx'],
            ['txtDeliveryno', 'lblDeliveryno', 'trando', 'deliveryno,po', 'txtDeliveryno,txtPo', 'trando_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];

                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(0);
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'tranorde.check':
                        if (result.substring(0, 1) != '1')
                            alert(result);
                        else {
                            var t_noa = trim($('#txtNoa').val());
                            var t_date = trim($('#txtDatea').val());
                            if (t_noa.length == 0 || t_noa == "AUTO")
                                q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranorde') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                            else
                                wrServer(t_noa);
                        }
                        break;
                }
            }

            function mainPost() {
            	q_mask(bbmMask);
            	q_cmbParse("cmbCasetype", "20'',40'',超重櫃,HQ,OP,太空包");
            	q_cmbParse("cmbCasetype2", "20'',40''");
                q_cmbParse("cmbStype", q_getPara('vcc.stype'));
                q_cmbParse("cmbUnit", q_getPara('sys.unit'));
                $("#cmbUnit").focus(function() {
					var len = $("#cmbUnit").children().length > 0 ? $("#cmbUnit").children().length : 1;
					$("#cmbUnit").attr('size', len + "");
				}).blur(function() {
					$("#cmbUnit").attr('size', '1');
				});
                $("#btnTranquat").click(function(e) {
                    if ($('#txtCustno').val().length == 0) {
                        alert('請輸入客戶編號!');
                        return;
                    }
                    t_where = "b.custno='" + $('#txtCustno').val() + "' and not exists(select * from tranorde" + r_accy + " c where a.noa = c.tranquatno and a.noq = c.tranquatnoq and not c.noa='" + $('#txtNoa').val() + "')";
                    q_box("tranquat_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;tranquatno=" + $('#txtTranquatno').val() + '_' + $('#txtTranquatnoq').val() + ";", 'tranquats', "95%", "650px", q_getMsg('popTranquat'));
                });
                $('#btnDeliveryno').click(function(e){
                	if ($('#txtDeliveryno').val().length == 0) {
                        alert('請輸入提單編號!');
                        return;
                    }	
                    $(this).val('請稍後');
                    t_where =  "where=^^b.deliveryno='"+$('#txtDeliveryno').val()+"'  and  (c.tranno is null or c.noa='"+$('#txtNoa').val()+"')^^";
                    q_gt('trando3', t_where, 0, 0, 0, "", r_accy);
                });
                $("#cmbCasetype").focus(function() {
					var len = $("#cmbCasetype").children().length > 0 ? $("#cmbCasetype").children().length : 1;
					$("#cmbCasetype").attr('size', len + "");
				}).blur(function() {
					$("#cmbCasetype").attr('size', '1');
				});
				$("#cmbCasetype2").focus(function() {
					var len = $("#cmbCasetype2").children().length > 0 ? $("#cmbCasetype2").children().length : 1;
					$("#cmbCasetype2").attr('size', len + "");
				}).blur(function() {
					$("#cmbCasetype2").attr('size', '1');
				});

                $('#txtDatea').datepicker(); 
                $('#txtCldate').datepicker();
                $('#txtNodate').datepicker();
                $('#txtMadate').datepicker();
                $('#txtRedate').datepicker(); 
                $('#txtStrdate').datepicker(); 
                $('#txtDldate').datepicker(); 
            }

            function bbsAssign() {
                _bbsAssign();
                for(var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_'+i).text(i+1);
                	if(!$('#txtTrandate_'+i).hasClass('isAssign')){
                		$('#txtTrandate_'+i).addClass('isAssign');
                		  
                	}	
                }
            }

            function bbsSave(as) {
                if (!as['caseno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'tranquats':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!(!b_ret || b_ret.length == 0)) {
                                $('#txtTranquatno').val(b_ret[0].noa);
                                $('#txtTranquatnoq').val(b_ret[0].noq);
                                $('#txtContract').val(b_ret[0].contract);
                                $('#cmbStype').val(b_ret[0].stype);
                                $('#txtProductno').val(b_ret[0].productno);
                                $('#txtProduct').val(b_ret[0].product);
                                $('#txtStraddrno').val(b_ret[0].straddrno);
                                $('#txtStraddr').val(b_ret[0].straddr);
                                $('#txtMount').val(b_ret[0].mount);
                                $('#txtMemo').val(b_ret[0].memo);
                            }
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function q_gtPost(t_name) {
            	switch (t_name) {
                    case 'trando3':
                
                        var as = _q_appendData("trandos", "", true);

                      	q_gridAddRow(bbsHtm, 'tbbs', 'txtCaseno,txtTranno,txtTrannoq', as.length, as, 'caseno,tranno,trannoq', '', '');
     
                       /* for( i = 0; i < q_bbsCount; i++) {
                            _btnMinus("btnMinus_" + i);
                            if(i < as.length) {
                                
                            }
                        }*/
                    
                        $('#btnDeliveryno').val("匯入櫃號 ");
                        break;
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('tranorde_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
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

            }

            function btnOk() {
            	$('#txtWorker').val(r_name);
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranorde') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
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
                if (q_cur != 1 && q_cur != 2){
                    $('#btnTranquat').attr('disabled', 'disabled');
                    $('#btnDeliveryno').attr('disabled', 'disabled');
                }else{
                    $('#btnTranquat').removeAttr('disabled');
                    $('#btnDeliveryno').removeAttr('disabled');
                }
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
            function q_popPost(id) {
				switch(id) {
					case 'txtCustno':
						$('#txtAddrno').val($('#txtCustno').val());
						break;
				}
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width:1080px;
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
                width: 95%;
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
                width: 12%;
            }
            .tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
                background-color: #FFEC8B;
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
            .tbbm .trX {
                background-color: #FFEC8B;
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
            .font1{
				font-family: "細明體",Arial, sans-serif;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();" 
	    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"  
        ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
     >
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px;"><a id='vewChk'></a></td>	
						<td align="center" style="width:100px;"><a id='vewNoa'></a></td>
						<td align="center" style="width:80px;"><a id='vewCust'></a></td>
						<td align="center" style="width:80px;"><a id='vewDatea'></a></td>
						<td align="center" style="width:80px;"><a id='vewStrdate'></a></td>
						<td align="center" style="width:80px;"><a id='vewDldate'></a></td>
						<td align="center" style="width:120px;"><a id='vewDeliveryno'></a></td>
						<td align="center" style="width:120px;"><a id='vewPo'></a></td>
						<td align="center" style="width:100px;"><a id='vewProduct'></a></td>
						<td align="center" style="width:80px;"><a id='vewMount'></a></td>
						<td align="center" style="width:50px;"><a id='vewUnit'></a></td>
						<td align="center" style="width:150px;"><a id='vewAddr'></a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='strdate' style="text-align: center;">~strdate</td>
						<td id='dldate' style="text-align: center;">~dldate</td>
						<td id='deliveryno' style="text-align: left;">~deliveryno</td>
						<td id='po' style="text-align: left;">~po</td>
						<td id='product' style="text-align: left;">~product</td>
						<td id='mount' style="text-align: right;">~mount</td>
						<td id='unit' style="text-align: center;">~unit</td>
						<td id='addr' style="text-align: left;">~addr</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2">
						<input type="text" id="txtNoa" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtDatea" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStrdate" class="lbl"> </a></td>
						<td><input type="text" id="txtStrdate" class="txt c1"/></td>
						<td><span> </span><a id="lblDldate" class="lbl"> </a></td>
						<td><input type="text" id="txtDldate" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl"> </a></td>
						<td colspan="4">
						<input type="text" id="txtCustno" class="txt" style="width:15%;float: left; " />
						<input type="text" id="txtComp" class="txt" style="width:85%;float: left; " />
						</td>
						<td></td>
						
					</tr>
					<tr>
						<td><span> </span><a id="lblTranquatno" class="lbl"> </a></td>
						<td colspan="2">
						<input type="text" id="txtTranquatno" class="txt" style="width:80%;float: left; " />
						<input type="text" id="txtTranquatnoq" class="txt" style="width:20%;float: left; " />
						</td>
						<td><input type="button" id="btnTranquat" style="width:100px;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDeliveryno" class="lbl"> </a></td>
						<td colspan="2"><input type="text" id="txtDeliveryno" class="txt c1"/></td>
						<td><input type="button" id="btnDeliveryno" style="width:100px;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl"> </a></td>
						<td colspan="5">
						<input type="text" id="txtCno" class="txt" style="width:15%;float: left; " />
						<input type="text" id="txtAcomp" class="txt" style="width:85%;float: left; " />
						<input type="text" id="txtNick" class="txt" style="display:none; " />
						</td>
					</tr>
					<tr>					
						<td><span> </span><a id="lblContract" class="lbl"> </a></td>
						<td colspan="2">
						<input type="text" id="txtContract" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblStype" class="lbl"> </a></td>
						<td><select id="cmbStype" class="txt c1"></select></td>
					</tr>
					
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl btn"> </a></td>
						<td colspan="2">
						<input type="text" id="txtProductno" class="txt" style="width:40%;float: left; " />
						<input type="text" id="txtProduct" class="txt" style="width:60%;float: left; " />
						</td>
						
						<td><span> </span><a id="lblPo" class="lbl"> </a></td>
						<td colspan="2"><input type="text" id="txtPo" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtMount" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblUnit" class="lbl"> </a></td>
						<td><select id="cmbUnit" class="txt c1"> </select></td>
						<td><span> </span><a id="lblAddr" class="lbl btn"> </a></td>
						<td colspan="3"><input type="text" id="txtAddrno" class="txt c2"/>
							<input type="text" id="txtAddr" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5">
						<input type="text" id="txtMemo" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblCancel" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtCancel" class="txt c1"/>
						</td>
					</tr>
					<tr class="trX">
						<td><span> </span><a id="lblExcon" class="lbl" style="color: #ff0033;font-weight:bolder;"> </a></td>
						<td colspan="3"></td>
						<td><span> </span><a id="lblImcon" class="lbl" style="color: #ff0033;font-weight:bolder;"> </a></td>
						<td colspan="4"></td>
					</tr>
					<tr class="trX">
						<td><span> </span><a id="lblBoat" class="lbl"> </a></td>
						<td colspan="3">
						<input type="text" id="txtBoat" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblTakeno" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtTakeno" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblTrackno" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtTrackno" class="txt c1"/>
						</td>
						<td></td>
					</tr>
					<tr class="trX">
						<td><span> </span><a id="lblShip" class="lbl"> </a></td>
						<td >
						<input type="text" id="txtBoatname" class="txt c1"/>
						</td>
						<td colspan="2">
						<input type="text" id="txtShip" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblCasePresent" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtCasePresent" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblCaseAssign" class="lbl"> </a></td>
						<td>
						<input type="text" id="txtCaseAssign" class="txt c1"/>
						</td>
						<td> </td>
					</tr>
					<tr class="trX">
						<td><span> </span><a id="lblDo1" class="lbl"> </a></td>
						<td colspan="2"><input type="text" id="txtDo1" class="txt c1"/></td>
						<td> </td>
						<td><span> </span><a id="lblDo2" class="lbl"> </a></td>
						<td colspan="2"><input type="text" id="txtDo2" class="txt c1"/></td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="trX">
						<td><span> </span><a id="lblSo" class="lbl"> </a></td>
						<td><input type="text" id="txtSo" class="txt c1"/></td>
						<td><span> </span><a id="lblCasetype" class="lbl"> </a></td>
						<td><select id="cmbCasetype" class="txt c1"> </select></td>
						<td><span> </span><a id="lblCheckself" class="lbl"> </a></td>
						<td><input type="text" id="txtCheckself" class="txt c1"/></td>
						<td><span> </span><a id="lblCasetype2" class="lbl"> </a></td>
						<td><select id="cmbCasetype2" class="txt c1"> </select></td>
					    <td> </td>
					</tr>
					<tr class="trX">
						<td><span> </span><a id="lblPort" class="lbl"> </a></td>
						<td><input type="text" id="txtPort" class="txt c1"/></td>
						<td><span> </span><a id="lblDock" class="lbl"> </a></td>
						<td><input type="text" id="txtDock" class="txt c1"/></td>
						<td><span> </span><a id="lblCheckInstru" class="lbl"> </a></td>
						<td><input type="text" id="txtCheckInstru" class="txt c1"/></td>
						<td><span> </span><a id="lblCasedo" class="lbl"> </a></td>
						<td><input type="text" id="txtCasedo" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr class="trX">
						<td><span> </span><a id="lblCldate" class="lbl"> </a></td>
						<td><input type="text" id="txtCldate" class="txt c1"/></td>
						<td><span> </span><a id="lblNodate" class="lbl"> </a></td>
						<td><input type="text" id="txtNodate" class="txt c1"/></td>
						<td><span> </span><a id="lblMadate" class="lbl"> </a></td>
						<td><input type="text" id="txtMadate" class="txt c1"/></td>
						<td><span> </span><a id="lblRedate" class="lbl"> </a></td>
						<td><input type="text" id="txtRedate" class="txt c1"/></td>
						<td>  </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/>	</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:120px"><a id='lblCaseno_s'> </a></td>
					<td align="center" style="width:100px"><a id='lblTrandate_s'></a></td>
					<td align="center" style="width:70px"><a id='lblCarno_s'></a></td>
					<td align="center" style="width:70px"><a id='lblDriverno_s'></a></td>
					<td align="center" style="width:70px"><a id='lblDriver_s'></a></td>
					<td align="center" style="width:100px"><a id='lblMemo_s'></a></td>
					<td align="center" style="width:120px"><a id='lblTranno_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
					<td>
						<a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td ><input type="text" class="txt c1 font1" id="txtCaseno.*"  /></td>
					<td ><input type="text" class="txt c1" id="txtTrandate.*"  /></td>
					<td ><input type="text" class="txt c1" id="txtCarno.*"  /></td>
					<td ><input type="text" class="txt c1" id="txtDriverno.*"  /></td>
					<td ><input type="text" class="txt c1" id="txtDriver.*"  /></td>
					<td ><input type="text" class="txt c1" id="txtMemo.*"  /></td>
					<td>
						<input type="text" id="txtTranno.*" class="txt c1"/>
						<input type="text" id="txtTrannoq.*" style="display:none;"/>
					</td>
				</tr>
				
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
