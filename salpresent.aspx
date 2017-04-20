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
        var q_name = "salpresent";
        var q_readonly = ['txtW100','txtW133','txtW166','txtW200','txtW266','txtHr_special','txtMount'];
        var q_readonlys = [];
        var bbmNum = [['txtW100', 10, 1, 1],['txtW133', 10, 1, 1],['txtW166', 10, 1, 1],['txtW200', 10, 1, 1],['txtW266', 10, 1, 1],['txtHr_special', 10, 1, 1],['txtMount', 10, 0, 1]];  
        var bbsNum = [['txtW100', 10, 1, 1],['txtW133', 10, 1, 1],['txtW166', 10, 1, 1],['txtW200', 10, 1, 1],['txtW266', 10, 1, 1],['txtHr_special', 10, 1, 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
        q_desc=1;
		aPop = new Array(['txtSssno_', '', 'sss', 'noa,namea', 'txtSssno_,txtNamea_', 'sss_b.aspx']);
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

		//105/12/27 因調整新制 不再區分假日與正常日 //周六=休息日 計算方式=上班加班時數
		//W200 為當天工作超過12小時 之後薪水為*2 目前只有聯琦RK使用 
		
		var t_restday=false;//休息日 預設禮拜六
		var t_sumday=false;//例假日 預設禮拜日
		var t_holiday=false;//國定假日
		var t_workday=false;//工作天
        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtNoa', r_picd]];
            q_mask(bbmMask);
            
            if(q_getPara('sys.project').toUpperCase()=='VU' || q_getPara('sys.project').toUpperCase()=='DJ'){
            	bbsMask = [['txtClockin', '99:99'],['txtClockout', '99:99']];
            }else{
            	bbsMask = [['txtClockin', '99:99:99'],['txtClockout', '99:99:99'],['txtRestin', '99:99:99'],['txtRestout', '99:99:99']];
            }
            q_mask(bbsMask);
            
            /*if(q_getPara('sys.project').toUpperCase()=='RB'){
            	q_readonlys = ['txtW133','txtW166','txtW100','txtHr_special']
            }*/
           
			$('#lblRein').click(function() {
				if(q_cur==1 || q_cur==2)
					$('#txtRein').val('Y');
			});
            
			/*$('#chkHoliday').click(function () {
             	if(q_getPara('sys.project').toUpperCase()=='VU'){
             		table_change();
	        		return;
	            }
             	
             	if($('#chkHoliday').prop('checked')){
					for (var j = 0; j < q_bbsCount; j++) {
					    $('#txtW100_'+j).val(q_add(q_add(dec($('#txtW133_'+j).val()),dec($('#txtW166_'+j).val())),dec($('#txtW200_'+j).val())));
					    $('#txtW133_'+j).val(0);
					    $('#txtW166_'+j).val(0);
					    $('#txtW200_'+j).val(0);
			    	}
             	}else{
             		for (var j = 0; j < q_bbsCount; j++) {
             			if(dec($('#txtW100_'+j).val())>4 && q_getPara('sys.project').toUpperCase()=='RK'){
             				$('#txtW133_'+j).val(2);
					    	$('#txtW166_'+j).val(2);
					    	$('#txtW200_'+j).val(q_sub($('#txtW100_'+j).val(),4));
             			}else if(dec($('#txtW100_'+j).val())>2){
					    	$('#txtW133_'+j).val(2);
					    	$('#txtW166_'+j).val(q_sub($('#txtW100_'+j).val(),2));
					    }else{
					    	$('#txtW133_'+j).val($('#txtW100_'+j).val());
					    	$('#txtW166_'+j).val(0);
					    }
					    $('#txtW100_'+j).val(0);
				    }
             	}
            	table_change();
            });*/
            
            $('#btnInput').click(function () {
            	if(!emp($('#txtNoa').val())){
            		var t_date=$('#txtNoa').val();
            		if(r_len==3){
            			if(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==0){
            				t_sumday=true;
            			}else{
            				t_sumday=false;
            			}
            			if(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==6){
            				t_restday=true;
            			}else{
            				t_restday=false;
            			}
            		}else{
            			if(new Date(dec(t_date.substr(0,4)),dec(t_date.substr(5,2))-1,dec(t_date.substr(8,2))).getDay()==0){
            				t_sumday=true;
            			}else{
            				t_sumday=false;
            			}
            			if(new Date(dec(t_date.substr(0,4)),dec(t_date.substr(5,2))-1,dec(t_date.substr(8,2))).getDay()==6){
            				t_restday=true;
            			}else{
            				t_restday=false;
            			}
            		}
	            	q_gt('holiday',"where=^^noa='"+$('#txtNoa')+"' ^^", 0, 0, 0, "", r_accy);
	            	
            	}
            });
            
            $('#txtNoa').blur(function () {
            	var t_where = "where=^^ noa='"+$('#txtNoa').val()+"' ^^";
			    q_gt('salpresent', t_where , 0, 0, 0, "", r_accy);
	            table_change();
            });
        }

        function q_boxClose(s2) { 
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
            		t_workday=false;
            		var as = _q_appendData("holiday", "", true);
            		if(as[0]!=undefined){
            			if(as[0].iswork=='true'){
            				t_workday=true;
            			}else{
            				t_holiday=true;
            			}
            		}
            		
            		var t_where=''
	            	t_where = "where=^^ (isnull(outdate,'')='' or outdate >'"+$('#txtNoa').val()+"') and noa!='Z001' ^^";
	            	q_gt('sss', t_where, 0, 0, 0, "", r_accy);
	            	
            		break;
            	case 'sss':
            		var as = _q_appendData("sss", "", true);
            		for (var j = 0; j < as.length; j++) {
            			if((r_len==3 && $('#txtNoa').val()>='105/12/23') || (r_len==4 && $('#txtNoa').val()>='2016/12/23')){
	            			if(!t_workday){
	            				if(t_sumday || (t_holiday && t_restday)){//例假 或當國定假日在休息日或例假 給予補休
	            					as[j].special=8;
	            				}
	            				if(t_sumday || t_holiday){ //例假與國定假 加班費*2
	            					as[j].w100=8;
	            				}
	            				if (t_restday && !t_holiday){ //休息日 非國定假日 依新制加班費計算
	            					as[j].w133=2;
	            					as[j].w166=6;
	            				}
	            			}
            			}else{
            				if(!t_workday){
            					if(t_sumday || t_restday || t_holiday){
            						as[j].w100=8;
            					}
            				}
            			}
            			
            			if(q_getPara('sys.project').toUpperCase()=='IT'){
            				if(as[j].typea.indexOf('中班')>-1){
            					as[j].clockin='16:00';
            					as[j].clockout='00:00';
            				}else if(as[j].typea.indexOf('晚班')>-1){
            					as[j].clockin='00:00';
            					as[j].clockout='08:00';
            				}else{
            					as[j].clockin='09:00';
            					as[j].clockout='18:00';
            				}
            			}else if(q_getPara('sys.project').toUpperCase()=='DC'){
            				as[j].clockin='08:00';
            				as[j].clockout='17:30';
            			}if(q_getPara('sys.project').toUpperCase()=='RK'){
            				if(as[j].class5=='01'){ //現場班
            					as[j].clockin='08:00';
            					as[j].clockout='17:00';
            				}
            				if(as[j].class5=='02'){//辦公室班
            					as[j].clockin='08:30';
            					as[j].clockout='17:30';
            				}
            				if(as[j].class5=='03'){//辦公室-台北班
            					as[j].clockin='09:00';
            					as[j].clockout='17:30';
            				}
            			}else{
            				as[j].clockin='08:00';
            				as[j].clockout='17:00';
            			}
            		}
            		q_gridAddRow(bbsHtm, 'tbbs', 'txtSssno,txtNamea,txtClockin,txtClockout,txtW100,txtW133,txtW166,txtHr_special'
            		, as.length, as, 'noa,namea,clockin,clockout,w100,w133,w166,special', '');
            		sum()
            		table_change();
            	break;
                case q_name: 
                	if (q_cur == 1){
                		var as = _q_appendData("salpresent", "", true);
	                	if(as[0]!=undefined)
	                 		insed=true;
	                 	else
	                 		insed=false;
                	}
                	if (q_cur == 4)
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            $('#txtNoa').val($.trim($('#txtNoa').val()));
                if (checkId($('#txtNoa').val())==0){
                	alert(q_getMsg('lblNoa')+'錯誤。');
                	return;
            }       	
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            
            if(insed&&q_cur==1){
            	alert('該出勤作業已做過!!!');
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('salpresent_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function bbsAssign() {
        	$('.tbbs .num').change(function() {
        		if(q_cur==1 || q_cur==2){sum();}
			});
            _bbsAssign();
            table_change();
            if(q_getPara('sys.project').toUpperCase()=='VU'){
            	//$('#lblW133').text('加班時數');//106/04 調整
            	//$('#lblW133_s').text('加班時數');//106/04 調整
            	$('#lblW100').text('值班時數');
            	$('#lblW100_s').text('值班時數');
            }
            
            //105/12/27 新制調整
            $('#lblW200').text('例假日加班HR>8');
            $('#lblW200_s').text('例假日HR>8');
            $('#lblW266').text('休息日加班HR>8');
            $('#lblW266_s').text('休息日HR>8');
            
            if(q_getPara('sys.project').toUpperCase()=='RK'){
            	$('#lblW200').text('HR>4加班時數');
            	$('#lblW200_s').text('加班 HR>4');
            }
        }
		
		var insed=false;
        function btnIns() {
            _btnIns();
            $('#txtNoa').val(q_date());
            $('#txtNoa').focus();
            
            //判斷當天是否新增過
            var t_where = "where=^^ noa='"+$('#txtNoa').val()+"' ^^";
		    q_gt('salpresent', t_where , 0, 0, 0, "", r_accy);
            table_change();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtNoa').attr('disabled', 'disabled');
        }
        function btnPrint() {
			q_box("z_salpresent.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy + "_" + r_cno, 'salpresent', "95%", "95%", m_print);
        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {   
            if (!as['sssno']) {  
                as[bbsKey[1]] = '';  
                return;
            }

            q_nowf();
            as['datea'] = abbm2['datea'];

            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount=0, t_weight = 0;
            var t_w100=0,t_w133=0,t_w166=0,t_w200=0,t_w266=0,t_hr_special=0;
            for (var j = 0; j < q_bbsCount; j++) {
            	if(!emp($('#txtSssno_'+j).val()))
            		t_mount++;
				t_w100=q_add(t_w100,dec($('#txtW100_'+j).val()));
				t_w133=q_add(t_w133,dec($('#txtW133_'+j).val()));
				t_w166=q_add(t_w166,dec($('#txtW166_'+j).val()));
				t_w200=q_add(t_w200,dec($('#txtW200_'+j).val()));
				t_w266=q_add(t_w200,dec($('#txtW266_'+j).val()));
				t_hr_special=q_add(t_hr_special,dec($('#txtHr_special_'+j).val()));
            }  // j
            
            $('#txtW100').val(t_w100);
            $('#txtW133').val(t_w133);
            $('#txtW166').val(t_w166);
            $('#txtW200').val(t_w200);
            $('#txtW266').val(t_w266);
            $('#txtHr_special').val(t_hr_special);
            
            $('#txtMount').val(t_mount);
        }
        
        function refresh(recno) {
            _refresh(recno);
			table_change();
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
        
        function table_change() {
        	if(q_getPara('sys.project').toUpperCase()=='VU'){
	            //$('.w166').hide(); //106/04 調整
				$('.rein').show();
				$('.w200').hide();
				$('.w266').hide();
				$('.special').hide();
            }
            if(q_getPara('sys.project').toUpperCase()=='FE'){
            	$('.rest').show();
            }
            if(q_getPara('sys.project').toUpperCase()=='DC'){
            	$('.cardno').hide();
            	$('.special').hide();
            }
            sum();
        }

		function checkId(str) {
			if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
				var key = 'ABCDEFGHJKLMNPQRSTUVXYWZIO';
                var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
				var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
				if ((n % 10) == 0)
						return 1;
			}else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
				var key = '12121241';
				var n = 0;
				var m = 0;
				for (var i = 0; i < 8; i++) {
					n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
					m += Math.floor(n / 10) + n % 10;
				}
				if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
					return 2;
			}else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
				var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
				if(regex.test(str))
					return 3;
			}else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
				str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
				var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
				if(regex.test(str))
					return 4
			}
			return 0;//錯誤
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
                cursor: pointer;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 70%;
                float: right;
            }
            .txt.c3 {
                width: 47%;
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
                <td align="center" style="width:20%"><a id='vewMount'> </a></td>
                
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='mount'>~mount</td>
                  
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
            <td ><span> </span><a id="lblNoa" class="lbl" > </a></td>
            <td ><input id="txtNoa"  type="text" class="txt c1"/></td>
            <!--<td><input id="txtDay" type="text" class="txt c1" /></td> 
            <td><span> </span><a id="lblHours" class="lbl" > </a></td>--> 
            <td class='td6'><input id="chkHoliday" type="checkbox" style='display: none;'/><span> </span><a id="lblHoliday" style='display: none;'> </a></td>
            <td class="td7"><input id="btnInput" type="button" />
            	<input id="txtRein" type="text" class="txt c1 rein" style="width: 50px;float: right;display: none;" />
            	<span style="float: right;"> </span><a id="lblRein" class="lbl btn rein" style="float: right;display: none;"> </a>
            </td> 
        </tr>             
        <!--<tr class="tr2">
            <td ><span> </span><a id="lblData" class="lbl" > </a></td>
            <td colspan="3"><input id="txtData"  type="text" class="txt c1"/></td> 
            <td><input id="btnGlance" type="button" /></td>
        </tr>-->   
        <tr class="tr3">
            <td class='w133'><span> </span><a id="lblW133" class="lbl" > </a></td>
            <td class='w133'><input id="txtW133"  type="text" class="txt num c1"/></td>
            <td class='w166'><span> </span><a id="lblW166" class="lbl" > </a></td>
            <td class='w166'><input id="txtW166"  type="text" class="txt num c1"/></td> 
            <td class='w100'><span> </span><a id="lblW100" class="lbl" > </a></td>
            <td class='w100'><input id="txtW100"  type="text" class="txt num c1"/></td>
        </tr>
        <tr class='w200'>
            <td class='w200'><span> </span><a id="lblW200" class="lbl" > </a></td>
            <td class='w200'><input id="txtW200"  type="text" class="txt num c1"/></td>
            <td class='w266'><span> </span><a id="lblW266" class="lbl" > </a></td>
            <td class='w266'><input id="txtW266"  type="text" class="txt num c1"/></td>
            <!--<td><span> </span><a id="lblW300" class="lbl" > </a></td>
            <td><input id="txtW300"  type="text" class="txt num c1"/></td>-->
        </tr>
        <tr class="tr4">
            <td class="special"><span> </span><a id="lblHr_special" class="lbl" > </a></td>
            <td class="special"><input id="txtHr_special"  type="text" class="txt num c1"/></td>
            <td><span> </span><a id="lblMount" class="lbl" > </a></td>
            <td><input id="txtMount"  type="text" class="txt num c1"/></td>
        </tr>                                                                                                    
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblSssno_s'> </a></td>
                <td align="center"><a id='lblNamea_s'> </a></td>
                <td align="center"><a id='lblClockin_s'> </a></td>
                <td align="center" class='rest' style="display: none;"><a id='lblRestin_s'> </a></td>
                <td align="center" class='rest' style="display: none;"><a id='lblRestout_s'> </a></td>
                <td align="center"><a id='lblClockout_s'> </a></td>
                <td align="center" class="cardno"><a id='lblCardno_s'> </a></td>
                <td align="center" class='w133'><a id='lblW133_s'> </a></td>
                <td align="center" class='w166'><a id='lblW166_s'> </a></td>
                <td align="center" class='w100'><a id='lblW100_s'> </a></td>
                <td align="center" class='w200'><a id='lblW200_s'> </a></td>
                <td align="center" class='w266'><a id='lblW266_s'> </a></td>
                <!--<td align="center"><a id='lblW300_s'> </a></td>-->
                <td align="center" class='special'><a id='lblHr_special_s'> </a></td>
                <td align="center"><a id='lblMemo_s'> </a></td>
                <!--<td align="center"><a id='lblHour_s'> </a></td>
                <td align="center"><a id='lblAddwork_s'> </a></td>-->
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /><input id="txtNoq.*" type="hidden" /></td>
                <td ><input class="txt c1" id="txtSssno.*"type="text" /></td>
                <td ><input class="txt c1" id="txtNamea.*"type="text" /></td>
                <td ><input class="txt c1" id="txtClockin.*"type="text" /></td>
                <td class='rest' style="display: none;"><input class="txt c1" id="txtRestin.*"type="text" /></td>
                <td class='rest' style="display: none;"><input class="txt c1" id="txtRestout.*"type="text" /></td>
                <td ><input class="txt c1" id="txtClockout.*"type="text" /></td>
                <td class="cardno"><input class="txt c1" id="txtCardno.*"type="text" /></td>
                <td class='w133'><input class="txt num c1" id="txtW133.*"type="text" /></td>
                <td class='w166'><input class="txt num c1" id="txtW166.*"type="text" /></td>
                <td class='w100'><input class="txt num c1" id="txtW100.*"type="text" /></td>
                <td class='w200'><input class="txt num c1" id="txtW200.*"type="text" /></td>
                <td class='w266'><input class="txt num c1" id="txtW266.*"type="text" /></td>
                <!--<td ><input class="txt num c1" id="txtW300.*"type="text" /></td>-->
                <td class='special'><input class="txt num c1" id="txtHr_special.*"type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*"type="text" /></td>
                <!--<td ><input class="txt num c1" id="txtHour.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtAddwork.*" type="text" /></td>-->
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
