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
            var q_name = "ordb";
            var q_readonly = ['txtTgg', 'txtAcomp','txtSales','txtNoa'];
            var q_readonlys = [];
            var bbmNum = [['txtFloata', 10, 5, 1],['txtMoney', 10, 0, 1],['txtTax', 10, 0, 1],['txtTotal', 10, 0, 1],['txtTotalus', 10, 0, 1]];
            var bbsNum = [['txtMount', 10, 0, 1],['txtPrice', 10, 3, 1],['txtTotal', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Odate';
            aPop = new Array(['txtProductno1_', 'btnProduct1_', 'bcc', 'noa,product,unit,price', 'txtProductno1_,txtProduct_,txtUnit_,txtPrice_', 'bcc_b.aspx']
							            ,['txtProductno2_', 'btnProduct2_', 'fixucc', 'noa,namea,unit,inprice', 'txtProductno2_,txtProduct_,txtUnit_,txtPrice_', 'fixucc_b.aspx']
							            ,['txtProductno3_', 'btnProduct3_', 'ucc', 'noa,product,unit,inprice', 'txtProductno3_,txtProduct_,txtUnit_,txtPrice_', 'ucc_b.aspx']
							            ,['txtSales', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
							            , ['txtWorker', 'lblWorker', 'sss', 'namea', 'txtWorker', 'sss_b.aspx']
							            ,['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx']
							            ,['txtTggno','lblTgg','tgg','noa,comp','txtTggno,txtTgg','tgg_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'no3'];
                q_brwCount();
               q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
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
                bbmMask = [['txtDatea', r_picd],['txtOdate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbKind", q_getPara('ordb.kind')); 
                q_cmbParse("cmbCoin", q_getPara('sys.coin'));      
                q_cmbParse("cmbPaytype", q_getPara('rc2.pay'));  
                q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
                
                $('#cmbPaytype').change(function () {
	            	$('#txtPay').val($('#cmbPaytype').find("option:selected").text())
			     });
			     //變動按鈕
                $('#cmbKind').change(function () {
                	for (var j = 0; j < q_bbsCount; j++) {
						btnMinus('btnMinus_'+j);
			         }
	            	product_change();
			     });
                
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
                
                if($('#cmbKind').find("option:selected").text().indexOf('物料')>-1){
                	for (var j = 0; j < q_bbsCount; j++) {
                		$('#txtProductno_'+j).val($('#txtProductno1_'+j).val());
			         }
              	}else if($('#cmbKind').find("option:selected").text().indexOf('零件')>-1){
              		for (var j = 0; j < q_bbsCount; j++) {
						$('#txtProductno_'+j).val($('#txtProductno2_'+j).val());
			         }
              	}else{
              		for (var j = 0; j < q_bbsCount; j++) {
              			$('#txtProductno_'+j).val($('#txtProductno3_'+j).val());
			         }
              	}
                
                
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('G' + $('#txtOdate').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('ordb_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
            		  if (!$('#btnMinus_' + i).hasClass('isAssign')) {
            		  		$('#txtMount_' + j).change(function () {
				            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				                q_bodyId($(this).attr('id'));
				                b_seq = t_IdSeq;
								q_tr('txtTotal_'+b_seq ,q_float('txtMount_'+b_seq)*q_float('txtPrice_'+b_seq));
								sum();
				            });
				            $('#txtPrice_' + j).change(function () {
				            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				                q_bodyId($(this).attr('id'));
				                b_seq = t_IdSeq;
				                q_tr('txtTotal_'+b_seq ,q_float('txtMount_'+b_seq)*q_float('txtPrice_'+b_seq));
				                sum();
				            });
            		  }
            	}
                _bbsAssign();
                product_change();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtOdate').val(q_date());
                $('#txtOdate').focus();
                product_change();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
                product_change();
            }

            function btnPrint() {

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
				as['kind'] = abbm2['kind'];
                as['tggno'] = abbm2['tggno'];
                as['odate'] = abbm2['kind'];
                as['enda'] = abbm2['enda'];
                //            t_err ='';
                //            if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
                //                t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

                //
                //            if (t_err) {
                //                alert(t_err)
                //                return false;
                //            }
                //
                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                var t_money=0;
                for(var j = 0; j < q_bbsCount; j++) {
					t_money+=q_float('txtTotal_'+j);
                }  // j
				q_tr('txtMoney' ,t_money);
				q_tr('txtTotal' ,q_float('txtMoney')+q_float('txtTax'));
            }

            function refresh(recno) {
                _refresh(recno);
                product_change();
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
            
            function product_change() {
                if($('#cmbKind').find("option:selected").text().indexOf('物料')>-1){
                	for (var j = 0; j < q_bbsCount; j++) {
                		$('#btnProduct1_'+j).removeAttr('hidden');
			           	$('#btnProduct2_'+j).attr('hidden', 'true');
			           	$('#btnProduct3_'+j).attr('hidden', 'true');
			           	$('#txtProductno1_'+j).removeAttr('hidden');
			           	$('#txtProductno2_'+j).attr('hidden', 'true');
			           	$('#txtProductno3_'+j).attr('hidden', 'true');
			           	$('#txtProductno1_'+j).val($('#txtProductno_'+j).val());
			         }
              	}else if($('#cmbKind').find("option:selected").text().indexOf('零件')>-1){
              		for (var j = 0; j < q_bbsCount; j++) {
              			$('#btnProduct1_'+j).attr('hidden', 'true');
			           	$('#btnProduct2_'+j).removeAttr('hidden');
			           	$('#btnProduct3_'+j).attr('hidden', 'true');
			           	$('#txtProductno1_'+j).attr('hidden', 'true');
			           	$('#txtProductno2_'+j).removeAttr('hidden');
			           	$('#txtProductno3_'+j).attr('hidden', 'true');
			           	$('#txtProductno2_'+j).val($('#txtProductno_'+j).val());
			         }
              	}else{
              		for (var j = 0; j < q_bbsCount; j++) {
              			$('#btnProduct1_'+j).attr('hidden', 'true');
			           	$('#btnProduct2_'+j).attr('hidden', 'true');
			           	$('#btnProduct3_'+j).removeAttr('hidden');
			           	$('#txtProductno1_'+j).attr('hidden', 'true');
			           	$('#txtProductno2_'+j).attr('hidden', 'true');
			           	$('#txtProductno3_'+j).removeAttr('hidden');
			           	$('#txtProductno3_'+j).val($('#txtProductno_'+j).val());
			         }
              	}
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
                width: 37%;
                float: left;
            }
            .txt.c3 {
                width: 57%;
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
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"--> 
        <div id='dmain' style="overflow:hidden;">
        <div class="dview" id="dview"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewTgg'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='odate'>~odate</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='tggno tgg,4'>~tggno ~tgg,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' >
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr class="tr1">
               <td class="td1"><span> </span><a id='lblKind' class="lbl"></a></td>
               <td class="td2"><select id="cmbKind" class="txt c1"></select></td>
               <td class="td3"><span> </span><a id='lblOdate' class="lbl"></a></td>
               <td class="td4"><input id="txtOdate" type="text" class="txt c1"/></td>
               <td class="td5"><span> </span><a id='lblDatea' class="lbl"></a></td>
               <td class="td6"><input id="txtDatea" type="text" class="txt c1"/></td>
               <td class="td7"><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td8"><input id="txtNoa"   type="text"  class="txt c1"/></td> 
            </tr>
            <tr class="tr2">
               <td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"></a></td>
               <td class="td2" colspan="2"><input id="txtCno"  type="text" class="txt c4"/>
               <input id="txtAcomp"    type="text" class="txt c5"/></td>
               <td class="td4"><span> </span><a id='lblFloata' class="lbl"></a></td>
                <td class="td5"><select id="cmbCoin" class="txt c1"></select></td>                 
                <td class="td6"><input id="txtFloata"  type="text"  class="txt num c1" /></td>                 
                <td class="td7"><span> </span><a id='lblContract' class="lbl"></a></td>
                <td class="td8"><input id="txtContract"  type="text" class="txt c1"/></td> 
            </tr>
           <tr class="tr3">
                <td class="td1"><span> </span><a id="lblTgg" class="lbl btn"></a></td>
                <td class="td2" colspan="2"><input id="txtTggno" type="text" class="txt c4"/>
                <input id="txtTgg"  type="text" class="txt c5"/></td>
                <td class="td4"><span> </span><a id='lblPay' class="lbl"></a></td>
                <td class="td5"  colspan='2'><select id="cmbPaytype" class="txt c1" ></select><input id="txtPay" type="hidden" class="txt c1"/></td>
                <td class="td7"><span> </span><a id='lblTrantype' class="lbl"></a></td>
                <td class="td8"><select id="cmbTrantype" class="txt c1" name="D1" ></select></td> 
            </tr>
            <tr class="tr4">
                <td class="td1"><span> </span><a id="lblSales" class="lbl btn"></a></td>
                <td class="td2" colspan="2"><input id="txtSalesno" type="text" class="txt c4"/> 
                <input id="txtSales" type="text" class="txt c5"/></td> 
                <td class="td4"><span> </span><a id='lblTel' class="lbl"></a></td>
                <td class="td5" colspan='2'><input id="txtTel"  type="text"  class="txt c1"/></td>
                <td class="td7"><span> </span><a id='lblFax' class="lbl"></a></td>
                <td class="td8"><input id="txtFax" type="text" class="txt c1"/></td>
            </tr>
            <tr class="tr5">
                <td class="td1"><span> </span><a id='lblAddr' class="lbl"></a></td>
                <td class="td2"><input id="txtPost"  type="text"  class="txt c1"/></td>
                <td class="td3" colspan='4' ><input id="txtAddr"  type="text" class="txt c1"/></td>
                <td class="td7"><span> </span><a id="lblApv" class="lbl"></a></td>
                <td class="td8"><input id="txtApv" type="text" class="txt c1" disabled="disable"/></td> 
            </tr>
            <tr class="tr6">
                <td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
                <td class="td2"><input id="txtMoney" type="text" class="txt num c1" /></td> 
                <td class="td3"><span> </span><a id='lblTax' class="lbl"></a></td>
                <td class="td4"><input id="txtTax"  type="text" class="txt num c1" /></td>
                <td class="td5"><select id="cmbTaxtype" class="txt c1" onchange="calTax()" ></select></td>
                <td class="td6"><span> </span><a id='lblTotal' class="lbl"></a></td>
                <td class="td7"><input id="txtTotal" type="text" class="txt num c1" /></td>
                <td class="td8"><input id="btnOrde" type="button" /></td>
            </tr>
            <tr class="tr7">
            	<td class="td1"><span> </span><a id='lblTotalus' class="lbl"></a></td>
                <td class="td2"><input id="txtTotalus"  type="text" class="txt num c1" /></td> 
                <td class="td3"><span> </span><a id='lblWorker' class="lbl btn"></a></td>
                <td class="td4"><input id="txtWorker"  type="text" class="txt c1" /></td> 
                <!--<td class="td4"><span> </span><a id='lblWeight' class="lbl"></a></td>
                <td class="td5" colspan='2'><input id="txtWeight"  type="text" class="txt num c1" /></td>--> 
                <td class="td5"><span> </span><a id='lblAeno' class="lbl"></a></td>
                <td class="td6"><input id="chkAeno" type="checkbox"/></td>
                <td class="td7"><span> </span><a id='lblEnd' class="lbl"></a></td>
                <td class="td8"><input id="txtEnda"  type="text" class="txt c1" /></td>
            </tr>
            <tr class="tr8">
                <td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
                <td class="td2" colspan='7'><textarea id="txtMemo" rows="5" cols="10" style="width: 99%; height: 50px;"></textarea></td> 
            </tr>
        </table>
        </div>
		</div>
        <div class='dbbs' >
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:10%;"><a id='lblProductno'></a></td>
                <td align="center" style="width:15%;"><a id='lblUno'></a></td>
                <!--<td align="center"><a id='lblSize'></a></td>-->
                <td align="center" style="width:5%;"><a id='lblUnit'></a></td>
                <td align="center" style="width:8%;"><a id='lblMount'></a></td>
                <!--<td align="center"><a id='lblWeights'></a></td>-->
                <td align="center" style="width:8%;"><a id='lblPrices'></a></td>
                <td align="center" style="width:10%;"><a id='lblTotals'></a></td>
                <td align="center" style="width:15%;"><a id='lblOrdenos'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
              	<td><input class="txt c1"  id="txtProductno1.*" type="text" />
              			<input class="txt c1"  id="txtProductno2.*" type="text" />
              			<input class="txt c1"  id="txtProductno3.*" type="text" />
              			<input class="txt c1"  id="txtProductno.*" type="hidden" />
                        <input class="txt c3" id="txtNo3.*" type="text" />
                        <input class="btn"  id="btnProduct1.*" type="button" value='...' style=" font-weight: bold;" />
                        <input class="btn"  id="btnProduct2.*" type="button" value='...' style=" font-weight: bold;" />
                        <input class="btn"  id="btnProduct3.*" type="button" value='...' style=" font-weight: bold;" /></td>
                <td><input class="txt c1" id="txtProduct.*" type="text" />
                		<input class="txt c1" id="txtUno.*" type="text" /></td>
                <!--<td><input class="txt num c6" id="txtDime.*" type="text" />x
                	   <input class="txt num c6" id="txtWidth.*" type="text"  />x
                       <input class="txt num c6" id="txtLengthb.*" type="text" />
                       <input class="txt c1" id="txtSpec.*" type="text"  /></td>-->
                <td><input class="txt c1" id="txtUnit.*" type="text" /></td>
                <td><input class="txt num c1" id="txtMount.*" type="text" /></td>
                <!--<td><input class="txt num c1" id="txtWeight.*" type="text"/></td>-->
                <td><input class="txt num c1" id="txtPrice.*" type="text" /></td>
                <td><input class="txt num c1" id="txtTotal.*" type="text" />
                        <!--<input class="txt num c1" id="txtTheory.*" type="text" />--></td>
                <td><input class="txt" id="txtOrdeno.*" type="text" style="width:73%;" />
                		<input class="txt" id="txtNo2.*" type="text" style="width:20%;" /></td>
                <td><input class="txt c1" id="txtMemo.*" type="text" />
                		<input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
