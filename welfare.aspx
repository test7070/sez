<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            q_desc=1;
            q_tables = 's';
            var q_name="welfare";
            var q_readonly = ['txtNoa','txtIncome','txtPay'];
            var q_readonlys = [];
            var bbmNum = [['txtIncome',10,0,0,1],['txtPay',10,0,0,1]];
            var bbsNum = [['txtIncome',10,0,0,1],['txtPay',10,0,0,1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
           aPop = new Array(['txtSssno', 'lblSssno', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
            	bbmMask = [['txtDatea', r_picd]];
        	q_getFormat();
        	q_mask(bbmMask);
        	
				 $('#txtDatea').focusout(function () {
                     	   q_cd( $(this).val() ,$(this));
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
            function q_funcPost(t_func,result) {
		    var s1 = location.href;
		    var t_path = (s1.substr(7, 5) == 'local' ? xlsPath : s1.substr(0, s1.indexOf('/', 10)) + '/htm/');
        }

            function q_boxClose(s2) {
                   
            var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
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

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
            function btnOk() {
            		$('#txtDatea').val($.trim($('#txtDatea').val()));
		          if (!emp($('#txtDatea').val())&&checkId($('#txtDatea').val())==0){
		             alert(q_getMsg('lblDatea')+'錯誤');
		          return;
		    }
		    var t_err = '';
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtComp', q_getMsg('lblComp')] ]);
            if( t_err.length > 0) {
                alert(t_err);
                return;
            }
			 sum();
			$('#txtWorker').val(r_name);
			
			var t_noa = trim($('#txtNoa').val());
			 var t_date = trim($('#txtDatea').val());
    		 if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_welfare') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);		            
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)  // 1-3
                return;
            q_box('welfare_s.aspx', q_name + '_s', "500px", "300px", q_getMsg( "popSeek"));
            }
            function btnIns() {
                _btnIns();
            $('#txtNoa').val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
                
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                return;
				 if (checkenda){
                	alert('已關帳!!');
                	return;
	    			}
            _btnModi();
            $('#txtBdate').focus();
            }
            function btnPrint() {
            	q_box('z_welfare.aspx', '', "95%", "650px", q_getMsg("popPrint"));
            }
            function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//�����Ҧr��
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//�Τ@�s��
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//�褸�~
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//����~
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//��~
            }
          function wrServer( key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   /// popSave
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }
       
            function bbsAssign() {
                for(var i = 0; i < q_bbsCount; i++) {
                
                	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    }
                }
                _bbsAssign();
            }

            function bbsSave(as) {
            	t_err = '';
                if (parseFloat(as['product'])==0) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                if (t_err) {
                    alert(t_err)
                    return false;
                }
                return true;
            }

            function sum() {
            var t1 = 0, t_unit, t_mount, t_income = 0, t_pay = 0;
            for (var j = 0; j < q_bbsCount; j++) {
				t_income+=dec($('#txtIncome_'+j).val());
				t_pay+=dec($('#txtPay_'+j).val());
            }  // j
			q_tr('txtIncome',t_income);
			q_tr('txtPay',t_pay);
            	if(!(q_cur==1 || q_cur==2))
					return;
					
            }
            function refresh(recno) {
                _refresh(recno);
                if(r_rank<=8)
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
         	       alert('已關帳!!');
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
                width: 36%;
                float: right;
            }
            .txt.c3 {
                width: 62%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 98%;
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
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbm select{
            	font-size:medium;
            }
            .dbbs {
                width: 50%;
            }
            .tbbs a {
                font-size: medium;
            }

           
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					 <tr>
                <td align="center" style="width:5%"><a id='vewChk'> </a></td>
                <td align="center" style="width:40%"><a id='vewDatea'> </a></td>
                <td align="center" style="width:40%"><a id='vewNamea'> </a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='namea'>~namea</td>
            </tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					 <tr>
            	<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
               <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
            </tr>
            <tr>
            	<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
               <td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
               <td class="td3"> </td>
               <td class="td4"> </td>
               <td class="td5"> </td>
            </tr>
            <tr>
            	<td class="td1"><span> </span><a id='lblSssno' class="lbl btn"> </a></td>
               <td class="td2" colspan="2"><input id="txtSssno"  type="text" class="txt c2"/>
               <input id="txtNamea"  type="text" class="txt c3"/></td>
            </tr>
            <tr>
            	<td class="td1"><span> </span><a id='lblInpaymemo' class="lbl"> </a></td>
               <td class="td2"><input id="txtInpaymemo"  type="text" class="txt c5"/></td>
            </tr>
            <tr>
            	<td class="td1"><span> </span><a id='lblIncome' class="lbl"> </a></td>
               <td class="td2"><input id="txtIncome"  type="text" class="txt num c1"/></td>
            </tr>
            <tr>
            	<td class="td1"><span> </span><a id='lblPay' class="lbl"> </a></td>
               <td class="td2"><input id="txtPay"  type="text" class="txt num c1"/></td>
            </tr>
            <tr>
            	<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
               <td class="td2"><input id="txtMemo"  type="text" class="txt c5"/></td>
            </tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width: 2%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20%;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblIncome_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblPay_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><input id="txtProduct.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtIncome.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td><input id="txtPay.*" type="text" style="width: 95%;text-align: right;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
