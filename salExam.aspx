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
        var q_name = "salexam";
        var q_readonly = ['txtNoa','txtDatea','txtWorker','txtWorker2'];
        var q_readonlys = [];
        var bbmNum = [];  // 允許 key 小數
        var bbsNum = [];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        //ajaxPath = ""; // 只在根目錄執行，才需設定
		aPop = new Array(['txtSssno_', 'lblSssno', 'sss', 'noa,namea,partno,part,jobno,job,', 'txtSssno_,txtNamea_,txtPartno_,txtPart_,txtJobno_,txtJob_', 'sss_b.aspx']
				,['txtPartno', 'lblPart', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx']);
		q_desc=1;
        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();  // 計算 合適  brwCount 
            
            if(r_rank<8){
            	q_content = "where=^^workerno='" + r_userno+ "'^^";
            	//q_gt('sss', "where=^^noa='" + r_userno + "'^^", q_sqlCount, 1)
            }
            q_gt(q_name, q_content, q_sqlCount, 1)
        });

        //////////////////   end Ready
        function main() {
            if (dataErr)  /// 載入資料錯誤
            {
                dataErr = false;
                return;
            }

            mainForm(1); // 1=最後一筆  0=第一筆
        }
        function mainPost() { // 載入資料完，未 refresh 前
            q_getFormat();
            bbmMask = [['txtDatea', r_picd],['txtYear', '999']];
            q_mask(bbmMask);
            if(r_rank>=8){
            	$('#checkIsall').show();
            	$('#lblIsall').show();
            }else{
            	$('#checkIsall').hide();
            	$('#lblIsall').hide();
            }
            
            
            $('#btnImport').click(function() {
            	if(r_rank==9){//總事長評量副總
            		if(!emp($('#txtPartno').val())){
            			if($('#txtPartno').val()=='03')//財務部跟內帳部一起
	            			var t_where = "where=^^ (partno ='"+$('#txtPartno').val()+"' or partno='04') and noa!='"+r_userno+"' and noa!='Z001' and noa!='010132'^^";
	            		else if($('#txtPartno').val()=='08')//運輸部跟中鋼部一起
	            			var t_where = "where=^^ (partno ='"+$('#txtPartno').val()+"' or partno='09') and noa!='"+r_userno+"' and noa!='Z001' and noa!='010132'^^";
	            		else
	            			var t_where = "where=^^ partno ='"+$('#txtPartno').val()+"' and noa!='"+r_userno+"' and noa!='Z001' and noa!='010132'^^";
            		}else{
	            		if($('#checkIsall')[0].checked==true)
	            			var t_where = "where=^^ noa!='"+r_userno+"' and noa!='Z001' and noa!='010132'^^";
	            		else
	            			var t_where = "where=^^ (partno ='02' and jobno='02') ^^";
            		}
            	}else if(r_rank==8){//副總評量各主管(含監理部經理)以及部門以下員工
            		if(!emp($('#txtPartno').val())){
            			if($('#txtPartno').val()=='03')//財務部跟內帳部一起
	            			var t_where = "where=^^ (partno ='"+$('#txtPartno').val()+"' or partno='04') and noa!='Z001' and noa!='010132'^^";
	            		else if($('#txtPartno').val()=='08')//運輸部跟中鋼部一起
	            			var t_where = "where=^^ (partno ='"+$('#txtPartno').val()+"' or partno='09') and noa!='Z001' and noa!='010132'^^";
	            		else
	            			var t_where = "where=^^ partno ='"+$('#txtPartno').val()+"' and noa!='Z001' and noa!='010132'^^";
            		}else{
	            		if($('#checkIsall')[0].checked==true)
	            			var t_where = "where=^^ noa!='"+r_userno+"' and noa!='Z001' and noa!='010132'^^";
	            		else
	            			var t_where = "where=^^ (partno ='"+$('#txtPartno').val()+"' or jobno<='03' or (partno='07' and jobno<='04')) and noa!='"+r_userno+"' and noa!='Z001' and noa!='010132'^^";
            		}
            	}else{
            		if($('#txtPartno').val()=='03')//財務部跟內帳部一起
            			var t_where = "where=^^ (partno ='"+$('#txtPartno').val()+"' or partno='04') and noa!='"+r_userno+"' and noa!='Z001' and noa!='010132'^^";
            		else if($('#txtPartno').val()=='08')//運輸部跟中鋼部一起
            			var t_where = "where=^^ (partno ='"+$('#txtPartno').val()+"' or partno='09') and noa!='"+r_userno+"' and noa!='Z001' and noa!='010132'^^";
            		else
            			var t_where = "where=^^ partno ='"+$('#txtPartno').val()+"' and noa!='"+r_userno+"' and noa!='Z001' and noa!='010132'^^";
            	}
            	q_gt('sss', t_where , 0, 0, 0, "", r_accy);
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
        function q_boxClose(s2) { ///   q_boxClose 2/4 /// 查詢視窗、客戶視窗、報價視窗  關閉時執行
            var ret;
            switch (b_pop) {   /// 重要：不可以直接 return ，最後需執行 originalClose();
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }

		var r_partno='',r_part='';
        function q_gtPost(t_name) {  /// 資料下載後 ...
            switch (t_name) {
            	case 'holiday':
            		holiday = _q_appendData("holiday", "", true);
            		endacheck($('#txtDatea').val(),q_getPara('sys.modiday'));//單據日期,幾天後關帳
            	break;
            	case 'sss':
            		/*if(q_cur==0){
            			var as = _q_appendData("sss", "", true);
            			q_content = "where=^^partno='" + as[0].partno + "'^^";
            			r_partno=as[0].partno;
            			r_part=as[0].part;
            			q_gt(q_name, q_content, q_sqlCount, 1);
            		}*/
            		if(q_cur==1 || q_cur==2){
            			var as = _q_appendData("sss", "", true);
            			as.sort(function(a,b){return a.jobno-b.jobno;});  
            			
            			q_gridAddRow(bbsHtm, 'tbbs', 'txtSssno,txtNamea,txtPartno,txtPart,txtJobno,txtJob', as.length, as, 'noa,namea,partno,part,jobno,job', '');
            		}
            		break;
                case q_name: 
                	if (q_cur == 4)   // 查詢
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
        	t_err = '';
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  // 檢查空白 
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
             if(q_cur==1){
             	$('#txtWorkerno').val(r_userno);
	            $('#txtWorker').val(r_name);
            }else
            	$('#txtWorker2').val(r_name);
            	
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   /// 自動產生編號
                q_gtnoa(q_name, replaceAll('E' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('salexam_s.aspx', q_name + '_s', "500px", "250px", q_getMsg("popSeek"));
        }

        function bbsAssign() {  /// 表身運算式
        	for (var j = 0; j < q_bbsCount; j++) {
	        	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
	        		$('#txtEfficiency_'+j).change(function () {
	           				t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!(dec($('#txtEfficiency_'+b_seq).val())>=6 && dec($('#txtEfficiency_'+b_seq).val())<=20))
							{
								alert(q_getMsg('lblEfficiency_s')+'分數錯誤!!');
								$('#txtEfficiency_'+b_seq).val(6)
							}
							totalsum(b_seq);
	           		});
	        		$('#txtDuty_'+j).change(function () {
	           				t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!(dec($('#txtDuty_'+b_seq).val())>=5 && dec($('#txtDuty_'+b_seq).val())<=15))
							{
								alert(q_getMsg('lblDuty_s')+'分數錯誤!!');
								$('#txtDuty_'+b_seq).val(5)
							}
							totalsum(b_seq);
	           		});
	           		$('#txtAb_incoo_'+j).change(function () {
	           				t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!(dec($('#txtAb_incoo_'+b_seq).val())>=5 && dec($('#txtAb_incoo_'+b_seq).val())<=15))
							{
								alert(q_getMsg('lblAb_incoo_s')+'分數錯誤!!');
								$('#txtAb_incoo_'+b_seq).val(5)
							}
							totalsum(b_seq);
	           		});
	           		$('#txtAb_harcoo_'+j).change(function () {
	           				t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!(dec($('#txtAb_harcoo_'+b_seq).val())>=4 && dec($('#txtAb_harcoo_'+b_seq).val())<=10))
							{
								alert(q_getMsg('lblAb_harcoo_s')+'分數錯誤!!');
								$('#txtAb_harcoo_'+b_seq).val(4)
							}
							totalsum(b_seq);
	           		});
	           		$('#txtAb_leabeh_'+j).change(function () {
	           				t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!(dec($('#txtAb_leabeh_'+b_seq).val())>=4 && dec($('#txtAb_leabeh_'+b_seq).val())<=10))
							{
								alert(q_getMsg('lblAb_leabeh_s')+'分數錯誤!!');
								$('#txtAb_leabeh_'+b_seq).val(4)
							}
							totalsum(b_seq);
	           		});
	           		$('#txtAb_anadet_'+j).change(function () {
	           				t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!(dec($('#txtAb_anadet_'+b_seq).val())>=4 && dec($('#txtAb_anadet_'+b_seq).val())<=10))
							{
								alert(q_getMsg('lblAb_anadet_s')+'分數錯誤!!');
								$('#txtAb_anadet_'+b_seq).val(4)
							}
							totalsum(b_seq);
	           		});
	           		$('#txtAb_worknow_'+j).change(function () {
	           				t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!(dec($('#txtAb_worknow_'+b_seq).val())>=1 && dec($('#txtAb_worknow_'+b_seq).val())<=5))
							{
								alert(q_getMsg('lblAb_worknow_s')+'分數錯誤!!');
								$('#txtAb_worknow_'+b_seq).val(1)
							}
							totalsum(b_seq);
	           		});
	           		$('#txtAttitude_'+j).change(function () {
	           				t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!(dec($('#txtAttitude_'+b_seq).val())>=1 && dec($('#txtAttitude_'+b_seq).val())<=5))
							{
								alert(q_getMsg('lblAttitude_s')+'分數錯誤!!');
								$('#txtAttitude_'+b_seq).val(1)
							}
							totalsum(b_seq);
	           		});
	           		$('#txtAb_innovation_'+j).change(function () {
	           				t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!(dec($('#txtAb_innovation_'+b_seq).val())>=1 && dec($('#txtAb_innovation_'+b_seq).val())<=5))
							{
								alert(q_getMsg('lblAb_innovation_s')+'分數錯誤!!');
								$('#txtAb_innovation_'+b_seq).val(1)
							}
							totalsum(b_seq);
	           		});
	           		$('#txtWorkdegree_'+j).change(function () {
	           				t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!(dec($('#txtWorkdegree_'+b_seq).val())>=1 && dec($('#txtWorkdegree_'+b_seq).val())<=5))
							{
								alert(q_getMsg('lblWorkdegree_s')+'分數錯誤!!');
								$('#txtWorkdegree_'+b_seq).val(1)
							}
							totalsum(b_seq);
	           		});
	        	}
	        }
            _bbsAssign();
        }
        
        function totalsum(seq) {
        	$('#txtTotal_'+seq).val(dec($('#txtEfficiency_'+seq).val())+dec($('#txtDuty_'+seq).val())+dec($('#txtAb_incoo_'+seq).val())+dec($('#txtAb_harcoo_'+seq).val())+dec($('#txtAb_leabeh_'+seq).val())+dec($('#txtAb_anadet_'+seq).val())+dec($('#txtAb_worknow_'+seq).val())+dec($('#txtAttitude_'+seq).val())+dec($('#txtAb_innovation_'+seq).val())+dec($('#txtWorkdegree_'+seq).val()));
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtYear').val(q_date().substr(0,3));
            $('#txtDatea').val(q_date());
            $('#txtPartno').val(r_partno);
            $('#txtPart').val(r_part);
            $('#txtDatea').focus();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            if (checkenda){
                alert('超過'+q_getPara('sys.modiday')+'天'+'已關帳!!');
                return;
	    		}
            _btnModi();
            $('#txtPartno').focus();
        }
        function btnPrint() {
			q_box('z_salexam.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {   /// 表身 寫入資料庫前，寫入需要欄位
            if (!as['namea']) {  //不存檔條件
                as[bbsKey[1]] = '';   /// no2 為空，不存檔
                return;
            }

            q_nowf();
            as['year'] = abbm2['year'];

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
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j

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
                width: 97%;
                float: left;
            }
            .txt.c2 {
                width: 25%;
                float: right;
            }
            .txt.c3 {
                width: 73%;
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
            font-size: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
           width: 1700px;
        }     
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewNoa'></a></td>
                <td align="center" style="width:25%"><a id='vewYear'></a></td>
                <td align="center" style="width:25%"><a id='vewPart'></a></td>
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='year'>~year</td>
                  	<td align="center" id='part'>~part</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='td1'><span> </span><a id="lblNoa" class="lbl"> </a></td>
            <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblYear" class="lbl"> </a></td>
            <td class="td4"><input id="txtYear" type="text" class="txt c1"/></td> 
            <td class='td5'><span> </span><a id="lblDatea" class="lbl"></a></td>
            <td class="td6"><input id="txtDatea" type="text" class="txt c1"/></td> 
        </tr>
        <tr>
            <td class="td1"><span> </span><a id="lblPart" class="lbl btn"></a></td>
            <td class="td2">
            	<input id="txtPartno" type="text" class="txt c2"/>
            	<input id="txtPart" type="text" class="txt c3"/>
            </td>
            <td class='td3'><input id="btnImport" type="button" style="width: auto;font-size: medium;"/></td>
            <td class='td4'><input id="checkIsall" type="checkbox" /><span> </span><a id="lblIsall"> </a></td>
        </tr>
        <tr>
            <td class="td1"><span> </span><a id="lblWorker" class="lbl"></a></td>
            <td class="td2">
            	<input id="txtWorker" type="text" class="txt c1"/><input id="txtWorkerno" type="hidden" class="txt c1"/></td>
            <td class="td3"><span> </span><a id="lblWorker2" class="lbl"></a></td>
            <td class="td4">
            	<input id="txtWorker2" type="text" class="txt c1"/></td>
        </tr>
        </table>
        </div>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                <td align="center" style="width:120px;"><a id='lblSssno_s'> </a></td>
                <td align="center" style="width:120px;"><a id='lblNamea_s'> </a></td>
                <td align="center" style="width:120px;"><a id='lblPart_s'> </a></td>
                <td align="center" style="width:120px;"><a id='lblJob_s'> </a></td>
                <td align="center" style="width:110px;"><a id='lblEfficiency_s'></a><br>(6-20)</td>
                <td align="center" style="width:110px;"><a id='lblDuty_s'></a><br>(5-15)</td>
                <td align="center" style="width:140px;"><a id='lblAb_incoo_s'> </a><br>(5-15)</td>
                <td align="center" style="width:140px;"><a id='lblAb_harcoo_s'> </a><br>(4-10)</td>
                <td align="center" style="width:140px;"><a id='lblAb_leabeh_s'> </a><br>(4-10)</td>
                <td align="center" style="width:140px;"><a id='lblAb_anadet_s'> </a><br>(4-10)</td>
                <td align="center" style="width:140px;"><a id='lblAb_worknow_s'> </a><br>(1-5)</td>
                <td align="center" style="width:110px;"><a id='lblAttitude_s'> </a><br>(1-5)</td>
                <td align="center" style="width:110px;"><a id='lblAb_innovation_s'> </a><br>(1-5)</td>
                <td align="center" style="width:120px;"><a id='lblWorkdegree_s'> </a><br>(1-5)</td>
                <td align="center" style="width:120px;"><a id='lblTotal_s'> </a></td>
                <td align="center" style="width:300px;"><a id='lblMemo_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input  id="txtSssno.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtNamea.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtPart.*" type="text" class="txt c1"/><input  id="txtPartno.*" type="hidden" class="txt c1"/></td>
                <td ><input  id="txtJob.*" type="text" class="txt c1"/><input  id="txtJobno.*" type="hidden" class="txt c1"/></td>
                <td ><input  id="txtEfficiency.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtDuty.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtAb_incoo.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtAb_harcoo.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtAb_leabeh.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtAb_anadet.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtAb_worknow.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtAttitude.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtAb_innovation.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtWorkdegree.*" type="text" class="txt num c1" /></td>
                <td ><input  id="txtTotal.*" type="text" class="txt num c1" /><input id="txtNoq.*" type="hidden" /></td>
                <td ><input  id="txtMemo.*" type="text" class="txt c1" /></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
