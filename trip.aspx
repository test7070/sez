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
        var q_name = "trip";
        var q_readonly = ['txtNoa'];
        var q_readonlys = [];
        var bbmNum = [];  
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtSssno', 'lblSss', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx'],
        							['txtCno_', 'btnAcomp_', 'cust', 'noa,comp', 'txtCno_,txtAcomp_', 'cust_b.aspx']);

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
        
        var insed=false;//判斷是否重覆輸入出差日期
        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd]];
            q_mask(bbmMask);
            bbsMask = [['txtBtime', '99:99'],['txtEtime', '99:99']];
            q_mask(bbsMask);
            
            $('#txtSssno').change(function () {
			        if(!emp($('#txtSssno').val()) && !emp($('#txtDatea').val())){
	            		//判斷員工是否重覆輸入出差日期
			           		var t_where = "where=^^ datea ='"+$('#txtDatea').val()+"' and sssno='"+$('#txtSssno').val()+"' ^^";
			           		q_gt('trip', t_where , 0, 0, 0, "", r_accy);
			        }
	        	});
	        	$('#txtDatea').change(function () {
	            	if(!emp($('#txtSssno').val()) && !emp($('#txtDatea').val())){
	            		//判斷員工是否重覆輸入出差日期
			           		var t_where = "where=^^ datea ='"+$('#txtDatea').val()+"' and sssno='"+$('#txtSssno').val()+"' ^^";
			           		q_gt('trip', t_where , 0, 0, 0, "", r_accy);
			        }
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

		function q_popPost(s1) {
		    	switch (s1) {
		    		case 'txtSssno':
			        	if(!emp($('#txtSssno').val()) && !emp($('#txtDatea').val())){
		            		//判斷員工是否重覆輸入出差日期
				           		var t_where = "where=^^ datea ='"+$('#txtDatea').val()+"' and sssno='"+$('#txtSssno').val()+"' ^^";
				           		q_gt('trip', t_where , 0, 0, 0, "", r_accy);
			        	}
		                break;
		    	}
			}

        function q_gtPost(t_name) {  
            switch (t_name) {
                case q_name: 
                	if(q_cur == 1){
                    		var as = _q_appendData("trip", "", true);	
                    		if(as[0]!=undefined){
                    			insed=true;
                    		}else{
                    			insed=false;
                    		}
                    }
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
            
            if(insed) {
            	alert('今天該員工出差日期已重覆輸入過!!!');
                return;
            }
            
            for(var i = 0; i < q_bbsCount; i++) {
	            for(var j = 0; j < q_bbsCount; j++) {
		            if(!emp($('#txtBtime_'+i).val())&&!emp($('#txtEtime_'+i).val())&&i!=j&&!emp($('#txtBtime_'+j).val())&&!emp($('#txtEtime_'+j).val())&&($('#txtBtime_'+i).val()<$('#txtBtime_'+j).val()&&$('#txtEtime_'+i).val()>$('#txtBtime_'+j).val()||$('#txtEtime_'+i).val()>$('#txtEtime_'+j).val()&&$('#txtBtime_'+i).val()<$('#txtEtime_'+j).val())){
		       			alert('時間段與其他行程時間重疊,請檢查!!!');
		       			$('#txtBtime_'+i).focus();
		       			return;
		       		}
		       	}
	       	}
            
            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('T' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
                q_box('trip_s.aspx', q_name + '_s', "530px", "400px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   
        }

        function bbsAssign() {  
        	for(var i = 0; i < q_bbsCount; i++) {
	        	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
	       			$('#txtBtime_'+i).change(function () {
	       				t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						
						if(!emp($('#txtBtime_'+b_seq).val())&&!emp($('#txtEtime_'+b_seq).val())&&$('#txtBtime_'+b_seq).val()>$('#txtEtime_'+b_seq).val()){
							var t_time=$('#txtBtime_'+b_seq).val();
							$('#txtBtime_'+b_seq).val($('#txtEtime_'+b_seq).val());
							$('#txtEtime_'+b_seq).val(t_time);
						}
	       				for(var j = 0; j < q_bbsCount; j++) {
	       					if(!emp($('#txtBtime_'+b_seq).val())&&!emp($('#txtEtime_'+b_seq).val())&&b_seq!=j&&!emp($('#txtBtime_'+j).val())&&!emp($('#txtEtime_'+j).val())&&($('#txtBtime_'+b_seq).val()<$('#txtBtime_'+j).val()&&$('#txtEtime_'+b_seq).val()>$('#txtBtime_'+j).val()||$('#txtEtime_'+b_seq).val()>$('#txtEtime_'+j).val()&&$('#txtBtime_'+b_seq).val()<$('#txtEtime_'+j).val())){
	       						alert('該時間段與其他行程時間重疊!!!');
	       						$('#txtBtime_'+b_seq).focus();
	       						return;
	       					}
	       					if(!emp($('#txtBtime_'+b_seq).val())&&b_seq!=j&&!emp($('#txtBtime_'+j).val())&&!emp($('#txtEtime_'+j).val())&&($('#txtBtime_'+b_seq).val()>$('#txtBtime_'+j).val()&&$('#txtBtime_'+b_seq).val()<$('#txtEtime_'+j).val())){
	       						alert('該時間與其他行程時間重疊!!!');
	       						$('#txtBtime_'+b_seq).focus();
	       						return;
	       					}
	       				}
	            	});
	            	$('#txtEtime_'+i).change(function () {
	            		t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if(!emp($('#txtBtime_'+b_seq).val())&&!emp($('#txtEtime_'+b_seq).val())&&$('#txtBtime_'+b_seq).val()>$('#txtEtime_'+b_seq).val()){
							var t_time=$('#txtBtime_'+b_seq).val();
							$('#txtBtime_'+b_seq).val($('#txtEtime_'+b_seq).val());
							$('#txtEtime_'+b_seq).val(t_time);
						}
	            		for(var j = 0; j < q_bbsCount; j++) {
	            			if(!emp($('#txtBtime_'+b_seq).val())&&!emp($('#txtEtime_'+b_seq).val())&&b_seq!=j&&!emp($('#txtBtime_'+j).val())&&!emp($('#txtEtime_'+j).val())&&($('#txtBtime_'+b_seq).val()<$('#txtBtime_'+j).val()&&$('#txtEtime_'+b_seq).val()>$('#txtBtime_'+j).val()||$('#txtEtime_'+b_seq).val()>$('#txtEtime_'+j).val()&&$('#txtBtime_'+b_seq).val()<$('#txtEtime_'+j).val())){
	       						alert('該時間段與其他行程時間重疊!!!');
	       						$('#txtBtime_'+b_seq).focus();
	       						return;
	       					}
	       					if(!emp($('#txtEtime_'+b_seq).val())&&b_seq!=j&&!emp($('#txtBtime_'+j).val())&&!emp($('#txtEtime_'+j).val())&&($('#txtEtime_'+b_seq).val()>$('#txtBtime_'+j).val()&&$('#txtEtime_'+b_seq).val()<$('#txtEtime_'+j).val())){
	       						alert('該時間與其他行程時間重疊!!!');
	       						$('#txtEtime_'+b_seq).focus();
	       						return;
	       					}     						
	       				}
	            	});
	            }
           }
        	
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();

        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtProduct').focus();
            
           
        }
        function btnPrint() {
            q_box('z_trip.aspx', '', "90%", "600px", q_getMsg("popPrint"));       	
        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['cno'] &&!as['btime'] &&!as['memo']) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['datea'] = abbm2['datea'];
            as['sssno'] = abbm2['sssno'];

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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
            	width: 99%;
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
                width: 43%;
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
            }
            
            .tbbs a {
                font-size: medium;
            }
            .dbbs .tbbs{margin:0;padding:2px;border:2px lightgrey double;border-spacing:1px;border-collapse:collapse;font-size:medium;color:blue;background:#cad3ff;width:100%;}
			 .dbbs .tbbs tr{height:35px;}
			 .dbbs .tbbs tr td{text-align:center;border:2px lightgrey double;}
            .num {
                text-align: right;
            }
            .bbs{
            	float:left;
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
                <td align="center"><a id='vewNamea'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='namea'>~namea</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 74%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='td1'><span> </span><a id="lblNoa" class="lbl"></a></td>
            <td class='td2'><input id="txtNoa"  type="text" class="txt c1" /></td>
            <td class='td3'></td>
            <td class='td4'></td>
       </tr>
       <tr>
       		<td class='td1'><span> </span><a id="lblDatea" class="lbl"></a></td>
            <td class='td2'><input id="txtDatea" type="text" class="txt c4"/></td>
       </tr>
        <tr>
            <td class='td1'><span> </span><a id="lblSss" class="lbl btn"></a></td>
            <td class='td2'><input id="txtSssno"  type="text"  class="txt c2"/><input id="txtNamea"  type="text"  class="txt c3"/></td>
        </tr>
        <tr>
            <td class='td1'><span> </span><a id="lblMemo" class="lbl"></a></td>
            <td class='td2' colspan='3'><input id="txtMemo"  type="text"  class="txt c1"/></td>
        </tr>  
        </table>
        </div>
		</div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                <td align="center" style="width:15%"><a id='lblTimes'></a></td>
                <td align="center" style="width:23%"><a id='lblAcomps'></a></td>
                <td align="center" style="width:55%"><a id='lblMemos'></a></td>
                <td align="center" style="width:4%"><a id='lblTele_pollings'></a></td>
            </tr>
            <tr >
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c4" id="txtBtime.*" type="text" /><a style="float: left;">&nbsp;~&nbsp;</a><input class="txt c4" id="txtEtime.*" type="text" /></td>
                <td >
                	<input class="btn"  id="btnAcomp.*" type="button" value='.' style="font-weight: bold;width:1%;float: left;" />
                	<input class="txt" id="txtCno.*" type="text" style="width:25%;"/>
                	<input class="txt" id="txtAcomp.*" type="text" style="width:63%;"/>
                </td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
                <td ><input id="chkTele_polling.*" type="checkbox"/><input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
