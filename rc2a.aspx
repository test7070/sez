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
        var q_name = "rc2a";
        var decbbs = ['mount', 'price', 'money', 'tax'];
        var decbbm = ['total', 'money', 'tax'];
        var q_readonly = ['txtMoney','txtTotal','txtTax','txtWorker','txtAccno'];
        var q_readonlys = [];
        var bbmNum = [['txtMoney', 15, 0], ['txtTax', 15, 0], ['txtTotal', 15, 0]];  
        var bbsNum = [['txtMount', 15, 3], ['txtPrice', 15, 3], ['txtMoney', 15, 0]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp,serial,addr_invo', 'txtTggno,txtComp,txtSerial,txtAddress', 'tgg_b.aspx'],
        ['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtAcomp','acomp_b.aspx'],
        ['txtBuyerno', 'lblBuyer', 'cust', 'noa,comp', 'txtBuyerno,txtBuyer', 'cust_b.aspx'],
        ['txtProductno_', 'btnProductno_', 'ucca', 'noa,product,unit', 'txtProductno_,txtProduct_,txtUnit_', 'ucca_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
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
            bbmMask = [['txtDatea', r_picd],['txtMon', r_picm]];
            q_mask(bbmMask);
             q_cmbParse("cmbTypea", q_getPara('rc2.typea')); 
             q_cmbParse("cmbTaxtype", ('').concat(new Array('應稅', '零稅率', '內含', '免稅','自訂','作廢')));
            /* 若非本會計年度則無法存檔 */
			$('#txtDatea').focusout(function () {
				if($(this).val().substr( 0,3)!= r_accy){
			        	$('#btnOk').attr('disabled','disabled');
			        	alert(q_getMsg('lblDatea') + '非本會計年度。');
				}else{
			       		$('#btnOk').removeAttr('disabled');
				}
			});
        }
		var checkenda=false;
		var holiday;//存放holiday的資料
		function endacheck(x_datea,x_day) {
			//102/06/21 7月份開始資料3日後不能在處理
			var t_date=x_datea,t_day=1;
                
			while(t_day<x_day){
				var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2)));
				nextdate.setDate(nextdate.getDate() +1)
				t_date=''+(nextdate.getFullYear()-1911)+'/';
				//月份
				t_date=t_date+((nextdate.getMonth()+1)<10?('0'+(nextdate.getMonth()+1)+'/'):((nextdate.getMonth()+1)+'/'));
				//日期
				t_date=t_date+(nextdate.getDate()<10?('0'+(nextdate.getDate())):(nextdate.getDate()));
	                	
				//六日跳過
				if(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==0 //日
				||new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==6 //六
				){continue;}
	                	
				//假日跳過
				if(holiday){
					var isholiday=false;
					for(var i=0;i<holiday.length;i++){
						if(holiday[i].noa==t_date){
							isholiday=true;
							break;
						}
					}
					if(isholiday) continue;
				}
	                	
				t_day++;
			}
                
			if (t_date<q_date()){
				checkenda=true;
			}else{
				checkenda=false;
			}
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
            	case 'holiday':
            		holiday = _q_appendData("holiday", "", true);
            		endacheck($('#txtDatea').val(),q_getPara('sys.modiday'));//單據日期,幾天後關帳
            	break;
                case q_name: if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
			$('#txtMon').val($.trim($('#txtMon').val()));
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
					alert(q_getMsg('lblMon')+'錯誤。');   
					return;
			} 
			t_err = '' ;
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

            q_box('rc2a_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   
        }

        function bbsAssign() {  
        	for (var j = 0; j < q_bbsCount; j++) {
        	//----------------數量和單價計算
            	$('#txtMount_'+j).change(function () {
		            t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
		            q_bodyId($(this).attr('id'));
		            b_seq = t_IdSeq;
		            $('#txtMoney_'+b_seq).val(Math.round(dec($('#txtMount_'+b_seq).val())*dec($('#txtPrice_'+b_seq).val())));
		                	
		            sum();
				});
		                
	            $('#txtPrice_'+j).change(function () {
					t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					$('#txtMoney_'+b_seq).val(Math.round(dec($('#txtMount_'+b_seq).val())*dec($('#txtPrice_'+b_seq).val())));
		                	
					sum();
				});
				
				$('#txtMoney_'+j).change(function () {
					sum();
				});
				
		    }
        	
        	
        	
        	
        	
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
            $('#cmbTaxtype').val(1);
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            if (checkenda){
                alert('超過'+q_getPara('sys.modiday')+'天'+'已關帳!!');
                return;
	    }
            _btnModi();
             $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['noq'] ) {  
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
            var t_money=0;
            for (var j = 0; j < q_bbsCount; j++) {
				t_money+=dec($('#txtMoney_'+j).val());//金額合計
            }  // j
			q_tr('txtMoney' ,t_money,0);
            //$('#txtTotal').val(t_money+t_tax);
            calTax();
        }

        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
            if(r_rank<=7)
            	q_gt('holiday', "where=^^ noa>='"+$('#txtDatea').val()+"'^^" , 0, 0, 0, "", r_accy);//單據日期之後的假日
            else
            	checkenda=false;
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
            if (q_tables == 's')
                bbsAssign();  /// 表身運算式 
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
        	if (checkenda){
                alert('超過'+q_getPara('sys.modiday')+'天'+'已關帳!!');
                return;
	    	}
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
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 61%;
                float: left;
            }
            .txt.c4 {
                width: 25%;
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
        .tbbs
        {
            FONT-SIZE: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:98% ;  
        }  
      select{
      	font-size: medium;
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
	        	<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
	            <td class="td2"><input id="txtDatea" type="text" class="txt c1"/></td>
	            <td class="td3"><span> </span><a id="lblAcomp" class="lbl btn" > </a></td>
	            <td class="td4" colspan="3"><input id="txtCno" type="text" class="txt c2"/>
	            	<input id="txtAcomp" type="text" class="txt c3"/><input id="txtNick"  type="hidden"/></td>
                        
        </tr>
        <tr class="tr2">
        		<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
               <td class="td2"><input id="txtNoa" type="text"  class="txt c1"/></td>
               <td class="td3"><input id="txtCobtype"  type="text" class="txt c2" />
               	<span> </span><a id="lblTgg" class="lbl btn"> </a></td>
               <td class="td4" colspan="3"><input id="txtTggno"  type="text" class="txt c2" />              
               					<input id="txtComp"  type="text" class="txt c3" /></td>
        </tr>
        <tr class="tr3">
        	<td class="td1"><span> </span><a id='lblSerial' class="lbl"> </a></td>
            <td class="td2"><input id="txtSerial"  type="text"  class="txt c1"/></td>
            <td class="td3"><span> </span><a id='lblAddress' class="lbl"> </a></td>
            <td class="td4" colspan="3"><input id="txtAddress" type="text" style="width: 99%;"/></td>  
        </tr>
        <tr class="tr4">
            <td class="td1"><span> </span><a id='lblMon' class="lbl"> </a></td>
            <td class="td2"><input id="txtMon" type="text" class="txt c1"/></td>
            <td class="td3"><span> </span><a id='lblType' class="lbl"> </a></td>
            <td class="td4"><select id="cmbTypea" class="txt c1"> </select></td>                           
        </tr>
        <tr class="tr5">
            <td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
            <td class="td2"><input id="txtMoney" type="text" class="txt num c1" /></td>    
            <td class="td3"><span> </span><a id='lblTax' class="lbl"> </a></td>
            <td class="td4"><input id="txtTax"  type="text" class="txt num c1" /></td> 
            <td class="td5"><span> </span><a id='lblTotal' class="lbl"> </a></td>
            <td class="td6"><input id="txtTotal" type="text" class="txt num c1" /></td>                    
        </tr>
        <tr class="tr6">
            <td class="td1"><span> </span><a id='lblTaxtype' class="lbl"> </a></td>
            <td class="td2"><select id="cmbTaxtype" style='width:100%'  onchange='calTax()' / ></select></td>
            <td class="td3"><span> </span><a id='lblWorker' class="lbl"> </a></td>
            <td class="td4"><input id="txtWorker" type="text" class="txt c1" /></td>
        </tr>
        <tr class="tr7">
        	<td class="td1"><span> </span><a id='lblAccno' class="lbl"> </a></td>
            <td class="td2"><input id="txtAccno"  type="text" class="txt c1" /></td>
              <td class="td3"><span> </span><a id='lblBuyer' class="lbl btn"> </a></td>
            <td class="td4" colspan="3"><input id="txtBuyerno"  type="text"  class="txt c2"/>
            						<input id="txtBuyer"  type="text" class="txt c3" /></td>
        </tr>
        <tr class="tr8">
            <td class="td1"><span> </span><a id="lblMemo" class="lbl" > </a></td>
            <td class="td2" colspan='5'><input id="txtMemo" type="text" class="txt c1" /></td>
        </tr>
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <!--<td align="center" style="width: 5%;"><a id='lblNoq'> </a></td>-->
                <td align="center" style="width: 15%;"><a id='lblProductno'> </a></td>
                <td align="center" style="width: 20%;"><a id='lblProduct'> </a></td>
                <td align="center" style="width: 5%;"><a id='lblUnit'> </a></td>
                <td align="center" style="width: 10%;"><a id='lblMount'> </a></td>
                <td align="center" style="width: 10%;"><a id='lblPrice'> </a></td>
                <td align="center" style="width: 13%;"><a id='lblMoneys'> </a></td>
                <td align="center"><a id='lblMemos'> </a></td>              
            </tr>
            <tr  style='background:#cad3ff;'>
                <td><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <!--<td><input id="txtNoq.*" type="text" class="txt c2" /></td>-->
                <td><input id="txtProductno.*" type="text" style="width: 80%;"/><input id="btnProductno.*" type="button" value="..."style="width: 15%;" /></td>
                <td><input id="txtProduct.*"type="text" class="txt c1"/></td>
                <td><input id="txtUnit.*" type="text" class="txt c1"/></td>
                <td><input id="txtMount.*" type="text" class="txt num c1" /></td>
                <td><input id="txtPrice.*" type="text" class="txt num c1" /></td>
                <td><input id="txtMoney.*" type="text" class="txt num c1" /></td>
                <td><input id="txtMemo.*" type="text" class="txt c1"/><input id="txtNoq.*" type="hidden" /></td>
           </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>

