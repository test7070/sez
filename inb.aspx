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
            var q_name = "inb";
            var q_readonly = ['txtNoa'];
            var q_readonlys = ['txtNoa','txtNoq'];
            var bbmNum = [['txtGweight', 10, 2, 1],['txtTwelght', 10, 2, 1],['txtWelght', 10, 2, 1]];
            var bbsNum = [['txtDime', 10, 2, 1],['txtWidth', 10, 2, 1],['txtLengthb', 10, 2, 1],['txtBweight', 10, 2, 1],['txtMount', 10, 2, 1],
            ['txtWeight', 10, 2, 1],['txtPdm',10,2,1],['txtGweight',10,2,1],['txtMount2',10,2,1],['txtTheory',10,2,1],
            ['txtCuac',10,2,1],['txtCuaw',10,2,1],['txtUweight', 10, 2, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(
            	['txtProductno_', 'btnProductno_', 'ucc', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucc_b.aspx']
			);

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
            var t_spec;//儲存spec陣列
            function mainPost() {
				q_getFormat();
				bbmMask = [['txtDatea', r_picd]];
				bbsMask = [['txtDatea', r_picd],['txtBtime', '99:99'],['txtEtime', '99:99'],['txtTime', '99:99'],['txtRtime', '99:99']];
				q_mask(bbmMask);
				q_mask(bbsMask);
				q_gt('spec', '', 0, 0, 0, "", r_accy);
				$('#btnInbmimport').click(function (e) {
					q_box("inbm_b.aspx?;;;noa='" + $('#txtNoa').val() + "';" + r_accy, 'inbm', "95%", "95%", q_getMsg("popInbm"));
				});
				$('#btnInbwimport').click(function (e) {
					q_box("inbw_b.aspx?;;;noa='" + $('#txtNoa').val() + "';" + r_accy, 'inbw', "95%", "95%", q_getMsg("popInbw"));
				});
                $('#btnOrdeimport').click(function() {
                	t_where = 'enda is null or enda=0';
                    q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrde'));
                });
                $('#txtDatea').blur(function() {
                	maxnoq='0000';
                	
                	var t_where = "where=^^ noa in (select noa from inbs"+r_accy+" where noq like '"+replaceAll($('#txtDatea').val().substr(4,5),'/','')+"%' ) ^^";
                	q_gt(q_name,t_where , 0, 0, 0, "", r_accy);
                });
            }
		
            function q_boxClose(s2) {///   q_boxClose 2/4
				var	ret;
				b_ret = getb_ret();
                switch (b_pop) {
					case 'ordes':
	                    if (q_cur > 0 && q_cur < 4) {
	                        if (!b_ret || b_ret.length == 0)
	                            return;
                        	ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtDime,txtWidth,txtLengthb,txtSpec,txtOrdeno,txtNo2,txtBweight,txtMount,txtTheory', b_ret.length, b_ret, 'productno,product,unit,dime,width,lengthb,spec,noa,no2,weight,mount,theory','txtProductno');   /// 最後 aEmpField 不可以有【數字欄位】
							sum()
	                    }
						break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'spec': 
	            		t_spec= _q_appendData("spec", "", true);
	            		break;
					case 'cua_cuas':
						var as = _q_appendData("cua_cuas", "", true);
						if(as[0]!=undefined){
							q_gridAddRow(bbsHtm, 'tbbs', 'txtUno,txtProductno,txtProduct,txtUnit,txtMount,txtCuano,txtOrdeno,txtNo2', 1, as, 'noa,productno,product,unit,mount,noa,ordeno,no2', 'txtProductno');
		                }
	                	break;
                    case q_name:
                    	if(q_cur==1 || q_cur==2){
                    		var as = _q_appendData(q_name+'s', "", true);
                    		if(as[0]!=undefined){
                    			for (var i = 0; i < as.length; i++) {
                    				if(as[i].noq.substr(0,4)==replaceAll($('#txtDatea').val().substr(4,5),'/','')&&as[i].noq.substr(5,4)>maxnoq)
                    					maxnoq=as[i].noq.substr(5,4);
                    			}
                    		}
                    	}
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function btnOk() {
            	//自訂noq(八位)
            	if(q_cur==1 || q_cur==2){
            		for(var i = 0; i < q_bbsCount; i++) {
            			if(!emp($('#txtProductno_'+i).val())&&emp($('#txtNoq_'+i).val())){
            				var t_noq=('0000'+(dec(maxnoq)+1)).substr(('0000'+(dec(maxnoq)+1)).length-4);
            				$('#txtNoq_'+i).val(replaceAll($('#txtDatea').val().substr(4,5),'/','')+t_noq);
            				maxnoq=t_noq;
            			}
            		}
            	}
            	t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('IB' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;
            }
            
			function bbsAssign() {
				for(var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
	                	$('#txtDime_'+j).change(function() {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				            q_bodyId($(this).attr('id'));
				            b_seq = t_IdSeq;
							
							q_tr('txtTheory_'+b_seq,theory_bi(t_spec,$('#txtSpec_'+b_seq).val(),dec($('#txtDime_'+b_seq).val()),dec($('#txtWidth_'+b_seq).val()),dec($('#txtLengthb_'+b_seq).val())));
						});
						$('#txtWidth_'+j).change(function() {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				            q_bodyId($(this).attr('id'));
				            b_seq = t_IdSeq;
							
							q_tr('txtTheory_'+b_seq,theory_bi(t_spec,$('#txtSpec_'+b_seq).val(),dec($('#txtDime_'+b_seq).val()),dec($('#txtWidth_'+b_seq).val()),dec($('#txtLengthb_'+b_seq).val())));
						});
						$('#txtLengthb_'+j).change(function() {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				            q_bodyId($(this).attr('id'));
				            b_seq = t_IdSeq;
							
							q_tr('txtTheory_'+b_seq,theory_bi(t_spec,$('#txtSpec_'+b_seq).val(),dec($('#txtDime_'+b_seq).val()),dec($('#txtWidth_'+b_seq).val()),dec($('#txtLengthb_'+b_seq).val())));
						});
						$('#txtSpec_'+j).change(function() {
							t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
				            q_bodyId($(this).attr('id'));
				            b_seq = t_IdSeq;
							
							q_tr('txtTheory_'+b_seq,theory_bi(t_spec,$('#txtSpec_'+b_seq).val(),dec($('#txtDime_'+b_seq).val()),dec($('#txtWidth_'+b_seq).val()),dec($('#txtLengthb_'+b_seq).val())));
						});
            		  }
                }
                _bbsAssign();
            }
			
			
			var maxnoq='0000';
            function btnIns() {
                _btnIns();
                
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                
                maxnoq='0000';
                var t_where = "where=^^ noa in (select noa from inbs"+r_accy+" where noq like '"+replaceAll($('#txtDatea').val().substr(4,5),'/','')+"%' ) ^^";
                q_gt(q_name,t_where , 0, 0, 0, "", r_accy);
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                
                maxnoq='0000';
                var t_where = "where=^^ noa in (select noa from inbs"+r_accy+" where noq like '"+replaceAll($('#txtDatea').val().substr(4,5),'/','')+"%' ) ^^";
                q_gt(q_name,t_where , 0, 0, 0, "", r_accy);
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
                as['datea'] = abbm2['datea'];
                return true;
            }


            function refresh(recno) {
                _refresh(recno);
                
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                	if($('#txtNoa').val()==''){
                		$('#btnInbmimport').attr('disabled', 'disabled');
						$('#btnInbwimport').attr('disabled', 'disabled');
                	}else{
						$('#btnInbmimport').removeAttr('disabled');
						$('#btnInbwimport').removeAttr('disabled');
					}
                } else {
                	$('#btnInbmimport').attr('disabled', 'disabled');
					$('#btnInbwimport').attr('disabled', 'disabled');
                }
            }
            
            function sum() {
            	var t_gwelght=0,t_twelght = 0, t_welght = 0;
                for (var j = 0; j < q_bbsCount; j++) {
					t_twelght+=dec($('#txtGweight_'+j).val());
					t_twelght+=dec($('#txtTheory_'+j).val());
					t_welght+=dec($('#txtWeight_'+j).val())
                } // j
                q_tr('txtGweight',t_gwelght);
                q_tr('txtTwelght',t_twelght);
                q_tr('txtWelght',t_welght);
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
         .dbbs .tbbs{
         	margin:0;
         	padding:2px;
         	border:2px lightgrey double;
         	border-spacing:1px;
         	border-collapse:collapse;
         	font-size:medium;
         	color:blue;
         	background:#cad3ff;
         	width: 1800px;
         }
		 .dbbs .tbbs tr{
		 	height:35px;
		 }
		 .dbbs .tbbs tr td{
		 	text-align:center;
		 	border:2px lightgrey double;
		 }
    </style>
</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
<!--#include file="../inc/toolbar.inc"-->
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
        	<td class='td1'><span> </span><a id="lblDatea" class="lbl"> </a></td>
            <td class="td2"><input id="txtDatea" type="text" class="txt c1"/></td>
        	<td class='td3'><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td class="td4"><input id="txtNoa" type="text" class="txt c1"/></td>
        </tr>
        <tr class="tr2">
            <td class='td1'><span> </span><a id="lblSpec" class="lbl" > </a></td>
            <td colspan="3" class="td2"><input id="txtSpec" type="text" class="txt c1"/></td>
        </tr>
        <tr class="tr3">
	        <td class='td1'><span> </span><a id="lblGweight" class="lbl" > </a></td>
	        <td class="td2"><input id="txtGweight" type="text"  class="txt c1 num"/>
	        <td class='td3'><span> </span><a id="lblTweight" class="lbl" > </a></td>
	        <td class="td4"><input id="txtTwelght" type="text"  class="txt c1 num"/>
	        <td class='td5'><span> </span><a id="lblWeight" class="lbl" > </a></td>
	        <td class="td6"><input id="txtWelght" type="text"  class="txt c1 num"/></td>
        </tr>
        <tr class="tr3">
	        <td class='td1' colspan="4" style="text-align:center;">
				<input id="btnOrdeimport" type="button" />
				<input id="btnInbmimport" type="button" />
				<input id="btnInbwimport" type="button" />
	        </td>
        </tr>
        <tr class="tr4">
        <td class='td1'><span> </span><a id="lblMemo" class="lbl"> </a></td>
        <td class="td2" colspan='5'><textarea id="txtMemo" cols="10" rows="5" style="width: 99%;height: 50px;"> </textarea></td>
        </tr>
        </table>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center" style="width:5%;"><a id="lblDatea_s" > </a></td>
                <td align="center" style="width:7%;"><a id='lblUno_s'> </a></td>
                <td align="center" style="width:12%;"><a id='lblProduct_s'> </a></td>
                <!--<td align="center" style="width:3%;"><a id='lblSpec_s'> </a></td>-->
                <td align="center" style="width:222px;"><a id='lblSize'> </a></br><a id='lblSizes'></a></td>
                <td align="center" style="width:5%;"><a id='lblBweight_s'> </a></td>
                <td align="center" style="width:5%;"><a id='lblMount_s'> </a></td>
                <td align="center" style="width:5%;"><a id='lblWeight_s'> </a></td>
                <!--<td align="center" style="width:3%;"><a id='lblSno_s'> </a></td>-->
                <td align="center"><a id='lblMemo_s'> </a></td>
                <td align="center" style="width:5%;"><a id='lblPdm_s'> </a></td>
                <!--<td align="center" style="width:3%;"><a id='lblGweight_s'> </a></td>-->
                <!--<td align="center" style="width:3%;"><a id='lblMount2_s'> </a></td>-->
                <td align="center" style="width:5%;"><a id='lblBno_s'> </a></td>
                <td align="center" style="width:5%;"><a id='lblTheory_s'> </a></td>
                <!--<td align="center" style="width:3%;"><a id='lblBtime_s'> </a></td>-->
                <!--<td align="center" style="width:3%;"><a id='lblEtime_s'> </a></td>-->
                <!--<td align="center" style="width:3%;"><a id='lblTime_s'> </a></td>-->
                <!--<td align="center" style="width:3%;"><a id='lblClass_s'> </a></td>-->
                <!--<td align="center" style="width:3%;"><a id='lblCuano_s'> </a></td>-->
                <td align="center" style="width:10%;"><a id='lblOrdeno_s'> </a></td>
                <!--<td align="center" style="width:3%;"><a id='lblRtime_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblReason_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblGproduct_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblCuac_s'> </a></td>
                <td align="center" style="width:3%;"><a id='lblCuaw_s'> </a></td>-->
                <td align="center" style="width:7%;"><a id='lblStore_s'> </a></td>
                <!--<td align="center" style="width:3%;"><a id='lblUweight_s'> </a></td>-->
                <td align="center" style="width:3%;"><a id='lblEnda_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td ><input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
                <td ><input  id="txtDatea.*" type="text" class="txt c1"/>
                	<input id="recno.*" type="hidden" />
                </td>
                <td ><input id="txtNoq.*" type="text" class="txt c1"/></td>
                <td >
                	<input class="btn"  id="btnProductno.*" type="button" value='.' style="width:1%;"  />
                	<input  id="txtProductno.*" type="text" style="width:80%;" />
                	<input  id="txtProduct.*" type="text" style="width:80%;" />
                	<input  id="txtUnit.*" type="hidden"/>
                </td>
                <!--<td ><input  id="txtSpec.*" type="text" class="txt c1"/></td>-->
                <td >
                	<input id="txtDime.*" type="text" class="txt c1 num c8"/><div id="x1.*" style="float: left"> x</div>
                	<input id="txtWidth.*" type="text" class="txt c1 num c8"/><div id="x2.*" style="float: left"> x</div>
                	<input id="txtLengthb.*" type="text" class="txt c1 num c8"/>
                	<input  id="txtSpec.*" type="text" class="txt c1"/>
                </td>
                <td ><input  id="txtBweight.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtMount.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtWeight.*" type="text" class="txt c1 num"/></td>
                <!--<td ><input  id="txtSno.*" type="text" class="txt c1"/></td>-->
                <td ><input  id="txtMemo.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtPdm.*" type="text" class="txt c1 num"/></td>
                <!--<td ><input  id="txtGweight.*" type="text" class="txt c1 num"/></td>-->
                <!--<td ><input  id="txtMount2.*" type="text" class="txt c1 num"/></td>-->
                <td ><input  id="txtBno.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtTheory.*" type="text" class="txt c1 num"/></td>
                <!--<td ><input  id="txtBtime.*" type="text" class="txt c1"/></td>-->
                <!--<td ><input  id="txtEtime.*" type="text" class="txt c1"/></td>-->
                <!--<td ><input  id="txtTime.*" type="text" class="txt c1"/></td>-->
                <!--<td ><input  id="txtClass.*" type="text" class="txt c1"/></td>-->
                <!--<td ><input  id="txtCuano.*" type="text" class="txt c1"/></td>-->
                <td ><input  id="txtOrdeno.*" type="text" class="txt" style="width: 70%;"/>
                	<input  id="txtNo2.*" type="text" class="txt" style="width: 20%;"/>
                </td>
                <!--<td ><input  id="txtRtime.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtReason.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtGproduct.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtCuac.*" type="text" class="txt c1 num"/></td>
                <td ><input  id="txtCuaw.*" type="text" class="txt c1 num"/></td>-->
                <td ><input  id="txtStore.*" type="text" class="txt c1"/></td>
                <!--<td ><input  id="txtUweight.*" type="text" class="txt c1 num"/></td>-->
                <td ><input id="chkEnda.*" type="checkbox"/></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
