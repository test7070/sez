<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
			q_tables = 's';
            var q_name = "assignwork";
            var q_readonly = ['txtWorker','txtNoa'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp,nick,conn,conntel', 'txtCustno,txtComp,txtCustnick,txtConn,txtConntel', 'cust_b.aspx'],
            ['txtTggno_', 'btnTggno_', 'tgg', 'noa,comp', 'txtTggno_,txtComp_', 'tgg_b.aspx'],
            ['txtItemno', 'lblItem', 'assignment', 'noa,item', 'txtItemno,txtItem', 'assignment_b.aspx'],
            ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);
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

                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                 bbmMask = [['txtOdate', r_picd], ['txtWdate', r_picd], ['txtEnddate', r_picd]];
                q_mask(bbmMask);
             
             $('#btnInput').click(function () {
            	if(emp($('#txtItemno').val())){
            		alert('請先輸入項目!!');
            		return;
            	}
	           	t_where = "where=^^ noa=(select noa from assignment where noa ='"+$('#txtItemno').val()+"') ^^"
	           	q_gt('assignment', t_where , 0, 0, 0, "", r_accy);
	        });
                $('#lblVccno').click(function() {
		     		t_where = "noa='" + $('#txtVccno').val() + "'";
            		q_box("vcctran.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vcc', "95%", "650px", q_getMsg('popVcctran'));
             });
             
             
            }
			function cmbpaybno(id){
					t_where = "noa='" + $('#txtPaybno' + id).val() + "'";
            		q_box("payb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'payb', "95%", "650px", q_getMsg('popPayb'));
			}
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
            	switch (t_name) {
            	case 'assignment':
	            	var as = _q_appendData("assignments", "", true);
	            	q_gridAddRow(bbsHtm, 'tbbs', 'txtTggno,txtComp,txtProductno,txtProduct,txtDays,txtMoney,txtCost,txtMemo', as.length, as, 'tggno,comp,productno,product,days,money,cost,memo', '');
	            	sum();
            	break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
            function btnOk() {
            	if($.trim($('#txtNick').val()).length==0)
            		$('#txtNick').val($('#txtComp').val());
            	
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();
                $('#txtWorker').val(r_name);
                
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_assignmeny') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('assignwork_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtItem').focus();
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtNoa').attr('readonly','readonly');           
                $('#txtDatea').focus();
            }
            function btnPrint() {
            	//q_box('z_vcctran.aspx'+ "?;;;;"+r_accy+";noa="+trim($('#txtNoa').val()), '', "90%", "650px", m_print);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsAssign() {
                for(var i = 0; i < q_bbsCount; i++) {
                
                	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    }
                }
                _bbsAssign();
            }

            function bbsSave(as) {
                if (parseFloat(as['product'])==0) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                if (t_err) {
                    alert(t_err)
                    return false;
                }
                return true;
            }

            function sum() {
            var t1 = 0, t_unit, t_mount, t_money = 0,t_cost=0;
            for (var j = 0; j < q_bbsCount; j++) {
				t_money+=dec($('#txtMoney_'+j).val());
				t_cost+=dec($('#txtCost_'+j).val());
            }  // j
			q_tr('txtMoney',t_money);
			q_tr('txtCost',t_cost);
			
            	if(!(q_cur==1 || q_cur==2))
					return;
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
                width: 30%;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
                width: 100%;
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
                width: 70%;
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
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 20%;
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
                font-size: medium;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
                width: 100%;
            }

            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
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
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width：100px;color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width：100px;color:black;"><a id='vewItem'> </a></td>
						<td align="center" style="width：100px;color:black;"><a id='vewCustnick'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="item" style="text-align: center;">~item</td>
						<td id="custnick" style="text-align: center;">~custnick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtNoa" class="txt c1"/>	</td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblItem' class="lbl btn"> </a></td>
						<td class="td2"colspan="2"><input type="text" id="txtItemno" style="width: 30%;"/>
							<input type="text" id="txtItem" style="width: 70%;"/></td>
							<td class="td3"><input type="button" id="btnInput" /></td>		
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCustno' class="lbl btn"> </a></td>
						<td class="td2"colspan="2">
							<input type="text" id="txtCustno" style="width: 30%;"/>
							<input type="text" id="txtComp" style="width: 70%;"/>
							<input id="txtCustnick"  type="text" style="display: none;"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblConn' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtConn" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblConntel' class="lbl"> </a></td>
						<td class="td4" colspan="2"><input type="text" id="txtConntel" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtOdate" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblWdate' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtWdate" class="txt c1"/>	</td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblEnddate' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtEnddate" class="txt c1"/>	</td>
						<td class="td3">
							<input id="chkEnda" type="checkbox" style="float: left;"/><a id="lblEnda" class="lbl" style="float: left;"></a>
						</td>
							
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtMoney" class="txt num c1"/></td>
						<td class="td3"><span> </span><a id='lblCost' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtCost" class="txt num c1"/></td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCharge' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtCharge" class="txt num c1"/></td>
						<td class="td3"><span> </span><a id='lblPay' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtPay" class="txt num c1"/></td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblVccno' class="lbl btn"> </a></td>
						<td class="td2"><input type="text" id="txtVccno" class="txt c1"/></td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtWorker" class="txt c1"/></td>	
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:2%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20%;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblDays_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblCost_s'> </a></td>
					<td align="center" style="width:15%;"><a id='lblTggno_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblPaydate_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblPaybno_s'> </a></td>
					<td align="center" ><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <input type="text" id="txtProductno.*"  style="width:85%; float:left;"/>
                        <span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtProduct.*"  style="width:85%; float:left;"/>
					</td>
					<td><input id="txtDays.*" type="text" class="txt c1"/></td>
					<td><input id="txtMoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtCost.*" type="text" class="txt num c1"/></td>
					<td><input class="btn"  id="btnTggno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <input type="text" id="txtTggno.*"  style="width:85%; float:left;"/>
                        <span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtComp.*"  style="width:85%; float:left;"/>
					</td>
					<td><input id="txtPaydate.*" type="text" class="txt c1"/></td>
					<td><input class="btn"  id="btnPaybno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" /><input type="text" id="txtPaybno.*"  style="width:70%; float:left;"/>
					</td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
