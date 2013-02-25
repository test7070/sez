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
            var q_name = "giftsend";
            var q_readonly = ['txtNoa','txtWorker','txtTotal'];
            var q_readonlys = [];
            var bbmNum = new Array(['txtPrice', 10, 0, 1],['txtTotal',10,0,1]);
            var bbsNum = new Array(['txtMoney', 10, 0, 1],['txtMount', 10, 0, 1]);
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtCno', 'lblCno', 'acomp', 'noa,nick', 'txtCno,txtAcomp', 'Acomp_b.aspx'],
            ['txtCustno', 'lblCustno', 'giftCust', 'noa,custnamea', 'txtCustno,txtNamea', 'giftcust_b.aspx'],
            ['txtSalesno', 'lblSalesno', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
            ['txtCustno_', 'btnCustno_', 'giftcust', 'noa,namea,namea', 'txtCustno_,txtNamea_,txtReceiver_,txtMount_', 'giftcust_b.aspx'],
            ['txtGiftno', 'lblGiftno', 'bcc', 'noa,product,price', 'txtGiftno,txtGift,txtPrice', 'bcc_b.aspx']);
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
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                
                $('#txtPrice').blur(function () {
	            	for(var j = 0; j < q_bbsCount; j++) {
	            		q_tr('txtMoney_'+j,q_float('txtMount_'+j)*q_float('txtPrice'));
	            	}
	            	sum();
	       		});
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
		            //q_gtnoa(q_name, replaceAll('KGS' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		            q_gtnoa(q_name, replaceAll('TEST' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('giftsend_s.aspx', q_name + '_s', "550px", "430px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
               $('#txtDatea').focus();
                $('#txtDatea').val(q_date());
                $('#txtNoa').val('AUTO');
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();           
                $('#txtNoa').attr('readonly','readonly');
                $('#txtItem').focus();
            }
            function btnPrint() {
            	q_box('z_giftsend.aspx', '', "90%", "650px", m_print);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsAssign() {
                for(var i = 0; i < q_bbsCount; i++) {
                	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                		
                		$('#txtMount_'+i).blur(function () {
                			t_IdSeq = -1;
                			q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							q_tr('txtMoney_'+b_seq,q_float('txtMount_'+b_seq)*q_float('txtPrice'));
			            	sum();
			       		});
			       		
			       		$('#txtMoney_'+i).blur(function () {
			            	sum();
			       		});
			       		
                    }
                }
                _bbsAssign();
            }

            function bbsSave(as) {
                if (!as['custno']) {
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
				var total = 0,t_bin=0,t_interest=0,t_paytotal=0;
                for(var j = 0; j < q_bbsCount; j++) {
                	total=total+q_float('txtMoney_'+j);
                }
                q_tr('txtTotal',total);
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
                width: 680px;
                /*margin: -1px;
                 border: 1px black solid;*/
                border-radius: 5px;
                width: 70%;
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
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 25%;
                float: left;
            }
            .txt.c3 {
                width: 74%;
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
                width: 100%;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
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
						<td align="center" style="width:5%; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%;color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:25%;color:black;"><a id='vewFestival'> </a></td>
						<td align="center" style="width:40%;color:black;"><a id='vewSales'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="festival" style="text-align: center;">~festival</td>
						<td id="sales" style="text-align: center;">~sales</td>
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
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtDatea" class="txt c1"/>	</td>
						<td class="td3"> </td>
						<td class="td4"><span> </span><a id='lblFestival' class="lbl"> </a></td>
						<td class="td5"><input type="text" id="txtFestival" class="txt c1"/></td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCno' class="lbl btn"> </a></td>
						<td class="td2" colspan="2"><input type="text" id="txtCno" class="txt c2"/>
							<input type="text" id="txtAcomp" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblSalesno' class="lbl btn"> </a></td>
						<td class="td2" colspan="2"><input type="text" id="txtSalesno" class="txt c2"/>
							<input type="text" id="txtSales" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblGiftno' class="lbl btn"> </a></td>
						<td class="td2" colspan="2"><input id="txtGiftno" type="text" class="txt c2"/>
						<input id="txtGift" type="text"  class="txt c3"/></td>
						<td class="td4"><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td class="td5"><input type="text" id="txtPrice" class="txt num c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblUpname' class="lbl"> </a></td>
						<td class="td2" colspan="2"><input type="text" id="txtUpname" class="txt c1"/></td>
						<td class="td4"><span> </span><a id='lblDownname' class="lbl"> </a></td>
						<td class="td5" colspan="2"><input type="text" id="txtDownname" class="txt c1"/></td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td class="td2" colspan="5"><input type="text" id="txtMemo" class="txt c1"/></td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtTotal" class="txt num c1"/></td>
						<td class="td3"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtWorker" class="txt c1"/></td>	
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width: 2%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20%;"><a id='lblCust_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblReceiver_s'> </a></td>
					<td align="center" ><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><input class="btn"  id="btnCustno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <input type="text" id="txtCustno.*"  style="width:85%; float:left;"/>
                        <span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtNamea.*"  style="width:85%; float:left;"/>
					</td>
					<td><input id="txtMount.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td><input id="txtMoney.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td><input id="txtReceiver.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtMemo.*" type="text" style="width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
