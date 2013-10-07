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
        var q_name = "rc2e";
        var q_readonly = ['txtNoa','txtWorker'];
        var q_readonlys = [];
        var bbmNum = [['txtWeight', 15, 3, 1],['txtTotal', 15, 0, 1]];  
        var bbsNum = [['textSize1', 10, 3, 1],['textSize2', 10, 2, 1],['textSize3', 10, 3, 1],['textSize4', 10, 2, 1],['txtMount', 10, 0, 1],['txtWeight', 15, 3, 1],['txtPrice', 10, 2, 1]];
        var bbmMask = [];
        var bbsMask = [['txtStyle','A']];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
         aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
        ['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],
        ['txtUno_', 'btnUno_', 'view_uccc', 'uno', 'txtUno_', 'uccc_seek_b.aspx','95%','60%'],
        ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
          
            q_brwCount();   
			q_gt('style','',0,0,0,'');
            q_gt(q_name, q_content, q_sqlCount, 1)

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
            /* 若非本會計年度則無法存檔 */
			$('#txtDatea').focusout(function () {
				if($(this).val().substr( 0,3)!= r_accy){
			        	$('#btnOk').attr('disabled','disabled');
			        	alert(q_getMsg('lblDatea') + '非本會計年度。');
				}else{
			       		$('#btnOk').removeAttr('disabled');
				}
			});
			
			//變動尺寸欄位
			$('#cmbKind').change(function () {
	        	size_change();
			});
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 
            var ret;
            switch (b_pop) {   
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }

		var StyleList = '';
		var t_uccArray = new Array;
        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'style' :
            			var as = _q_appendData("style", "", true);
            			StyleList = new Array();
            			StyleList = as;
            			break;
                case q_name: 
                	t_uccArray = _q_appendData("ucc", "", true);
                	if (q_cur == 4)   
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

            q_box('rc2e_s.aspx', q_name + '_s', "500px", "360px", q_getMsg("popSeek"));
        }

		function getTheory(b_seq){
			t_Radius = $('#txtRadius_'+b_seq).val();
			t_Width = $('#txtWidth_'+b_seq).val();
			t_Dime = $('#txtDime_'+b_seq).val();
			t_Lengthb = $('#txtLengthb_'+b_seq).val();
			t_Mount = $('#txtMount_'+b_seq).val();
			t_Style = $('#txtStyle_'+b_seq).val();
			t_Productno = $('#txtProductno_' + b_seq).val();
			var theory_setting={
				calc:StyleList,
				ucc:t_uccArray,
				radius:t_Radius,
				width:t_Width,
				dime:t_Dime,
				lengthb:t_Lengthb,
				mount:t_Mount,
				style:t_Style,
				productno:t_Productno
			};
			return theory_st(theory_setting);
		}

        function bbsAssign() {  
			for(var j = 0; j < q_bbsCount; j++) {
				if (!$('#btnMinus_' + j).hasClass('isAssign')) {
					$('#txtStyle_' + j).blur(function(){
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					    q_bodyId($(this).attr('id'));
					    b_seq = t_IdSeq;
						ProductAddStyle(b_seq);
					});
					//將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
		            $('#textSize1_' + j).change(function () {
		            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                q_bodyId($(this).attr('id'));
		                b_seq = t_IdSeq;
		                if ($('#cmbKind').val().substr(0,1)=='A'){	
		            		q_tr('txtDime_'+b_seq ,q_float('textSize1_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize1_' + b_seq).val());
						}else if( $('#cmbKind').val().substr(0,1)=='B'){
		            		q_tr('txtRadius_'+b_seq ,q_float('textSize1_'+b_seq));//短徑$('#txtRadius_'+b_seq).val($('#textSize1_' + b_seq).val());	
						}
						q_tr('txtWeight_'+b_seq ,getTheory(b_seq));
					});
					$('#textSize2_' + j).change(function () {
						t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if ($('#cmbKind').val().substr(0,1)=='A'){	
		            		q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//寬度$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
						}else if($('#cmbKind').val().substr(0,1)=='B'){
		            		q_tr('txtWidth_'+b_seq ,q_float('textSize2_'+b_seq));//長徑$('#txtWidth_'+b_seq).val($('#textSize2_' + b_seq).val());	
						}
						q_tr('txtWeight_'+b_seq ,getTheory(b_seq));
					});
					$('#textSize3_' + j).change(function () {
		            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                q_bodyId($(this).attr('id'));
		                b_seq = t_IdSeq;
		                if ($('#cmbKind').val().substr(0,1)=='A'){	
		            		q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize3_' + b_seq).val());	
						}else if($('#cmbKind').val().substr(0,1)=='B'){
		            		q_tr('txtDime_'+b_seq ,q_float('textSize3_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize3_' + b_seq).val());		
						}else{//鋼筋、胚
		            		q_tr('txtLengthb_'+b_seq ,q_float('textSize3_'+b_seq));
						}
						q_tr('txtWeight_'+b_seq ,getTheory(b_seq));
					});
		            $('#textSize4_' + j).change(function () {
		            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		                q_bodyId($(this).attr('id'));
		                b_seq = t_IdSeq;
		                if ($('#cmbKind').val().substr(0,1)=='A'){	
		            		q_tr('txtRadius_'+b_seq ,q_float('textSize4_'+b_seq));//短徑為0 $('#txtRadius_'+b_seq).val($('#textSize4_' + b_seq).val());	
						}else if($('#cmbKind').val().substr(0,1)=='B'){
		            		q_tr('txtLengthb_'+b_seq ,q_float('textSize4_'+b_seq));//長度$('#txtLengthb_'+b_seq).val($('#textSize4_' + b_seq).val());	
						}
						q_tr('txtWeight_'+b_seq ,getTheory(b_seq));
					});
		            $('#txtMount_' + j).change(function () {
		            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						q_tr('txtWeight_'+b_seq ,getTheory(b_seq));
					});
					//-------------------------------------------------------------------------------------
				}
			}
            _bbsAssign();
            size_change();
        }

        function btnIns() {
            _btnIns();
            size_change();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtProduct').focus();
            size_change();
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['productno'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }
            q_nowf();
            as['date'] = abbm2['date'];
            return true;
        }

        function sum() {
        	var tot_Weight = 0;
        	var tot_Money = 0;
        	var t_Weight,t_Mount,t_Price;
            for (var j = 0; j < q_bbsCount; j++) {
            	t_Weight = dec($('#txtWeight_' + j).val());
            	t_Mount = dec($('#txtMount_' + j).val());
            	t_Price = dec($('#txtPrice_' + j).val());
				tot_Weight += dec($('#txtWeight_' + j).val());
				tot_Money += round((t_Weight*t_Mount*t_Price),0);
            }
			$('#txtWeight').val(tot_Weight);
			$('#txtTotal').val(tot_Money);
        }

        ///////////////////////////////////////////////////  
        function refresh(recno) {
            _refresh(recno);
            size_change();
			$('input[id*="txtProduct_"]').each(function(){
				t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				q_bodyId($(this).attr('id'));
				b_seq = t_IdSeq;
				OldValue = $(this).val();
				nowStyle = $('#txtStyle_'+b_seq).val();
				if(!emp(nowStyle) && (StyleList[0] != undefined)){
					for(var i = 0;i < StyleList.length;i++){
	               		if(StyleList[i].noa.toUpperCase() == nowStyle){
	              			styleProduct = StyleList[i].product;
							if(OldValue.substr(OldValue.length-styleProduct.length) == styleProduct){
								OldValue = OldValue.substr(0,OldValue.length-styleProduct.length);
							}
	               		}
	               	}
	            }
				$(this).attr('OldValue',OldValue);
			});
		}
		
		function q_popPost(s1) {
                switch (s1) {
                    case 'txtProductno_':
						$('input[id*="txtProduct_"]').each(function(){
		                	$(this).attr('OldValue',$(this).val());
		                });
		                ProductAddStyle(b_seq);
		                $('#txtStyle_' + b_seq).focus();
		                break;
                }
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
        
		function size_change() {
			if(q_cur==1 || q_cur==2){
				$('input[id*="textSize"]').removeAttr('disabled');
			}else{
				$('input[id*="textSize"]').attr('disabled', 'disabled');
			}
		  	if( $('#cmbKind').val().substr(0,1)=='A'){
            	$('#lblSize_help').text(q_getPara('sys.lblSizea'));
	        	for (var j = 0; j < q_bbsCount; j++) {
	            	$('#textSize1_'+j).show();
	            	$('#textSize2_'+j).show();
	            	$('#textSize3_'+j).show();
			        $('#textSize4_'+j).hide();
			        $('#x1_'+j).show();
			        $('#x2_'+j).show();
			        $('#x3_'+j).hide();
			        $('#Size').css('width','222px');
			        $('#textSize1_'+j).val($('#txtDime_'+j).val());
			        $('#textSize2_'+j).val($('#txtWidth_'+j).val());
			        $('#textSize3_'+j).val($('#txtLengthb_'+j).val());
			        $('#textSize4_'+j).val(0);
			        $('#txtRadius_'+j).val(0)
				}
			}else if( $('#cmbKind').val().substr(0,1)=='B'){
				$('#lblSize_help').text(q_getPara('sys.lblSizeb'));
			    for (var j = 0; j < q_bbsCount; j++) {
			    	$('#textSize1_'+j).show();
	            	$('#textSize2_'+j).show();
	            	$('#textSize3_'+j).show();
			        $('#textSize4_'+j).show();
			        $('#x1_'+j).show();
			        $('#x2_'+j).show();
			        $('#x3_'+j).show();
			        $('#Size').css('width','297px');
			        $('#textSize1_'+j).val($('#txtRadius_'+j).val());
			        $('#textSize2_'+j).val($('#txtWidth_'+j).val());
			        $('#textSize3_'+j).val($('#txtDime_'+j).val());
			        $('#textSize4_'+j).val($('#txtLengthb_'+j).val());
				}
			}else{//鋼筋和鋼胚
				$('#lblSize_help').text(q_getPara('sys.lblSizec'));
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
			        $('#txtWidth_'+j).val(0);
			        $('#textSize3_' + j).val($('#txtLengthb_'+j).val());
			        $('#textSize4_'+j).val(0);
			        $('#txtRadius_'+j).val(0);
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 25%;
                float: left;
            }
            .txt.c3 {
                width: 73%;
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
                width: 90%;
                
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
                width: 1800px;
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
             width:100% ;  
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
    </style>
</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
<!--#include file="../inc/toolbar.inc"-->
  <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:20%"><a id='vewDatea'> </a></td>
                <td align="center" style="width:25%"><a id='vewTgg'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='tgg,4'>~tgg,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
            <td class='td1'><span> </span><a id="lblDatea" class="lbl"> </a></td>
            <td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
            <td class="td3"><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td class="td4"><input id="txtNoa"  type="text" class="txt c1"/> </td>
            <td class='td5'><span> </span><a id="lblKind" class="lbl"> </a></td>
            <td class="td6"><select id="cmbKind" class="txt c1"> </select></td>
            <td class="td7"> </td>
        </tr>
        <tr class="tr2">
            <td class='td1'><span> </span><a id="lblTggno" class="lbl btn"> </a></td>
            <td class="td2" colspan="4"><input id="txtTggno"  type="text" class="txt c2"/>
            <input id="txtTgg"  type="text" class="txt c3"/></td>
        </tr>
        <tr class="tr3">
        	<td class="td1"><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
            <td class="td2" colspan="4"><input id="txtCustno"  type="text" class="txt c2"/>
            				<input id="txtComp"  type="text" class="txt c3"/> </td>
        </tr>
        <tr class="tr4">
        	<td class='td1'><span> </span><a id="lblTel" class="lbl"> </a></td>
            <td class="td2" colspan="4"><input id="txtTel"  type="text" class="txt c7"/></td>
            <td class="td6"> </td>
            <td class="td7"> </td>
        </tr>
        <tr class="tr5">
            <td class='td1'><span> </span><a id="lblAddr_post" class="lbl"> </a></td>
            <td class="td2" colspan="4"><input id="txtAddr_post"  type="text" class="txt c7"/> </td>
            <td class='td6'><span> </span><a id="lblEnda" class="lbl"> </a> </td>
            <td class="td7"><input id="chkEnda" type="checkbox"/> </td>
        </tr>
        <tr class="tr6">
            <td class='td1'><span> </span><a id="lblDeivery_addr" class="lbl"> </a></td>
            <td class="td2" colspan="4"><input id="txtDeivery_addr"  type="text" class="txt c7"/> </td>
            <td class='td6'><span> </span><a id="lblOrdeno" class="lbl"> </a> </td>
            <td class="td7"><input id="txtOrdeno"  type="text" class="txt c1"/> </td>
        </tr>   
        <tr class="tr7">
            <td class='td1'><span> </span><a id="lblWeight" class="lbl"> </a></td>
            <td class="td2"><input id="txtWeight"  type="text" class="txt num c1"/></td>
            <td class="td3"><span> </span><a id="lblTotal" class="lbl"> </a></td>
            <td class="td4"><input id="txtTotal"  type="text" class="txt num c1"/> </td>
            <td class="td5"><span> </span><a id="lblWorker" class="lbl"> </a></td>
            <td class="td6"><input id="txtWorker"  type="text" class="txt c1"/> </td>
        </tr> 
        <tr class="tr8">
        	<td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
        	<td class="td2" colspan="7"><textarea id="txtMemo" cols="5" rows="10" style="width: 99%;height: 50px;"> </textarea></td>
        </tr>                          
        </table>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" style="width: 7%;"><a id='lblStoreno_st'> </a></td>
                <td align="center" style="width: 10%;"><a id='lblUno_st'> </a></td>
                <td align="center" style="width: 8%;"><a id='lblProductno_st'> </a></td>
                <td align="center" style="width: 30px;"><a id='lblStyle_st'> </a></td>
                <td align="center" style="width: 9%;"><a id='lblProduct_st'> </a></td>
                <!--<td align="center" class="td1"><a id='lblSpec_st'> </a></td>-->
                <td align="center" id='Size'><a id='lblSize_help'> </a><BR><a id='lblSize_st'> </a></td>
                <td align="center" style="width: 12%;"><a id='lblSizea_st'> </a></td>
                <td align="center" style="width: 6%;"><a id='lblMount_st'> </a></td>
                <td align="center" style="width: 6%;"><a id='lblWeight_st'> </a></td>
                <td align="center" style="width: 6%;"><a id='lblPrice_st'> </a></td>
                <td align="center" style="width: 5%;"><a id='lblHand_st'> </a></td>
                <td align="center" style="width: 5%;"><a id='lblEnds_st'> </a></td>
                <td align="center"><a id='lblMemo_st'> </a></td>
                <td align="center"><a id='lblDescr_st'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td ><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtStoreno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtUno.*" type="text" style="width:80%;" />
                	<input class="btn" id="btnUno.*" type="button" value='.' style="width:1%;"/></td>
               	<td><input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                    <input type="text" id="txtProductno.*"  style="width:75%; float:left;"/>
                    <input id="txtClass.*" type="text" style="width: 75%;"/>
				</td>
				<td><input type="text" id="txtStyle.*" style="text-align:center;" class="txt c6"/></td>
				<td><input type="text" id="txtProduct.*" class="txt c1"/></td>
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
                <td ><input class="txt c1" id="txtSize.*" type="text"/></td>
                <td ><input class="txt num c1" id="txtMount.*" type="text"/></td>
                <td ><input class="txt num c1" id="txtWeight.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtPrice.*" type="text" /></td>
                
                <td ><input class="txt c1" id="txtHand.*" type="text" /></td>
                <td ><input class="txt c1" id="txtEnds.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
                <td ><input class="txt c1" id="txtDescr.*" type="text" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
 