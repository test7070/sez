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
        q_tables = 's';
        var q_name = "ucce";
        var q_readonly = ['txtNoa'];
        var q_readonlys = [];
        var bbmNum = [];  
        var bbsNum = [['textSize1', 10, 3, 1],['textSize2', 10, 2, 1],['textSize3', 10, 3, 1],['textSize4', 10, 2, 1],['txtRadius', 10, 3, 1],['txtWidth', 10, 2, 1],['txtDime', 10, 3, 1],['txtLengthb', 10, 2, 1],['txtMount', 10, 2, 1],['txtPrice', 10, 2, 1],['txtTotal', 10, 0, 1],['txtEweight', 10, 1, 1],['txtAdjweight', 10, 1, 1],['txtEweight2', 10, 1, 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtStoreno', 'lblStore', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx'],
        ['txtStoreno2', 'lblStore2', 'store', 'noa,store', 'txtStoreno2,txtStore2', 'store_b.aspx'],
        ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],
        ['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            brwCount2=3;
            q_brwCount();   
            q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

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


        function q_gtPost(t_name) {  
            switch (t_name) {
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

            $('#txtWorker').val(r_name);
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ucce') + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('ucce_s.aspx', q_name + '_s', "500px", "530px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   
        }

        function bbsAssign() { 
            for (var j = 0; j < ( q_bbsCount==0 ? 1 : q_bbsCount); j++) {
            	//將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
				$('#textSize1_' + j).change(function () {
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
		                     
					if ($('#cmbKind').val().substr(0,1)=='A')
					{	
						q_tr('txtDime_'+b_seq ,q_float('textSize1_'+b_seq));//厚度$('#txtDime_'+b_seq).val($('#textSize1_' + b_seq).val());
					}else if( $('#cmbKind').val().substr(0,1)=='B'){
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
					}else if( $('#cmbKind').val().substr(0,1)=='B'){
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
					}else if( $('#cmbKind').val().substr(0,1)=='B'){
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
                //-------------------------------------------------
            	$('#txtPrice_' + j).focusout(function () { sum(); });
                $('#txtMount_' + j).focusout(function () { sum(); });
				
				//20130507如果是廢料則批號=廢料編號
				$('#txtProductno_' + j).change(function() {
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					
					if($('#txtProductno_'+b_seq).val().substr(0,1)=='W' && $('#txtProduct_'+b_seq).val().indexOf('廢料')>-1)
						$('#txtUno_'+b_seq).val($('#txtProductno_'+b_seq).val());
				});
            }
            _bbsAssign();
            size_change();
        }
        
        function q_popPost(s1) {
			switch (s1) {
				case 'txtProductno_':
					if($('#txtProductno_'+b_seq).val().substr(0,1)=='W' && $('#txtProduct_'+b_seq).val().indexOf('廢料')>-1)
						$('#txtUno_'+b_seq).val($('#txtProductno_'+b_seq).val());
				break;
			}
		}

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
            $('#cmbKind').val(q_getPara('vcc.kind'));
            size_change();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtProduct').focus();
            size_change();
        }
        function btnPrint() {
			q_box('z_uccestp.aspx?;;;', '', "95%", "95%", q_getMsg("popPrint"));
        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['uno'] && !as['productno'] && !as['product'] && !as['spec']) {
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
				q_tr('txtTotal_'+j,q_float('txtPrice_'+j)*q_float('txtMount_'+j));
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
			        $('#txtRadius_'+j).val(0);
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
			        $('#txtDime_'+j).val(0);
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
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 98%;
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
                width: 98%;
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
                width: 25%;
                float: left;
            }
            .txt.c3 {
                width: 70%;
                float: left;
            }
            .txt.c4 {
                width: 14%;
                float: left;
            }
            .txt.c5 {
                width: 26%;
                float: left;
            }
            .txt.c6 {
                width: 100%;
                float: left;
            }
            .txt.c7 {
            	float:left;
                width: 22%;
                
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
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size:medium;
            }
            .tbbm textarea {
            	font-size: medium;
            }
            
             input[type="text"],input[type="button"] {     
                font-size: medium;
            }
         .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width: 100%;}
		 .dbbs .tbbs tr{height:35px;}
		 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
    <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:20%"><a id='vewNoa'> </a></td>
                <td align="center" style="width:25%"><a id='vewDatea'> </a></td>
                
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='datea'>~datea</td>
                  
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
            <td class='td1'><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td class='td2'><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblDatea" class="lbl"> </a></td>
            <td class='td4'><input id="txtDatea"  type="text" class="txt c1"/></td>
            <td class='td5'><span> </span><a id="lblKind" class="lbl"> </a></td>
            <td class='td6'><select id="cmbKind" class="txt c1"> </select></td>
        </tr>
        <tr class="tr2">
            <td class='td1'><span> </span><a id="lblStore" class="lbl btn"> </a></td>
            <td class='td2'  colspan='5'>
            	<input id="txtStoreno" type="text" class="txt c4"/>
            	<input id="txtStore" type="text" class="txt c5"/>
            	<span style="float: left;"> </span>
            	<a id="lblSymbol" class="lbl" style="font-weight: bold;font-size: 24px;float: left;"> </a>
            	<span style="float: left;"> </span>
            	<a id="lblStore2" class="lbl btn" style="float: left;"> </a>
            	<span style="float: left;"> </span>
            	<input id="txtStoreno2" type="text" class="txt c4"/>
            	<input id="txtStore2" type="text" class="txt c5"/>
            </td>
        </tr>
        <tr class="tr3">
            <td class='td1'><span> </span><a id="lblWaste" class="lbl"> </a></td>
            <td class='td2'><input id="txtWaste"  type="text" class="txt c1"/></td>
        </tr>                
        </table>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:9%;"><a id='lblStoreno_s'> </a></td>
                <td align="center" style="width:8%;"><a id='lblUno_s'> </a></td>
                <td align="center" style="width:8%;"><a id='lblProductno_st'> </a></td>
                <td align="center" style="width:8%;"><a id='lblProduct_st'> </a></td>
				<td align="center" id='Size'><a id='lblSize_st'> </a><BR><a id='lblSize_help'> </a></td>
                <td align="center" style="width:6%;"><a id='lblMount_s'> </a></td>
                <td align="center" style="width:6%;"><a id='lblPrice_s'> </a></td>
                <td align="center" style="width:7%;"><a id='lblTotal_s'> </a></td>
                <td align="center" style="width:7%;"><a id='lblEweight_s'></a>/<BR><a id='lblAdjweight_s'> </a></td>
                <td align="center" style="width:7%;"><a id='lblEweight2_s'> </a></td>
                <td align="center"><a id='lblMemo_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td>
					<input class="btn"  id="btnStoreno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                    <input type="text" id="txtStoreno.*"  style="width:80%; float:left;"/>
                    <span style="display:block; width:1%;float:left;"> </span>
					<input type="text" id="txtStore.*"  style="width:80%; float:left;"/>
				</td>
                <td ><input class="txt c1" id="txtUno.*" type="text" /></td>
                <td>
					<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                    <input type="text" id="txtProductno.*"  style="width:75%;"/>
                    <input id="txtClass.*" type="text" style="width: 75%;"/>
				</td>
				<td><input type="text" id="txtProduct.*"  class="txt c1"/></td>
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
                <td ><input class="txt num c1" id="txtPrice.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTotal.*" type="text" /></td>
                <td >
                		<input class="txt num c1" id="txtEweight.*" type="text" />
                		<input class="txt num c1" id="txtAdjweight.*" type="text" />
                </td>
                <td ><input class="txt num c1" id="txtEweight2.*" type="text" /></td>
                
                <td ><input class="txt c1" id="txtMemo.*"type="text" /><input id="txtNoq.*" type="hidden" /></td> 
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
 