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
        q_desc=1;
        q_tables = 's';
        var q_name = "carc";
        var q_readonly = ['txtNoa','txtDatea','txtWorker','txtWorker2'];
        var q_readonlys = ['txtCarno','txtCaradate','txtCaritemno','txtCaritem','txtOutmoney','txtInmoney','txtMemo','txtCarano','txtCaranoq'];
        var bbmNum = [];  
        var bbsNum = [['txtOutmoney',14, 0, 1],['txtInmoney',14, 0, 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtCaritemno_', 'btnCaritem_', 'caritem', 'noa,item', 'txtCaritemno_,txtCaritem_', 'caritem_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_desc = 1;
            q_brwCount();   
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
            bbmMask = [['txtDatea', r_picd],['txtBdate', r_picd],['txtEdate', r_picd]];
            q_mask(bbmMask);
            bbsMask = [['txtCaradate', r_picd]];
            q_mask(bbsMask);
            
            $('#btnImport').click(function () {
                	if(emp($('#txtBdate').val())||emp($('#txtEdate').val())){
                		alert('登錄日期請先輸入!!');
                		$('#txtBdate').focus();
                		return;
                	}
		            var t_where = "where=^^ mon between '"+$('#txtBdate').val().substr(0,6)+"' and '"+$('#txtEdate').val().substr(0,6)+"' ^^";
			        q_gt('cara', t_where , 0, 0, 0, "", r_accy);
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
            	case 'cara':
            		var cara = _q_appendData("cara", "", true);
            		if(cara[0]!=undefined){
            			var caras = _q_appendData("caras", "", true);
            			if(caras[0]!=undefined){
            				for (var i = 0; i < caras.length; i++) {//只取時間範圍內的值
            					if(!(caras[i].datea>=$('#txtBdate').val()&&caras[i].datea<=$('#txtEdate').val())||!(caras[i].mon>=$('#txtBdate').val().substr(0,6)&&caras[i].mon<=$('#txtEdate').val().substr(0,6))||caras[i].udate!=''){
		                        	caras.splice(i, 1);
		                        	i--;
                    			}else if($('#chkManage')[0].checked==false&&caras[i].caritemno=='401'){//判斷行費是否被勾選
                    				caras.splice(i, 1);
		                        	i--;
                    			}else if($('#chkInsure')[0].checked==false&&caras[i].caritemno=='306'){//判斷保險費是否被勾選
                    				caras.splice(i, 1);
		                        	i--;
                    			}else if($('#chkFuel')[0].checked==false&&caras[i].caritemno=='502'){//判斷燃料費是否被勾選
                    				caras.splice(i, 1);
		                        	i--;
                    			}else if($('#chkLicense')[0].checked==false&&caras[i].caritemno=='501'){//判斷牌照稅是否被勾選
                    				caras.splice(i, 1);
		                        	i--;
                    			}else if($('#chkOther')[0].checked==false&&caras[i].caritemno!='401'&&caras[i].caritemno!='306'&&caras[i].caritemno!='502'&&caras[i].caritemno!='501'){//判斷其他是否被勾選
                    				caras.splice(i, 1);
		                        	i--;
                    			}else{//判斷是否有實際支付的金額
                    				if(dec(caras[i].pay)>0)
                    					caras[i]._outmoney=caras[i].pay
                    				else
                    					caras[i]._outmoney=caras[i].outmoney
                    			}
                    		}
            				q_gridAddRow(bbsHtm, 'tbbs', 'txtCarano,txtCaranoq,txtCaradate,txtCaritemno,txtCaritem,txtOutmoney,txtInmoney,txtMemo,txtCarno'
            								, caras.length, caras, 'noa,noq,datea,caritemno,caritem,_outmoney,inmoney,memo,carno', 'txtCarano');
            			}
            		}
            		break; 
                case q_name: 
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
			
			if(q_cur==1)
            	$('#txtWorker').val(r_name);
            else
            	$('#txtWorker2').val(r_name);
            	
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('C' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
        }

        function bbsAssign() {  
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtBdate').val(q_date().substr(0,7)+'01');
            $('#txtEdate').val(q_date());
            $('#chkManage')[0].checked=true;
            $('#chkInsure')[0].checked=true;
            $('#chkFuel')[0].checked=true;
            $('#chkLicense')[0].checked=true;
            $('#chkOther')[0].checked=true;
            $('#txtBdate').focus();

        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtBdate').focus();
            
           
        }
        function btnPrint() {
			q_box('z_carc.aspx' + "?;;;;" + r_accy, '', "800px", "600px", q_getMsg("popPrint"));
        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['carano'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();

            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0,money_total=0;
            for (var j = 0; j < q_bbsCount; j++) {
            }  // j
        }
        
       

        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
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
                width: 23%;
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
                width: 75%;
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
                width: 75%;
                float: left;
            }
            .txt.c4 {
                width: 44%;
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
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs a {
                font-size: medium;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            .tbbs
        	{
	            FONT-SIZE: medium;
	            COLOR: blue ;
	            TEXT-ALIGN: left;
	             BORDER:1PX LIGHTGREY SOLID;
	             width:100% ; height:98% ;  
        	} 
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
    <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:25%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center"><a id='vewNoa'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='noa'>~noa</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 74%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='td1'><span> </span><a id="lblNoa" class="lbl"></a></td>
            <td class='td2'><input id="txtNoa"  type="text" class="txt c1" /></td>
            <td class='td3'><span> </span><a id="lblDatea" class="lbl"></a></td>
            <td class='td4'><input id="txtDatea" type="text" class="txt c4"/></td>
            <td class='td5'></td>
       </tr>
       <tr>           
			<td class='td1'><span> </span><a id="lblDate2" class="lbl"></a></td>
            <td class='td2'>
            	<input id="txtBdate" type="text" class="txt c4"/>
            	<span style="float:left;display: block;width:10%;height:inherit;color:blue;font-size: 14px;text-align: center;">~</span>
            	<input id="txtEdate"  type="text"  class="txt c4"/>
            </td>
            <td class='td3'><span> </span><a id="lblChkimport" class="lbl"></a></td>
            <td class='td4' colspan='2'>
            	<input id="chkManage" type="checkbox" style="float: left;"/><a id="lblManage" class="lbl" style="float: left;"></a>
            	<input id="chkInsure" type="checkbox" style="float: left;"/><a id="lblInsure" class="lbl" style="float: left;"></a>
            	<input id="chkFuel" type="checkbox" style="float: left;"/><a id="lblFuel" class="lbl" style="float: left;"></a>
            	<input id="chkLicense" type="checkbox" style="float: left;"/><a id="lblLicense" class="lbl" style="float: left;"></a>
            	<input id="chkOther" type="checkbox" style="float: left;"/><a id="lblOther" class="lbl" style="float: left;"></a>
            	<input id="btnImport" type="button" style="float: left;"/></td>
            </td><!--行費、保險費、燃料費、牌照稅、其他-->
       </tr>        
        <tr>           
			<td class='td1'><span> </span><a id="lblWorker" class="lbl"></a></td>
            <td class='td2'><input id="txtWorker"  type="text" class="txt c4" /></td>
            <td class='td3'><span> </span><a id="lblWorker2" class="lbl"></a></td>
            <td class='td4'><input id="txtWorker2" type="text" class="txt c4"></td>
       </tr>        
        <tr>
            <td class='td1'><span> </span><a id="lblMemo" class="lbl"></a></td>
            <td class='td2' colspan='4'><input id="txtMemo"  type="text"  class="txt c1"/></td>
        </tr> 
        </table>
        </div>
		</div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                <td align="center" style="width:8%"><a id='lblCarnos'></a></td>
                <td align="center" style="width:8%"><a id='lblCaradates'></a></td>
                <td align="center" style="width:10%"><a id='lblCaritems'></a></td>
                <td align="center" style="width:10%"><a id='lblOutmoneys'></a></td>
                <td align="center" style="width:10%"><a id='lblInmoneys'></a></td>
                <td align="center" ><a id='lblMemos'></a></td>
                <td align="center" style="width:12%"><a id='lblCaranos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input id="txtCarno.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtCaradate.*" type="text" class="txt c1"/></td>
                <td >
                	<input id="txtCaritemno.*" type="text" class="txt c3"/>
					<input class="btn"  id="btnCaritem.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					<input id="txtCaritem.*" type="text" class="txt c1"/>
                </td>
                <td ><input id="txtOutmoney.*" type="text" class="txt num c1"/></td>
                <td ><input id="txtInmoney.*" type="text" class="txt num c1"/></td>
                <td >
                	<input  id="txtMemo.*" type="text" class="txt c1"/>
                	<input id="txtNoq.*" type="hidden" />
                </td>
                <td >
                		<input  id="txtCarano.*" type="text" class="txt c1"/>
                		<input  id="txtCaranoq.*" type="text" class="txt c1"/>
                </td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
