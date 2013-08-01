<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title> </title>
    <script src="../script/jquery.min.js" type="text/javascript"> </script>
    <script src='../script/qj2.js' type="text/javascript"> </script>
    <script src='qset.js' type="text/javascript"> </script>
    <script src='../script/qj_mess.js' type="text/javascript"> </script>
    <script src="../script/qbox.js" type="text/javascript"> </script>
    <script src='../script/mask.js' type="text/javascript"> </script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        q_desc = 1;
        q_tables = 's';
        var q_name = "vcce";
        var q_readonly = ['txtNoa'];
        var q_readonlys = [];
        var bbmNum = [];  
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp,tel,trantype,addr_comp', 'txtCustno,txtComp,txtTel,txtTrantype,txtAddr_post', 'cust_b.aspx'],
        ['txtUno_', 'btnUno_', 'uccc', 'noa', 'txtUno_', 'uccc_seek_b.aspx','95%','60%'],
        ['txtStoreno2', 'lblStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();   
            q_gt(q_name, q_content, q_sqlCount, 1,0,'',r_accy);

        });

        //////////////////   end Ready
        function main() {
            if (dataErr)  
            {
                dataErr = false;
                return;
            }

            mainForm(1); 
        }  
        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
            q_cmbParse("cmbKind", q_getPara('sys.stktype'));  
             $('#cmbKind').change(function () {
	            	size_change();
			     });
			$('#btnWorkbimport').click(function(){
				var ordeno = $('#txtOrdeno').val();
				var t_where = '';
				if(ordeno.length > 0)
					t_where = "ordeno='" + ordeno + "'";
            	q_box("workb_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'workb', "95%", "95%", q_getMsg('popWorkb'));

			});
			$('#btnOrdeimport').click(function(){
				var ordeno = $('#txtOrdeno').val();
				var t_where = '';
				if(ordeno.length > 0)
					t_where = "noa='" + ordeno + "'";
            	q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'orde', "95%", "95%", q_getMsg('popOrde'));
			});
			$('#txtAddr_post').change(function(){
				var t_custno = trim($(this).val());
				if(!emp(t_custno)){
					focus_addr = $(this).attr('id');
					var t_where = "where=^^ noa='" + t_custno + "' ^^";
					q_gt('cust', t_where, 0, 0, 0, "");
				}  
			});
			$('#txtDeivery_addr').change(function(){
				var t_custno = trim($(this).val());
				if(!emp(t_custno)){
					focus_addr = $(this).attr('id');
					var t_where = "where=^^ noa='" + t_custno + "' ^^";
					q_gt('cust', t_where, 0, 0, 0, "");
				}  
			});
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 
            var ret;
            switch (b_pop) {   
				case 'workb':
					if (q_cur > 0 && q_cur < 4) {
						if (!b_ret || b_ret.length == 0)
							return;
						ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtWeight,txtMount,txtMemo,txtUno,txtDime,txtWidth,txtLengthb,txtSpec', b_ret.length, b_ret,
												'productno,product,bweight,born,memo,no2,dime,width,lengthb,spec','txtProductno');   /// 最後 aEmpField 不可以有【數字欄位】
						size_change();
						if(b_ret[0].ordeno != undefined){
							var t_where = "noa='" + b_ret[0].ordeno + "'";
		                    q_gt('orde', t_where , 0, 0, 0, "", r_accy);
	                   	}
					}
						break;
				case 'orde':
					if (q_cur > 0 && q_cur < 4) {
						if (!b_ret || b_ret.length == 0)
							return;
						ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtProductno,txtProduct,txtWeight,txtMount,txtPrice,txtDime,txtWidth,txtLengthb,txtSpec', b_ret.length, b_ret,
												 'noa,no2,productno,product,weight,mount,price,dime,width,lengthb,spec','txtProductno');   /// 最後 aEmpField 不可以有【數字欄位】
						size_change();
						if(b_ret[0].noa != undefined){
							var t_where = "noa='" + b_ret[0].noa + "'";
		                    q_gt('orde', t_where , 0, 0, 0, "", r_accy);
	                   	}
					}
						break;
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }

		var focus_addr='';
        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'orde':
            		var orde=_q_appendData("orde", "", true);
            		if(orde[0]!=undefined)
            			$('#txtCustno').val(orde[0].custno);
            			$('#txtComp').val(orde[0].comp);
            			$('#txtTel').val(orde[0].tel);
            			$('#txtTrantype').val(orde[0].trantype);
            			$('#txtAddr_post').val(orde[0].addr2);
            			$('#txtOrdeno').val(orde[0].noa);
            		break;
            	case 'cust':
            		var as = _q_appendData("cust", "", true);
            		if(as[0]!=undefined && focus_addr !=''){
            			$('#'+focus_addr).val(as[0].addr_fact);
            			focus_addr = '';
            		}
            		break;
                case q_name: if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('vcce_s.aspx', q_name + '_s', "500px", "360px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   
        }

        function bbsAssign() { 
        	for(var j = 0; j < q_bbsCount; j++) {
            	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
            		//將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
		                 $('#textSize1_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     
		                    if ($('#cmbKind').val().substr(0,1)=='A')
		            		{	
		            			q_tr('txtDime_'+b_seq ,q_float('textSize1_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize1_' + b_seq).val());
		            		}else if($('#cmbKind').val().substr(0,1)=='B'){
		            			q_tr('txtRadius_'+b_seq ,q_float('textSize1_'+b_seq));//短徑$('#txtRadius_'+b_seq).val($('#textSize1_' + b_seq).val());	
		            		}
		                 });
		                 $('#textSize2_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     
		                    if ($('#cmbKind').val().substr(0,1)=='A')
		            		{	
		            			q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//寬度$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
		            		}else if($('#cmbKind').val().substr(0,1)=='B'){
		            			q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//長徑$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
		            		}
		                 });
		                 $('#textSize3_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
					         	
		                     if ($('#cmbKind').val().substr(0,1)=='A')
		            		{	
		            			q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize3_' + b_seq).val());	
		            		}else if($('#cmbKind').val().substr(0,1)=='B'){
		            			q_tr('txtDime_'+b_seq ,q_float('textSize3_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize3_' + b_seq).val());		
		            		}else{//鋼筋、胚
		            			q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));
		            		}
		                 });
		                 $('#textSize4_' + j).change(function () {
		                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                     q_bodyId($(this).attr('id'));
		                     b_seq = t_IdSeq;
		                     
		                     if ($('#cmbKind').val().substr(0,1)=='A')
		            		{	
		            			q_tr('txtRadius_'+b_seq ,q_float('textSize4_'+b_seq));//短徑為0 $('#txtRadius_'+b_seq).val($('#textSize4_' + b_seq).val());	
		            		}else if($('#cmbKind').val().substr(0,1)=='B'){
		            			q_tr('txtLengthb_'+b_seq ,q_float('textSize4_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize4_' + b_seq).val());	
		            		}
		                 });
		                  $('#txtWeight_' + j).change(function () {
		                     sum()
		                 });
		                 
            	}
			}
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            size_change();
            $('#txtDatea').focus();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            size_change();
            $('#txtProduct').focus();
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['product'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];
         
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j

        }

        ///////////////////////////////////////////////////  
        function refresh(recno) {
            _refresh(recno);
            size_change();
       }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
			size_change();
        }

        function btnMinus(id) {
            _btnMinus(id);
            sum();
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield);
            size_change();
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
        function size_change () {
			if(q_cur==1 || q_cur==2){
				$('input[id*="textSize"]').removeAttr('disabled');
			}else{
				$('input[id*="textSize"]').attr('disabled', 'disabled');
			}
		  	if($('#cmbKind').val().substr(0,1)=='A'){
            	$('#lblSize_help').text("厚度x寬度x長度");
	        	for (var j = 0; j < q_bbsCount; j++) {
	            	$('#textSize1_'+j).show();
	            	$('#textSize2_'+j).show();
	            	$('#textSize3_'+j).show();
			        $('#textSize4_'+j).hide();
			        $('#x1_'+j).show();
			        $('#x2_'+j).show();
			        $('#x3_'+j).hide();
			        $('#Size').css('width','222px');
			        q_tr('textSize1_'+ j ,q_float('txtDime_'+j));
			        q_tr('textSize2_'+ j ,q_float('txtWidth_'+j));
			        q_tr('textSize3_'+ j ,q_float('txtLengthb_'+j));
			        $('#textSize4_'+j).val(0);
			        $('#txtRadius_'+j).val(0)
				}
			}else if($('#cmbKind').val().substr(0,1)=='B'){
				$('#lblSize_help').text("短徑x長徑x厚度x長度");
			    for (var j = 0; j < q_bbsCount; j++) {
			    	$('#textSize1_'+j).show();
	            	$('#textSize2_'+j).show();
	            	$('#textSize3_'+j).show();
			        $('#textSize4_'+j).show();
			        $('#x1_'+j).show();
			        $('#x2_'+j).show();
			        $('#x3_'+j).show();
			        $('#Size').css('width','297px');
			        q_tr('textSize1_'+ j ,q_float('txtRadius_'+j));
			        q_tr('textSize2_'+ j ,q_float('txtWidth_'+j));
			        q_tr('textSize3_'+ j ,q_float('txtDime_'+j));
			        q_tr('textSize4_'+ j ,q_float('txtLengthb_'+j));
				}
			}else{//鋼筋和鋼胚
				$('#lblSize_help').text("長度");
	            for (var j = 0; j < q_bbsCount; j++) {
	            	$('#textSize1_'+j).hide();
	            	$('#textSize2_'+j).hide();
	            	$('#textSize3_'+j).show();
			        $('#textSize4_'+j).hide();
			        $('#x1_'+j).hide();
			        $('#x2_'+j).hide();
			        $('#x3_'+j).hide();
			        $('#Size').css('width','70px');
			        $('#textSize1_'+j).val(0);
			        $('#txtDime_'+j).val(0)
			        $('#textSize2_'+j).val(0);
			        $('#txtWidth_'+j).val(0)
			        q_tr('textSize3_'+ j ,q_float('txtLengthb_'+j));
			        $('#textSize4_'+j).val(0);
			        $('#txtRadius_'+j).val(0)
				}
			}
		}
    </script>
    <style type="text/css">
                #dmain {
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
            .tbbm tr td{
                width: 9%;
            }
            .tbbm .tdZ {
                width: 3%;
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
                width: 97%;
                float: left;
            }
            .txt.c2 {
                width: 14%;
                float: left;
            }
            .txt.c3 {
                width: 26%;
                float: left;
            }
            .txt.c4 {
                width: 25%;
                float: left;
            }
            .txt.c5 {
                width: 65%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
                
            }
            .txt.c7 {
                width: 98%;
                float: left;
            }
            .txt.c8 {
            	float:left;
                width: 65px;
                
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
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 1600px;
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
        .tbbs
        {
            FONT-SIZE: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:98% ;  
        }  
      
       .tbbs .td1
        {
            width: 4%;
        }
        .tbbs .td2
        {
            width: 6%;
        }
        .tbbs .td3
        {
            width: 8%;
        }
        .tbbs .td4
        {
            width: 2%;
        }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
    <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:20%"><a id='vewDatea'> </a></td>
                <td align="center" style="width:25%"><a id='vewComp'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='comp,4'>~comp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
            <td class='td1'><span> </span><a id="lblDatea" class="lbl"> </a></td>
            <td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
            <td class='td3'><select id="cmbKind" class="txt c1"> </select></td>
            <td class="td4"><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td class="td5"><input id="txtNoa"  type="text" class="txt c1"/> </td>
            <td class='td6'><span> </span><a id="lblCldate" class="lbl"> </a></td>
            <td class="td7"><input id="txtCldate"  type="text" class="txt c1"/></td>
        </tr>
        <tr class="tr2">
            <td class='td1'><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
            <td class="td2"><input id="txtCustno"  type="text" class="txt c1"/></td>
            <td class='td3' colspan="3"><input id="txtComp"  type="text" class="txt c7"/></td>
            <td class="td6"><span> </span><a id="lblCaseno" class="lbl"> </a></td>
            <td class="td7"><input id="txtCaseno"  type="text" class="txt c1"/> </td>
            <td class="td8"><input id="txtCaseno2"  type="text" class="txt c1"/> </td>
        </tr>
        <tr class="tr3">
        	<td class='td1'><span> </span><a id="lblTel" class="lbl"> </a></td>
            <td class="td2" colspan="4"><input id="txtTel"  type="text" class="txt c7"/></td>
            <td class="td3"><span> </span><a id="lblTrantype" class="lbl"> </a></td>
            <td class="td4"><input id="txtTrantype"  type="text" class="txt c1"/> </td>
        </tr>
        <tr class="tr4">
            <td class='td1'><span> </span><a id="lblAddr_post" class="lbl"> </a></td>
            <td class="td2" colspan="4"><input id="txtAddr_post"  type="text" class="txt c7"/> </td>
            <td class='td3'><span> </span><a id="lblStype" class="lbl"> </a> </td>
            <td class="td4"><input id="txtStype"  type="text" class="txt c1"/> </td>
        </tr>
        <tr class="tr5">
            <td class='td1'><span> </span><a id="lblDeivery_addr" class="lbl"> </a></td>
            <td class="td2" colspan="4"><input id="txtDeivery_addr"  type="text" class="txt c7"/> </td>
            <td class='td3'><span> </span><a id="lblOrdeno" class="lbl"> </a> </td>
            <td class="td4"><input id="txtOrdeno"  type="text" class="txt c1"/> </td>
            <!--<td class="td5"><input id="btnWorkbimport" type="button"/> </td>-->
            <td class="td6"><input id="btnOrdeimport" type="button"/> </td>
        </tr>   
        <tr class="tr6">
            <td class='td1'><span> </span><a id="lblWeight" class="lbl"> </a></td>
            <td class="td2"><input id="txtWeight"  type="text" class="txt c1 num"/></td>
            <td class='td3'> </td>
            <td class="td4"><span> </span><a id="lblCardeal" class="lbl"> </a></td>
            <td class="td5"><input id="txtCardeal"  type="text" class="txt c1"/> </td>
            <td class='td6'><span> </span><a id="lblCarno" class="lbl"> </a></td>
            <td class="td7"><input id="txtCarno"  type="text" class="txt c1"/></td>
            <td class='td8'><span> </span><a id="lblTotal" class="lbl"> </a></td>
            <td class="td9"><input id="txtTotal"  type="text" class="txt c1 num"/></td>
        </tr> 
        <tr class="tr7">
        	<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
        	<td class="td2" colspan="8"><textarea id="txtMemo" cols="5" rows="10" style="width: 99%;height: 50px;"> </textarea></td>
        </tr>                          
        </table>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:8%;"><a id='lblOrdeno_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblNo2_s'> </a></td>
                <td align="center" style="width:8%;"><a id='lblUno_s'> </a></td>
                <td align="center" style="width:15%;"><a id='lblProductno_s'> </a></td>
                <td align="center" id='Size'><a id='lblSize_st'> </a><BR><a id='lblSize_help'> </a></td>
                <td align="center" style="width:5%;"><a id='lblMount_s'> </a></td>
                <td align="center" style="width:5%;"><a id='lblWeight_s'> </a></td>
                <td align="center" style="width:5%;"><a id='lblPrice_s'> </a></td>
                <td align="center" style="width:4%;"><a id='lblEnds_s'> </a></td>
                <td align="center" style="width:5%;"><a id='lblEweight_s'> </a></td>
                <td align="center" style="width:5%;"><a id='lblEcount_s'> </a></td>
                <td align="center" style="width:5%;"><a id='lblAdjweight_s'> </a></td>
                <td align="center" style="width:5%;"><a id='lblAdjcount_s'> </a></td>
                <td align="center"><a id='lblMemo_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtOrdeno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtNo2.*" type="text" /></td>
                <td ><input class="txt c1" id="txtUno.*" type="text" style="width:80%;" />
                	<input class="btn" id="btnUno.*" type="button" value='.' style="width:1%;"/></td>
                <td><input class="txt c4" id="txtProductno.*" type="text" />
                	 <input class="txt c5" id="txtProduct.*" type="text" /></td>
                <td><input class="txt num c8" id="textSize1.*" type="text" disabled="disabled"/><div id="x1.*" style="float: left"> x</div>
                		<input class="txt num c8" id="textSize2.*" type="text" disabled="disabled"/><div id="x2.*" style="float: left"> x</div>
                        <input class="txt num c8" id="textSize3.*" type="text" disabled="disabled"/><div id="x3.*" style="float: left"> x</div>
                         <input class="txt num c8" id="textSize4.*" type="text" disabled="disabled"/>
                         <!--上為虛擬下為實際-->
                         <input id="txtRadius.*" type="hidden"/>
                		<input  id="txtWidth.*" type="hidden"/>
                        <input  id="txtDime.*" type="hidden"/>
                         <input id="txtLengthb.*" type="hidden"/>
                         <input class="txt c1" id="txtSpec.*" type="text"/>
                </td>
                <td ><input class="txt num c1" id="txtMount.*" type="text"/></td>
                <td ><input class="txt num c1" id="txtWeight.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtPrice.*" type="text" /></td>
                <td align="center"><input id="chkEnda.*" type="checkbox"/></td>
                <td ><input class="txt num c1" id="txtEweight.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtEcount.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtAdjweight.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtAdjcount.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
 