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
        var q_name = "carc";
        var q_readonly = ['txtNoa','txtDatea','txtWorker','txtWorker2','txtPaybno','txtAccno'];
        var q_readonlys = ['txtCarownerno','txtCarowner','txtCarno','txtCaradate','txtCaritemno','txtCaritem','txtInmoney','txtMemo','txtCarano','txtCaranoq'];
        var bbmNum = [['txtTotal',14, 0, 1]];  
        var bbsNum = [['txtOutmoney',14, 0, 1],['txtInmoney',14, 0, 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtCaritemno_', 'btnCaritem_', 'caritem', 'noa,item', 'txtCaritemno_,txtCaritem_', 'caritem_b.aspx'],
        ['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'],
         ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy+ '_' + r_cno],
        ['txtCarownerno', 'lblCarowner', 'carowner', 'noa,namea', 'txtCarownerno,txtCarowner', 'carowner_b.aspx']);

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
            bbmMask = [['txtDatea', r_picd],['txtPaydate', r_picd],['txtMon', r_picm],['txtAcdate',r_picd]];
            q_mask(bbmMask);
            bbsMask = [['txtCaradate', r_picd]];
            
            q_gt('sss', "where=^^ partno='07'^^" , 0, 0, 0, "", r_accy);

            $('#btnImport').click(function () {
            		if(emp($('#txtMon').val()))
            		{
            			alert('請先輸入單據月份');
            			return;
            		}
		            var t_where = "where=^^ mon ='"+$('#txtMon').val()+"' and (a.udate='' or a.udate is null) and (";
		            if($('#chkInsure')[0].checked==true)
		            {
		            	t_where+="caritemno='306' or ";
		            }
		            if($('#chkFuel')[0].checked==true)
		            {
		            	if($('#chkIsheetyn')[0].checked==true)
		            		t_where+="(caritemno='502' and (sheetyn='y' or sheetyn='Y')) or "; 
		            	else
		            		t_where+="(caritemno='502') or ";
		            }
		            if($('#chkLicense')[0].checked==true)
		            {
		            	if($('#chkIsheetyn')[0].checked==true)
		            		t_where+="(caritemno='501' and (sheetyn='y' or sheetyn='Y')) or "; 
		            	else
		            		t_where+="(caritemno='501') or ";
		            }
		            if($('#chkOther')[0].checked==true)
		            {
		            	// and caritemno!='201' 先拿掉等監理部借支功能完成再放進去條件
		            	t_where+="(caritemno!='306' and caritemno!='502' and caritemno!='501' and caritemno!='401' and caritemno!='001' and caritemno!='002' and caritemno!='101' and caritemno!='102' and caritemno!='105' and caritemno!='106' and caritemno!='111' and caritemno!='112' and caritemno!='202' and caritemno!='203') or ";
		            }
		            t_where+=" 1=0) ";
		            
		            if(!emp($('#txtCarownerno').val()))
		            {
		            	t_where+="and b.carownerno='"+$('#txtCarownerno').val()+"' ";
		            }
		            
		            if(!emp($('#txtCarno').val()))
		            {
		            	t_where+="and a.carno='"+$('#txtCarno').val()+"' ";
		            }
		            
		            var sssno_count=0;
		            
		            for(var i=0;i<sssnumber;i++){
		            	if($('#chkSssno'+i)[0].checked==true){
		            		if(sssno_count==0)
			            		t_where+="and (b.sssno='"+$('#chkSssno'+i).val()+"' "
			            	else
			            		t_where+="or b.sssno='"+$('#chkSssno'+i).val()+"' "
			            	sssno_count++;
		            	}
		            }
		            if(sssno_count>0)
		            	t_where+=") ";
		            
		           //金額=0的不顯示
		           	t_where+=" and a.outmoney!=0";
		            t_where+=" ^^";
			        q_gt('carc_caras', t_where , 0, 0, 0, "", r_accy);			   
			 });
		     $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtAcdate').val().substr( 0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
              });
		     $('#btnCarlender').click(function() {
		     		t_where = "noa='" + $('#txtCarownerno').val() + "'";
            		q_box("carlender.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'carLender', "95%", "650px", q_getMsg('popCarlender'));
             });
               $('#lblPaybno').click(function() {
		     		t_where = "noa='" + $('#txtPaybno').val() + "'";
            		q_box("payb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pay', "95%", "650px", q_getMsg('popPaytran'));
             });

             $('#txtAcc1').change(function () {
			 	var s1 = trim($(this).val());
			    if (s1.length > 4 && s1.indexOf('.') < 0)
			    	$(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
			    if (s1.length == 4)
			        $(this).val(s1 + '.');
			 });
 			scroll("tbbs","box",1);
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

		var sssno='';
		var sssnumber=0;
        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'holiday':
            		holiday = _q_appendData("holiday", "", true);
            		endacheck($('#txtDatea').val(),q_getPara('sys.modiday'));
            	break;
            	case 'sss':
            		var as = _q_appendData("sss", "", true);
            		sssnumber=as.length;
            		for (var i = 0; i < as.length; i++) {
            			sssno+="<input id='chkSssno"+i+"' type='checkbox' style='float: left;' value='"+as[i].noa+"' disabled='disabled'/><a class='lbl' style='float: left;'>"+as[i].noa+"</a>"
            			//sssno+=as[i].noa+';';
            		}
            		$('#xsssno').append(sssno);
            	break;
            	
            	case 'carc_caras':
            	var caras = _q_appendData("caras", "", true);
            	for (var i = 0; i < caras.length; i++) {
            		if(dec(caras[i].cost)>0)
                    	caras[i]._outmoney=caras[i].cost
                    else
                    	caras[i]._outmoney=caras[i].outmoney
            	}
            	
            	q_gridAddRow(bbsHtm, 'tbbs', 'txtCarano,txtCaranoq,txtCaradate,txtCaritemno,txtCaritem,txtOutmoney,txtMemo,txtCarno,txtCarownerno,txtCarowner'
            								, caras.length, caras, 'noa,noq,datea,caritemno,caritem,_outmoney,memo,carno,carownerno,namea', 'txtCarano');
            	var t_money = 0, t_moneys = 0;
					for ( i = 0; i < q_bbsCount; i++) {
					    t_moneys = round(q_float('txtOutmoney_'+i),0)
					    t_money += t_moneys;
					    }
					   $('#txtTotal').val(t_money);
            	break;

                case q_name: 
                	if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
        	$('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
            }            
			$('#txtPaydate').val($.trim($('#txtPaydate').val()));
                if (checkId($('#txtPaydate').val())==0){
                	alert(q_getMsg('lblPaydate')+'錯誤。');
                	return;
            }            
			$('#txtMon').val($.trim($('#txtMon').val()));
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
					alert(q_getMsg('lblMon')+'錯誤。');   
					return;
			}
			if ($('#txtAcdate').val().length==0 || !q_cd($('#txtAcdate').val())){
            	alert(q_getMsg('lblAcdate')+'錯誤。');
            	return;
            }
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
            
            var t_checkpay="";
            
            if($('#chkInsure')[0].checked==true){
            	t_checkpay+='保險費,';
            }
            if($('#chkFuel')[0].checked==true){
            	t_checkpay+='燃料費,';
            }
            if($('#chkLicense')[0].checked==true){
            	t_checkpay+='牌照稅,';
            }
            if($('#chkOther')[0].checked==true){
            	t_checkpay+='其他,';
            }
            $('#txtCheckpay').val(t_checkpay.substr(0,(t_checkpay.length-1)));

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('C' + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

	        function _btnSeek() {
	            if (q_cur > 0 && q_cur < 4)  // 1-3
	                return;
	            q_box('carc_s.aspx', q_name + '_s', "500px", "500px", q_getMsg( "popSeek"));
	        }

        function bbsAssign() {  
        	for(var j = 0; j < q_bbsCount; j++) {
           			if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           				$('#txtOutmoney_'+j).change(function () {
           					sum();
           				});
           			}
           		}
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtMon').val(q_date().substr(0,6));
            $('#txtPaydate').val(q_date());
            $('#txtAcdate').val(q_date());
            $('#txtAcc1').val('2195.16');
            $('#txtAcc2').val('代付款項-監理部');
            $('#txtAcdate').focus();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
                
            if (checkenda){
                alert('超過'+q_getPara('sys.modiday')+'天已關帳!!');
                return;
			}
                
            _btnModi();
            $('#txtAcdate').focus();            
           
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
            var t1 = 0, t_unit, t_mount, t_weight = 0,money_total=0,t_total=0;
            for (var j = 0; j < q_bbsCount; j++) {
            	t_total+=dec($('#txtOutmoney_'+j).val());
            	
            }  // j
            q_tr('txtTotal',t_total);
        }
        
        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
            if(r_rank<=7)
            	q_gt('holiday', "where=^^ noa>='"+$('#txtDatea').val()+"'^^" , 0, 0, 0, "", r_accy);
            else
            	checkenda=false;
       }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            
            if (t_para) {
		    	$('#btnImport').attr('disabled', 'disabled');
		    	for(var i=0;i<sssnumber;i++){
		    		$('#chkSssno'+i).attr('disabled', 'disabled');
		    	}
		    }else {
		    	$('#btnImport').removeAttr('disabled');
		    	for(var i=0;i<sssnumber;i++){
		    		$('#chkSssno'+i).removeAttr('disabled');
		    	}
		    }
        }

        function btnMinus(id) {
            _btnMinus(id);
            sum();
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield); 
        }
		function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
				var s2 = xmlString.split(';');
                abbm[q_recno]['accno'] = s2[0];
                abbm[q_recno]['paybno'] = s2[1];
                $('#txtAccno').val(s2[0]);
                $('#txtPaybno').val(s2[1]);
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
                alert('超過'+q_getPara('sys.modiday')+'天已關帳!!');
                return;
			}
            _btnDele();
        }

        function btnCancel() {
            _btnCancel();
        }
		function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
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
            
   		var scrollcount=1;
        function scroll(viewid,scrollid,size){
        	if(scrollcount>1)
        	$('#box_'+(scrollcount-1)).remove();
			var scroll = document.getElementById(scrollid);
			var tb2 = document.getElementById(viewid).cloneNode(true);
			var len = tb2.rows.length;
			for(var i=tb2.rows.length;i>size;i--){
		                tb2.deleteRow(size);
			}
			//tb2.rows[0].deleteCell(0);
			tb2.rows[0].cells[0].children[0].id="scrollplus"
			var bak = document.createElement("div");
			bak.id="box_"+scrollcount
			scrollcount++;
			scroll.appendChild(bak);
			bak.appendChild(tb2);
			bak.style.position = "absolute";
			bak.style.backgroundColor = "#fff";
		    bak.style.display = "block";
			bak.style.left = 0;
			bak.style.top = "0px";
			scroll.onscroll = function(){
				bak.style.top = this.scrollTop+"px";
			}
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

    </script>
    <style type="text/css">
          #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 30%;
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
                width: 68%;
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
                width: 65px;
                float: left;
            }
            .txt.c3 {
                width: 130px;
                float: left;
            }
            .txt.c4 {
                width: 25%;
                float: left;
            }
            .txt.c5 {
                width: 71%;
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
            #box{
				height:240px;
				width: 100%;
				overflow-y:auto;
				position:relative;
		}
    </style>
