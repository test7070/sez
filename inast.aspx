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
            var q_name = "ina";
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [['txtTotal', 10, 1]];
            var bbsNum = [['txtSize1', 10, 3],['txtSize2', 10, 2],['txtSize3', 10, 3],['txtSize4', 10, 2],['txtRadius', 10, 3],['txtWidth', 10, 2],['txtDime', 10, 3],['txtLengthb', 10, 2],['txtMount', 10, 2],['txtWeight', 10, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
            ['txtStoreno','lblStore','store','noa,store','txtStoreno,txtStore','store_b.aspx'],
            ['txtTggno','lblTgg','tgg','noa,comp','txtTggno,txtComp','tgg_b.aspx'],
            ['txtCardeal', 'lblCardeal', 'cardeal', 'noa,comp', 'txtCardealno,txtCardeal', 'cardeal_b.aspx'],
            ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
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
                q_cmbParse("cmbItype", q_getPara('ina.typea'));
                q_cmbParse("cmbTypea", q_getPara('uccc.itype'));
                q_cmbParse("cmbKind", q_getPara('get.kind'));
                q_cmbParse("cmbTrantype", q_getPara('rc2.tran'));
                
                //變動尺寸欄位
            $('#cmbKind').change(function () {
            	size_change();
		     });
            }
		function size_change () {
		  if( $('#cmbKind').val()=='1' || $('#cmbKind').val()=='4')
            	{
            		$('#lblSize_help').text("厚度x寬度x長度");
	            	for (var j = 0; j < q_bbsCount; j++) {
			           $('#txtSize4_'+j).attr('hidden', 'true');
			           $('#x3_'+j).attr('hidden', 'true');
			           $('#txtSize1_'+j).val($('#txtDime_'+j).val());
			         	$('#txtSize2_'+j).val($('#txtWidth_'+j).val());
			         	$('#txtSize3_'+j).val($('#txtLengthb_'+j).val());
			         	$('#txtSize4_'+j).val(0);
			         	$('#txtRadius_'+j).val(0)
			         }
			     }
		         else
		         {
		         	$('#lblSize_help').text("短徑x長徑x厚度x長度");
			         for (var j = 0; j < q_bbsCount; j++) {
			         	$('#txtSize4_'+j).removeAttr('hidden');
			         	$('#x3_'+j).removeAttr('hidden');
			         	$('#txtSize1_'+j).val($('#txtRadius_'+j).val());
			         	$('#txtSize2_'+j).val($('#txtWidth_'+j).val());
			         	$('#txtSize3_'+j).val($('#txtDime_'+j).val());
			         	$('#txtSize4_'+j).val($('#txtLengthb_'+j).val());
			         }
			     }
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
            			theory_st(q_name,b_seq,'txtWeight');
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
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('G' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('ina_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                _bbsAssign();
                for(var j = 0; j < q_bbsCount; j++) {
					//將虛擬欄位數值帶入實際欄位並計算公式----------------------------------------------------------
                 $('#txtSize1_' + j).change(function () {
                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                     q_bodyId($(this).attr('id'));
                     b_seq = t_IdSeq;
                     
                    if ($('#cmbKind').val()=='1' || $('#cmbKind').val()=='4')
            		{	
            			$('#txtDime_'+b_seq).val($('#txtSize1_' + b_seq).val());	//厚度
            		}else{
            			$('#txtRadius_'+b_seq).val($('#txtSize1_' + b_seq).val());	//短徑
            		}
            		
                     var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
					q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
                 });
                 $('#txtSize2_' + j).change(function () {
                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                     q_bodyId($(this).attr('id'));
                     b_seq = t_IdSeq;
                     
                    if ($('#cmbKind').val()=='1' || $('#cmbKind').val()=='4')
            		{	
            			$('#txtWidth_'+b_seq).val($('#txtSize2_' + b_seq).val());	//寬度
            		}else{
            			$('#txtWidth_'+b_seq).val($('#txtSize2_' + b_seq).val());	//長徑
            		}
                     
                     var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
					q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
                 });
                 $('#txtSize3_' + j).change(function () {
                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                     q_bodyId($(this).attr('id'));
                     b_seq = t_IdSeq;
			         	
                     if ($('#cmbKind').val()=='1' || $('#cmbKind').val()=='4')
            		{	
            			$('#txtLengthb_'+b_seq).val($('#txtSize3_' + b_seq).val());	//長度
            		}else{
            			$('#txtDime_'+b_seq).val($('#txtSize3_' + b_seq).val());		//厚度
            		}
                     
                     var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+b_seq).val()+"' ^^"; 
					q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
                 });
                 $('#txtSize4_' + j).change(function () {
                     t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                     q_bodyId($(this).attr('id'));
                     b_seq = t_IdSeq;
                     
                     if ($('#cmbKind').val()=='1' || $('#cmbKind').val()=='4')
            		{	
            			$('#txtRadius_'+b_seq).val($('#txtSize4_' + b_seq).val());	//短徑為0
            		}else{
            			$('#txtLengthb_'+b_seq).val($('#txtSize4_' + b_seq).val());	//長度
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

            function btnIns() {
                _btnIns();
                $('#cmbKind').val(1);
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
                if(!as['mount']) {
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
            function theory_st(q_name,id,txtweight) { //id 為BBS的id,txtweight為要bbs寫入的欄位
			var calc="";
			//var t_where = "where=^^ a.noa = '"+ $('#txtProductno_'+id).val()+"' ^^"; 
			//q_gt('ucc_style', t_where , 0, 0, 0, "", r_accy);
			var as = _q_appendData("ucc", "", true);
			//判斷表身參考theory:40
			if(q_name=='uccb'||q_name=='uccc'||q_name=='cubu'||q_name=='ins'||q_name=='rc2s'||
				q_name=='ina'||q_name=='cut'||q_name=='cnn'||q_name=='cng'||q_name=='vccd'||
				q_name=='rc2'||q_name=='ordc'||q_name=='ordb'||q_name=='get') 
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
			$('#'+txtweight+'_'+id).val(result*dec($('#txtMount_'+id).val()));
			
			var weight_total=0;
			for (var j = 0; j < q_bbsCount; j++) {
				weight_total+=dec($('#'+txtweight+'_'+j).val());
            }
			$('#txtTotal').val(weight_total);
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
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
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
                width: 50%;
                float: left;
            }
            .txt.c7 {
            	float:left;
                width: 22%;
                
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
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:20%"><a id='vewDatea'> </a></td>
                <td align="center" style="width:25%"><a id='vewStation'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='station'>~station</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
        	<td class='td1'><span> </span><a id="lblItype" class="lbl"> </a></td>
            <td class="td2"><select id="cmbItype" class="txt c1"> </select></td>
        	<td class='td1'><span> </span><a id="lblType" class="lbl"> </a></td>
            <td class="td2"><select id="cmbTypea" class="txt c1"> </select></td>
        	<td class='td3'><span> </span><a id="lblDatea" class="lbl"> </a></td>
            <td class="td4"><input id="txtDatea" type="text" class="txt c3"/></td>
        </tr>
        <tr class="tr2">
            <td class='td1'><span> </span><a id="lblKind" class="lbl"> </a></td>
            <td class="td2"><select id="cmbKind" class="txt c1"> </select></td>
            <td class='td3'><span> </span><a id="lblNoa" class="lbl" > </a></td>
            <td class="td4"><input id="txtNoa" type="text" class="txt c1"/></td>
        	<td class='td5'><span> </span><a id="lblOrdeno" class="lbl" > </a></td>
        	<td class="td6"><input id="txtOrdeno" type="text" class="txt c1"/></td>
        </tr>
        <tr class="tr3">
        <td class='td1'><span> </span><a id="lblStation" class="lbl btn" > </a></td>
        <td class="td2" colspan="3"><input id="txtStationno" type="text"  class="txt c2"/>
            <input id="txtStation" type="text"  class="txt c3"/></td>
        </tr>
        <tr class="tr4">
        <td class='td1'><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
        <td class="td2" colspan="3"><input id="txtTggno" type="text"  class="txt c2"/>
            <input id="txtComp" type="text"  class="txt c3"/></td>
        </tr>
        <tr class="tr5">        
            <td class="td1"><span> </span><a id="lblStore" class="lbl btn" > </a></td>
            <td class="td2" colspan="3"><input id="txtStoreno"  type="text"  class="txt c2"/>
                <input id="txtStore"  type="text" class="txt c3"/></td> 
        </tr>
         <tr class="tr6">
        	<td class="td1"><span> </span><a id="lblCardeal" class="lbl btn"> </a></td>
        	<td class="td2" colspan="3"><input id="txtCardealno" type="text" class="txt c2"/><input id="txtCardeal" type="text" class="txt c3"/></td>
        	<td class="td3"><span> </span><a id="lblCarno" class="lbl"> </a></td>
        	<td class="td4"><input id="txtCarno" type="text" class="txt c1" /></td>
        </tr>
        <tr class="tr7">
        	<td class="td1"><span> </span><a id="lblTrantype" class="lbl"> </a></td>
        	<td class="td2"><select id="cmbTrantype" class="txt c1"> </select></td>
        	<td class="td3"><span> </span><a id="lblPrice" class="lbl"> </a></td>
        	<td class="td4"><input id="txtPrice" type="text" class="txt c1" /></td>
        	<td class="td5"><span> </span><a id="lblTranmoney" class="lbl"> </a></td>
        	<td class="td6"><input id="txtTranmoney" type="text" class="txt c1" /></td>
        </tr>
        <tr class="tr8"> 
        	<td class="td1"><span> </span><a id="lblTotal" class="lbl"> </a></td>
        	<td class="td2"><input id="txtTotal" type="text" class="txt c1" /></td>
        	<td class='td3'><span> </span><a id="lblWorker" class="lbl"> </a></td>
            <td class="td4"><input id="txtWorker" type="text" class="txt c1"/></td>
        </tr>
        <tr class="tr9">
        <td class='td1'><span> </span><a id="lblMemo" class="lbl"> </a></td>
        <td class="td2" colspan='5'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
        </tr>
        </table>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <!--<td align="center" style="width:4%;"><a id="lblUno_s" > </a></td>
                <td align="center" style="width:4%;"><a id="lblStore_s" > </a></td>-->
                <td align="center" style="width:8%;"><a id='lblProductno_st'> </a></td>
                <td align="center" style="width:12%;"><a id='lblProduct_st'> </a></td>
                <td align="center" style="width:12%;"><a id='lblSpec_st'> </a></td>
                <!--<td align="center" style="width:4%;"><a id='lblUnit_s'> </a></td>
                <td align="center" style="width:2%;"><a id='lblStyle_s'> </a></td>
                <td align="center" style="width:4%;"><a id='lblClass_s'> </a></td>-->
                <td align="center"><a id='lblSize_st'> </a><BR><a id='lblSize_help'> </a></td>
                <td align="center" style="width:6%;"><a id='lblMount_st'> </a></td>
                <td align="center" style="width:6%;"><a id='lblWeight_st'> </a></td>
                <!--<td align="center" style="width:6%;"><a id='lblGweight_s'> </a></td>
                <td align="center" style="width:6%;"><a id='lblEweight_s'> </a></td>
                <td align="center" style="width:6%;"><a id='lblPrice_s'> </a></td>
                <td align="center" style="width:5%;"><a id='lblPlace_s'> </a></td>
                <td align="center" style="width:4%;"><a id='lblSource_s'> </a></td>-->
                <td align="center" style="width:22%;"><a id='lblMemo_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td ><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <!--<td ><input  id="txtUno.*" type="text" class="txt c1"/></td>
                <td ><input class="txt c1" id="txtStore.*" type="text" /> </td>-->
                <td ><input  id="txtProductno.*" type="text" style="width:70%;" /><input class="btn"  id="btnProductno.*" type="button" value='...' style="width:16%;"  /></td>
                <td ><input class="txt c1" id="txtProduct.*" type="text" /></td>
                <td><input class="txt c1" id="txtSpec.*" type="text"/></td>
                <!--<td ><input class="txt c1" id="txtUnit.*" type="text"/></td>
                <td ><input id="txtStyle.*" type="text" class="txt c1" /></td>
                <td ><input id="txtClass.*" type="text" class="txt c1" /></td>-->
                <td><input class="txt num c7" id="txtSize1.*" type="text"/><div id="x1" style="float: left"> x</div>
                		<input class="txt num c7" id="txtSize2.*" type="text"/><div id="x2" style="float: left"> x</div>
                        <input class="txt num c7" id="txtSize3.*" type="text"/><div id="x3.*" style="float: left"> x</div>
                         <input class="txt num c7" id="txtSize4.*" type="text"/>
                         <!--上為虛擬下為實際-->
                         <input id="txtRadius.*" type="hidden"/>
                		<input  id="txtWidth.*" type="hidden"/>
                        <input  id="txtDime.*" type="hidden"/>
                         <input id="txtLengthb.*" type="hidden"/>
                </td>
                <td ><input class="txt num c1" id="txtMount.*" type="text"  /></td>
                <td ><input class="txt num c1" id="txtWeight.*" type="text"  /></td>
                <!--<td ><input class="txt num c1" id="txtGweight.*" type="text"/></td>
                <td ><input class="txt num c1" id="txtMweight.*" type="text" /></td>
                <td ><input class="txt c1" id="txtPrice.*" type="text" /></td>
                <td ><input class="txt c1" id="txtPlace.*" type="text" /></td>
                <td ><input class="txt c1" id="txtSource.*" type="text" /></td>-->
                <td ><input class="txt c1" id="txtMemo.*" type="text" />
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
