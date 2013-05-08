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
            q_desc=1;
            q_tables = 's';
            var q_name = "quat";
            var q_readonly = ['txtComp', 'txtAcomp','txtSales','txtWorker'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney', 15, 0, 1],['txtTax', 10, 0, 1],['txtTotal', 15, 0, 1],['txtTotalus', 15, 2, 1],['txtWeight', 15, 3, 1]];
            var bbsNum = [['textSize1', 10, 3, 1],['textSize2', 10, 2, 1],['textSize3', 10, 3, 1],['textSize4', 10, 2, 1],['txtMount', 10, 0, 1],['txtWeight', 15, 3, 1],['txtPrice', 10, 2, 1],['txtTotal', 15, 0, 1],['txtTheory', 15, 3, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],
            ['txtCustno', 'lblCust', 'cust', 'noa,comp,paytype', 'txtCustno,txtComp,txtPaytype', 'cust_b.aspx'],
            ['txtSales', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
            ['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx']);
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
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbStype", q_getPara('vcc.stype')); 
                q_cmbParse("cmbCoin", q_getPara('sys.coin'));     
                q_cmbParse("combPaytype", q_getPara('vcc.paytype'));  
                q_cmbParse("cmbTrantype", q_getPara('vcc.tran'));
                q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));  
                q_cmbParse("cmbKind", q_getPara('quatst.kind'));
                /* 若非本會計年度則無法存檔 */
				$('#txtDatea').focusout(function () {
					if($(this).val().substr( 0,3)!= r_accy){
				        	$('#btnOk').attr('disabled','disabled');
					}else{
				       		$('#btnOk').removeAttr('disabled');
					}
				});
				//變動尺寸欄位
				$('#cmbKind').change(function () {
		        	size_change();
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
                	case 'ucc_style':
            			theory_st(q_name,b_seq,'txtTheory');
            		break;
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
                 $('#txtWorker').val(r_name)
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('quat_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combPaytype_chg() {
            	 var cmb = document.getElementById("combPaytype")
	            if (!q_cur) 
	                cmb.value = '';
	            else
	                $('#txtPaytype').val(cmb.value);
	            cmb.value = '';
            }

            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						//將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
			            $('#textSize1_' + j).change(function () {
			            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                q_bodyId($(this).attr('id'));
			                b_seq = t_IdSeq;
			                     
			                if ($('#cmbKind').find("option:selected").text().indexOf('板')>-1)
			            	{	
			            		q_tr('txtDime_'+b_seq ,q_float('textSize1_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize1_' + b_seq).val());
							}else if( $('#cmbKind').find("option:selected").text().indexOf('管')>-1){
			            		q_tr('txtRadius_'+b_seq ,q_float('textSize1_'+b_seq));//短徑$('#txtRadius_'+b_seq).val($('#textSize1_' + b_seq).val());	
							}
			            		
							var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
							q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
						});
						$('#textSize2_' + j).change(function () {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
			                     
							if ($('#cmbKind').find("option:selected").text().indexOf('板')>-1)
							{	
			            		q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//寬度$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
							}else if( $('#cmbKind').find("option:selected").text().indexOf('管')>-1){
			            		q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//長徑$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
							}
			                     
			                var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
							q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
						});
						$('#textSize3_' + j).change(function () {
			            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                q_bodyId($(this).attr('id'));
			                b_seq = t_IdSeq;
						         	
			                if ($('#cmbKind').find("option:selected").text().indexOf('板')>-1)
			            	{	
			            		q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize3_' + b_seq).val());	
							}else if( $('#cmbKind').find("option:selected").text().indexOf('管')>-1){
			            		q_tr('txtDime_'+b_seq ,q_float('textSize3_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize3_' + b_seq).val());		
							}else{//鋼筋、胚
			            		q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));
							}
			                     
			                var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
							q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
						});
			            $('#textSize4_' + j).change(function () {
			            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                q_bodyId($(this).attr('id'));
			                b_seq = t_IdSeq;
			                     
			                if ($('#cmbKind').find("option:selected").text().indexOf('板')>-1)
			            	{	
			            		q_tr('txtRadius_'+b_seq ,q_float('textSize4_'+b_seq));//短徑為0 $('#txtRadius_'+b_seq).val($('#textSize4_' + b_seq).val());	
							}else if( $('#cmbKind').find("option:selected").text().indexOf('管')>-1){
			            		q_tr('txtLengthb_'+b_seq ,q_float('textSize4_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize4_' + b_seq).val());	
							}
			            		
			                var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
							q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
						});
			            $('#txtMount_' + j).change(function () {
			            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
							q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
						});
						//-------------------------------------------------------------------------------------
					}
				}
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#cmbKind').val(q_getPara('vcc.kind'));
                size_change();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProduct').focus();
                size_change();
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
                for(var j = 0; j < q_bbsCount; j++) {

                }  // j

            }

            function refresh(recno) {
                _refresh(recno);
                size_change();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
					for (var j = 0; j < q_bbsCount; j++) {
				    	$('#textSize1_'+j).attr('disabled', 'disabled');
				        $('#textSize2_'+j).attr('disabled', 'disabled');
				        $('#textSize3_'+j).attr('disabled', 'disabled');
				        $('#textSize4_'+j).attr('disabled', 'disabled');
					}
				}else {
					for (var j = 0; j < q_bbsCount; j++) {
				    	$('#textSize1_'+j).removeAttr('disabled');
				        $('#textSize2_'+j).removeAttr('disabled');
				        $('#textSize3_'+j).removeAttr('disabled');
				        $('#textSize4_'+j).removeAttr('disabled');
					}
				}
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
            
		function size_change () {
		  if( $('#cmbKind').find("option:selected").text().indexOf('板')>-1){
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
			}else if( $('#cmbKind').find("option:selected").text().indexOf('管')>-1){
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
		function theory_st(q_name,id,txtweight) { //id 為BBS的id,txtweight為要bbs寫入的欄位
			var calc="";
			//var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+id).val()+"' ^^"; 
			//q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
			var as = _q_appendData("ucc", "", true);
			if(as[0]==undefined)
			{
				//alert('請輸入正確材質');
				return;
			}else{
				if(as[0].styleno=='')
				{
					//alert('該品號尚未輸入樣式');
					return;
				}
			}
			//判斷表身參考theory:40
			if(q_name=='uccb'||q_name=='uccc'||q_name=='cubu'||q_name=='ins'||q_name=='rc2s'||
				q_name=='ina'||q_name=='cut'||q_name=='cnn'||q_name=='cng'||q_name=='vcc'||
				q_name=='rc2'||q_name=='rc2e'||q_name=='ordc'||q_name=='ordb'||q_name=='get') 
			{
		        calc=as[0].calc3;//庫存
			}else{//內外銷與其他
				var cmb = document.getElementById("cmbStype");
				if (!cmb) {
					alert('cmbStype 不存在');
					return;
				}
				//qsys....orde.stype
				if($('#cmbStype').val()==3)
				    calc=as[0].calc2;	//外銷
				else
					calc=as[0].calc;	//內銷與其他
			}
			//空值判斷
			if(emp($('#txtDime_'+id).val()))
				$('#txtDime_'+id).val(0);
			if(emp($('#txtWidth_'+id).val()))
				$('#txtWidth_'+id).val(0);
			if(emp($('#txtLengthb_'+id).val()))
				$('#txtLengthb_'+id).val(0);
			if(emp($('#txtRadius_'+id).val()))
				$('#txtRadius_'+id).val(0);
			if(emp($('#txtMount_'+id).val()))
				$('#txtMount_'+id).val(0);

			eval('var result=' +calc.replace(/DIME/g,$('#txtDime_'+id).val()).replace(/WIDTH/g,$('#txtWidth_'+id).val()).replace(/LENGTH/g,$('#txtLengthb_'+id).val()).replace(/RADIUS/g,$('#txtRadius_'+id).val()));
		    //厚度=DIME 寬度=WIDTH 長度=LENGTH 外徑 =RADIUS
			q_tr(txtweight+'_'+id ,result*q_float('txtMount_'+id));//$('#'+txtweight+'_'+id).val(result*dec($('#txtMount_'+id).val()));
			
			var weight_total=0;
			for (var j = 0; j < q_bbsCount; j++) {
				weight_total+=dec($('#'+txtweight+'_'+j).val());
            }
			q_tr('txtWeight',weight_total);//$('#txtTotal').val(weight_total);
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
                width: 48%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
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
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size:medium;
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
        <div class="dview" id="dview">
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:25%"><a id='vewNoa'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='custno comp,4'>~custno ~comp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' >
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr class="tr1">
               <td class="td1"><span> </span><a id='lblStype' class="lbl"></a></td>
               <td class="td2"><select id="cmbStype" class="txt c1"></select></td>
               <td class="td3"></td>
               <td class="td4"><span> </span><a id='lblDatea' class="lbl"></a></td>
               <td class="td5"><input id="txtDatea" type="text"  class="txt c1"/></td>
               <td class="td6"></td>
               <td class="td7"><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td8"><input id="txtNoa" type="text" class="txt c1"/></td> 
            </tr>    
            <tr class="tr2">
               <td class="td1"><span> </span><a id="lblAcomp" class="lbl btn" ></a></td>
               <td class="td2" colspan="2"><input id="txtCno"  type="text"  class="txt c4"/>
               <input id="txtAcomp"  type="text" class="txt c5"/></td>
               <td class="td4"><span> </span><a id='lblFloata' class="lbl"></a></td>
               <td class="td5"><select id="cmbCoin" class="txt c1" ></select></td>                 
               <td class="td6"><input id="txtFloata"  type="text"  class="txt num c1" /></td>                 
               <td class="td7"><span> </span><a id='lblContract' class="lbl"></a></td>
               <td class="td8"><input id="txtContract"  type="text"  class="txt c1"/></td> 
            </tr>
           <tr class="tr3">
                <td class="td1"><span> </span><a id="lblCust" class="lbl btn"></a></td>
                <td class="td2" colspan="2"><input id="txtCustno" type="text" class="txt c4"/>
                <input id="txtComp"  type="text" class="txt c5"/></td>
                <td class="td4"><span> </span><a id='lblPaytype' class="lbl"></a></td>
                <td class="td5"><input id="txtPaytype" type="text" class="txt c1" /></td> 
                <td class="td6"><select id="combPaytype" class="txt c1"  onchange='combPaytype_chg()'></select></td> 
                <td class="td7"><span> </span><a id='lblTrantype' class="lbl"></a></td>
                <td class="td8"><select id="cmbTrantype" class="txt c1" name="D1" ></select></td> 
            </tr>
            <tr class="tr4">
                <td class="td1"><span> </span><a id="lblSales" class="lbl btn"></a></td>
                <td class="td2" colspan="2"><input id="txtSalesno" type="text" class="txt c4"/> 
                <input id="txtSales" type="text" class="txt c5"/></td> 
                <td class="td4"><span> </span><a id='lblTel' class="lbl"></a></td>
                <td class="td5" colspan='2'><input id="txtTel"  type="text" class="txt c1"/></td>
                <td class="td7"><span> </span><a id='lblFax' class="lbl"></a></td>
                <td class="td8"><input id="txtFax"  type="text"  class="txt c1"/></td>
            </tr>
            <tr class="tr5">
                <td class="td1"><span> </span><a id='lblAddr' class="lbl"></a></td>
                <td class="td2"><input id="txtPost" type="text"  class="txt c1"></td>
                <td class="td3" colspan='4' ><input id="txtAddr" type="text"  class="txt c1" /></td>
                 <td class='td7'><span> </span><a id="lblKind" class="lbl"> </a></td>
            	<td class="td8"><select id="cmbKind" class="txt c1"> </select></td>
            </tr>
            <tr class="tr6">
                <td class="td1"><span> </span><a id='lblAddr2' class="lbl"></a></td>
                <td class="td2"><input id="txtPost2"  type="text"  class="txt c1"/></td>
                <td class="td3" colspan='4'><input id="txtAddr2"  type="text"  class="txt c1"/></td>
                <td class="td7"><span> </span><a id='lblApv' class="lbl"></a></td>
                <td class="td8"><input id="txtApv"  type="text"  class="txt c1" disabled="disabled"/></td> 
            </tr>
            <tr class="tr7">
                <td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
                <td class="td2" colspan='2'><input id="txtMoney" type="text" class="txt num c1" /></td> 
                <td class="td4"><span> </span><a id='lblTax' class="lbl"></a></td>
                <td class="td5"><input id="txtTax" type="text"  class="txt num c1" /></td>
                <td class="td6"><select id="cmbTaxtype" class="txt c1"></select></td>
                <td class="td7"><span> </span><a id='lblTotal' class="lbl"></a></td>
                <td class="td8"><input id="txtTotal" type="text"  class="txt num c1" />
                </td> 
            </tr>
            <tr class="tr8">
                <td class="td1"><span> </span><a id='lblTotalus' class="lbl"></a></td>
                <td class="td2" colspan='2'><input id="txtTotalus" type="text"  class="txt num c1" /></td> 
                <td class="td4"><span> </span><a id='lblWeight' class="lbl"></a></td>
                <td class="td5" colspan='2' ><input id="txtWeight"  type="text"  class="txt num c1" /></td>
                <td class="td7"><span> </span><a id='lblWorker' class="lbl"></a></td>
                <td class="td8"><input id="txtWorker"  type="text" class="txt c1" /></td> 
            </tr>
            <tr class="tr9">
            	<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
                <td class="td2" colspan='7' ><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"></textarea></td>
                </tr>
        </table>
        </div>
        <div class='dbbs' >
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
              <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:9%;"><a id='lblProductno'></a></td>
                <td align="center"style="width:15%;"><a id='lblUno'></a></td>
                <td align="center" style="width:18%;" id='Size'><a id='lblSize_st'> </a><BR><a id='lblSize_help'> </a></td>
                <td align="center" style="width:4%;"><a id='lblUnit'></a></td>
                <td align="center" style="width:5%;"><a id='lblMount'></a></td>
                <td align="center" style="width:8%;"><a id='lblWeights'></a></td>
                <td align="center" style="width:6%;"><a id='lblPrices'></a></td>
                <td align="center" style="width:8%;"><a id='lblTotals'></a></td>
                <td align="center" style="width:8%;"><a id='lblClasss'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td ><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                 <td><input class="btn"  id="btnProduct.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                    <input type="text" id="txtProductno.*"  style="width:76%; float:left;"/>
                    <span style="display:block; width:1%;float:left;"> </span>
					<input type="text" id="txtNo3.*"  style="width:76%; float:left;"/>
				</td> 
                <td ><input id="txtProduct.*" type="text" class="txt c7"/>
                <input class="txt" id="txtUno.*" type="text"  class="txt c2"/></td>
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
                <td ><input id="txtUnit.*" type="text" class="txt c7"/></td>
                <td ><input id="txtMount.*" type="text"  class="txt num c7"/></td>
                <td ><input id="txtWeight.*" type="text"  class="txt num c7" /></td>
                <td ><input id="txtPrice.*" type="text" class="txt num c7" /></td>
                <td ><input id="txtTotal.*" type="text" class="txt num c7" />
                                      <input id="txtTheory.*" type="text" class="txt num c7" /></td>
                <td ><input id="txtClass.*" type="text" class="txt c7" /></td>
                <td><input id="txtMemo.*" type="text" class="txt c7"/>
                <input class="txt" id="txtOrdeno.*" type="text"style="width:65%;" />
                <input class="txt" id="txtNo2.*" type="text" style="width:20%;" />
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