</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
<!--#include file="../inc/toolbar.inc"-->
    <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:30%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:30%"><a id='vewDatea'></a></td>
                <td align="center" style="width:65%"><a id='vewCheckpay'></a></td>
                <!--<td align="center"><a id='vewNoa'></a></td>-->
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='datea'>~datea</td>
                   <td align="center" id='checkpay'>~checkpay</td>
                   <!--<td align="center" id='noa'>~noa</td>-->
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float:left">
        <table class="tbbm"  id="tbbm"  border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
            <td class='td1'><span> </span><a id="lblDatea" class="lbl"></a></td>
            <td class='td2'><input id="txtDatea" type="text" class="txt c1"/></td>        	
            <td class='td3'><span> </span><a id="lblNoa" class="lbl"></a></td>
            <td class='td4'><input id="txtNoa"  type="text" class="txt c1" /></td>
            <td class='td5'></td>
       </tr>
       <tr class="tr2">
            <td class='td1'><span> </span><a id="lblAcdate" class="lbl"></a></td>
            <td class='td2'><input id="txtAcdate" type="text" class="txt c1"/></td>
            <td class='td1'><span> </span><a id="lblMon" class="lbl"></a></td>
            <td class='td2'><input id="txtMon" type="text" class="txt c1" /></td>
       </tr>
       <tr class="tr3">
            <td class='td1'><span> </span><a id="lblTggno" class="lbl btn"></a></td>
            <td class='td2'><input id="txtTggno"  type="text" class="txt c2" />
            							<input id="txtComp"  type="text" class="txt c3" />
            </td>							
            <td class='td3'><span> </span><a id="lblPaybno" class="lbl btn"></a></td>
            <td class='td4'><input id="txtPaybno"  type="text" class="txt c1" /></td>
       </tr>
       <tr class="tr4">           
			<td class='td3'><span> </span><a id="lblAcc1" class="lbl btn"></a></td>
            <td class='td4'><input id="txtAcc1"  type="text" class="txt c2" />
            	<input id="txtAcc2"  type="text" class="txt c3" />
            </td>
			<td class='td3'><span> </span></td>
            <td class='td4'><input id="btnCarlender" type="button" style="float: left;"/></td>
            <td class='td5'><input id="chkIsheetyn" type="checkbox" style="float: left;"/><a id="lblIsheetyn" class="lbl" style="float: left;"></a></td>
       </tr>
       <tr class="tr5">           
			<td class='td1'><span> </span><a id="lblCarowner" class="lbl btn"></a></td>
            <td class='td2'>
            	<input id="txtCarownerno" type="text" class="txt c2"/>
            	<input id="txtCarowner" type="text" class="txt c3"/>
            </td>
            <td class='td3'><span> </span><a id="lblChkimport" class="lbl"></a></td>
            <td class='td4' colspan='2'>
            	<input id="chkInsure" type="checkbox" style="float: left;"/><a id="lblInsure" class="lbl" style="float: left;"></a>
            	<input id="chkFuel" type="checkbox" style="float: left;"/><a id="lblFuel" class="lbl" style="float: left;"></a>
            	<input id="chkLicense" type="checkbox" style="float: left;"/><a id="lblLicense" class="lbl" style="float: left;"></a>
            	<input id="chkOther" type="checkbox" style="float: left;"/><a id="lblOther" class="lbl" style="float: left;"></a>
            	<input id="txtCheckpay" type="hidden"></td>
            </td><!--保險費、燃料費、牌照稅、其他-->
       </tr>
       <tr class="tr6">           
			<td class='td1'><span> </span><a id="lblCarno" class="lbl"></a></td>
            <td class='td2'>
            	<input id="txtCarno" type="text" class="txt c1"/>
            </td>
            <td class='td3' ><input id="btnImport" type="button" style="float: left;"/></td>
            <td class='td4' colspan='2' id="xsssno">
            	<!--<input id="chkSssno1" type="checkbox" style="float: left;"/><a id="lblSssno1" class="lbl" style="float: left;"></a>
            	<input id="chkSssno2" type="checkbox" style="float: left;"/><a id="lblSssno2" class="lbl" style="float: left;"></a>
            	<input id="chkSssno3" type="checkbox" style="float: left;"/><a id="lblSssno3" class="lbl" style="float: left;"></a>-->
            </td>
       </tr>
       <tr class="tr6">           
			<td class='td1'><span> </span><a id="lblPaydate" class="lbl"></a></td>
            <td class='td2'>
            	<input id="txtPaydate" type="text" class="txt c1"/>
            </td>
         	<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
			<td><input id="txtAccno"  type="text"  class="txt c1"/></td>
       </tr>
       <tr class="tr7">
       		<td class="td1"><span> </span><a id="lblTotal" class="lbl"> </a></td>
			<td class="td2"><input id="txtTotal"  type="text"  class="txt num c1"/></td>
       </tr>
        <tr class="tr8">           
			<td class='td1'><span> </span><a id="lblWorker" class="lbl"></a></td>
            <td class='td2'><input id="txtWorker"  type="text" class="txt c1" /></td>
            <td class='td3'><span> </span><a id="lblWorker2" class="lbl"></a></td>
            <td class='td4'><input id="txtWorker2" type="text" class="txt c1"></td>
       </tr>        
        <tr class="tr9">
            <td class='td1'><span> </span><a id="lblMemo" class="lbl"></a></td>
            <td class='td2' colspan='4'><input id="txtMemo"  type="text"  class="txt c1"/></td>
        </tr> 
        </table>
        </div>
		</div>
		<div id="box">
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width:1%"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                <td align="center" style="width:8%"><a id='lblCarowners'></a></td>
                <td align="center" style="width:8%"><a id='lblCarnos'></a></td>
                <td align="center" style="width:8%"><a id='lblCaradates'></a></td>
                <td align="center" style="width:10%"><a id='lblCaritems'></a></td>
                <td align="center" style="width:10%"><a id='lblOutmoneys'></a></td>
                <td align="center" ><a id='lblMemos'></a></td>
                <td align="center" style="width:12%"><a id='lblCaranos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td >
                	<input id="txtCarownerno.*" type="text" class="txt c5"/>
					<input id="txtCarowner.*" type="text" class="txt c1"/>
                </td>
                <td ><input id="txtCarno.*" type="text" class="txt c1"/></td>
                <td ><input  id="txtCaradate.*" type="text" class="txt c1"/></td>
                <td >
                	<input id="txtCaritemno.*" type="text" class="txt c5"/>
					<input class="btn"  id="btnCaritem.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					<input id="txtCaritem.*" type="text" class="txt c1"/>
                </td>
                <td ><input id="txtOutmoney.*" type="text" class="txt num c1"/></td>
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
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
