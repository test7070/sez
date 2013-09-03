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
            var q_name = "salvacause";
            var q_readonly = ['txtNoa','txtHr_special','txtTot_special','txtJob'];
            var bbmNum = [['txtHr_used',10,1,1],['txtHr_special',10,1,1],['txtTot_special',10,1,1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc=1;
            //ajaxPath = ""; //  execute in Root
			 aPop = new Array(['txtSssno', 'lblSss', 'sss', 'noa,namea,partno,part,id,job,jobno', 'txtSssno,txtNamea,txtPartno,txtPart,txtId,txtJob,txtJobno', 'sss_b.aspx'],
			 ['txtHtype', 'lblHtype', 'salhtype', 'noa,namea', 'txtHtype,txtHname', 'salhtype_b.aspx']);
            $(document).ready(function() {
               bbmKey = ['noa'];
	            q_brwCount();
	           //q_gt(q_name, q_content, q_sqlCount, 1)
	            //$('#txtNoa').focus
	            if(r_rank < 7)
	            	q_gt('sss', "where=^^noa='" + r_userno + "'^^", q_sqlCount, 1)
	            else
	            	q_gt(q_name, q_content, q_sqlCount, 1)
        });

            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }///  end Main()
            
            var t_tot_special=0;//存放初始'特休假剩餘天數'
			var insed=false;//判斷員工是否重覆請假
            function mainPost() {
            	q_getFormat();
            	bbmMask = [['txtDatea', r_picd],['txtBdate', r_picd],['txtEdate', r_picd],['txtBtime', '99:99'],['txtEtime', '99:99']];
				q_mask(bbmMask);
				$('#txtSssno').change(function () {
	            	if(!emp($('#txtSssno').val())){
	            		//找員工的特休假可用天數和特休假剩餘天數
			           		var t_where = "where=^^ noa ='"+$('#txtDatea').val().substr(0, 3)+"' ^^";
			           		q_gt('salvaca', t_where , 0, 0, 0, "", r_accy);
			        }
			        if(!emp($('#txtSssno').val()) && !emp($('#txtDatea').val())){
	            		//判斷員工是否重覆請假
			           		var t_where = "where=^^ datea ='"+$('#txtDatea').val()+"' and sssno='"+$('#txtSssno').val()+"' ^^";
			           		q_gt('salvacause', t_where , 0, 0, 0, "", r_accy);
			        }
	        	});
	        	
	        	$('#txtDatea').blur(function () {
	            	if(!emp($('#txtSssno').val()) && !emp($('#txtDatea').val())){
	            		//判斷員工是否重覆請假
			           		var t_where = "where=^^ datea ='"+$('#txtDatea').val()+"' and sssno='"+$('#txtSssno').val()+"' ^^";
			           		q_gt('salvacause', t_where , 0, 0, 0, "", r_accy);
			        }
	        	});
	        	
				
	        	$('#txtBdate').focus(function() {
            		q_msg( $(this), '請假日期跨月份，請申請兩張!!');
                }).blur(function () {
					if($('#txtBdate').val().substr(0,6)!=$('#txtEdate').val().substr(0,6)||$('#txtBdate').val()>$('#txtEdate').val()){
						//alert('請假日期不正確!!');
						$('#txtEdate').val($('#txtBdate').val());
					}
					q_msg();
	        	});
	        	
	        	$('#txtEdate').focus(function() {
            		q_msg( $(this), '請假日期跨月份，請申請兩張!!');
                }).blur(function () {
                	if($('#txtBdate').val().substr(0,6)!=$('#txtEdate').val().substr(0,6)||$('#txtBdate').val()>$('#txtEdate').val()){
						alert('請假日期不正確!!');
						$('#txtEdate').val($('#txtBdate').val());
					}
					q_msg();
	        	});
	        	
	        	$('#txtBtime').blur(function () {
	            	if(!emp($('#txtBtime').val()) && !emp($('#txtEtime').val())){
	            		if($('#txtBtime').val()>$('#txtEtime').val()){
	            			var time=$('#txtBtime').val()
	            			$('#txtBtime').val($('#txtEtime').val());
	            			$('#txtEtime').val(time);
	            		}
	            		var use_hr=0;
	            		if($('#txtEtime').val()>='13:30'&&$('#txtBtime').val()<='12:00'){
	            			use_hr=round(((dec($('#txtEtime').val().substr(0,2))-dec($('#txtBtime').val().substr(0,2)))*60+dec($('#txtEtime').val().substr(3,2))-dec($('#txtBtime').val().substr(3,2)))/60,1);
	            			use_hr=use_hr-1.5;//大昌休息時間從12點到13點半
	            		}else if($('#txtBtime').val()>='12:00'&&$('#txtBtime').val()<'13:30' && $('#txtEtime').val()>='13:30'){
	            			use_hr=round(((dec($('#txtEtime').val().substr(0,2))-13)*60+dec($('#txtEtime').val().substr(3,2))-30)/60,1);
	            		}else if($('#txtEtime').val()>='12:00'&&$('#txtEtime').val()<'13:30' && $('#txtBtime').val()>='12:00'){
	            			use_hr=round(((12-dec($('#txtBtime').val().substr(0,2)))*60+0-dec($('#txtBtime').val().substr(3,2)))/60,1);
	            		}else{
	            			use_hr=round(((dec($('#txtEtime').val().substr(0,2))-dec($('#txtBtime').val().substr(0,2)))*60+dec($('#txtEtime').val().substr(3,2))-dec($('#txtBtime').val().substr(3,2)))/60,1);
	            		}
	            		
	            		if($('#txtBdate').val()!=$('#txtEdate').val())
	            		{
	            			var t_date=$('#txtBdate').val();
	            			var count=0;
	            			while(t_date<=$('#txtEdate').val()){
	            				//日期加一天
								    var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2)));
								    nextdate.setDate(nextdate.getDate() +1)
								    t_date=''+(nextdate.getFullYear()-1911)+'/';
								    //月份
								    if(nextdate.getMonth()+1<10)
								    	t_date=t_date+'0'+(nextdate.getMonth()+1)+'/';
								    else
								       	t_date=t_date+(nextdate.getMonth()+1)+'/';
								    //日期
								    if(nextdate.getDate()<10)
								    	t_date=t_date+'0'+(nextdate.getDate());
								    else
								     	t_date=t_date+(nextdate.getDate());
		            			if(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==0||new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==6){
					    		  	//六日不算
					    		  }else{
					    		  	count++;
					    		  }
					    		}
	            			
	            			use_hr=use_hr*count;
	            		}
	            		
	            		$('#txtHr_used').val(use_hr);
			        }
	        	});
	        	
	        	$('#txtEtime').blur(function () {
	            	if(!emp($('#txtBtime').val()) && !emp($('#txtEtime').val())){
	            		if($('#txtBtime').val()>$('#txtEtime').val()){
	            			var time=$('#txtBtime').val()
	            			$('#txtBtime').val($('#txtEtime').val());
	            			$('#txtEtime').val(time);
	            		}
	            		var use_hr=0;
	            		if($('#txtEtime').val()>='13:30'&&$('#txtBtime').val()<='12:00'){
	            			use_hr=round(((dec($('#txtEtime').val().substr(0,2))-dec($('#txtBtime').val().substr(0,2)))*60+dec($('#txtEtime').val().substr(3,2))-dec($('#txtBtime').val().substr(3,2)))/60,1);
	            			use_hr=use_hr-1.5;//大昌休息時間從12點到13點半
	            		}else if($('#txtBtime').val()>='12:00'&&$('#txtBtime').val()<'13:30' && $('#txtEtime').val()>='13:30'){
	            			use_hr=round(((dec($('#txtEtime').val().substr(0,2))-13)*60+dec($('#txtEtime').val().substr(3,2))-30)/60,1);
	            		}else if($('#txtEtime').val()>='12:00'&&$('#txtEtime').val()<'13:30' && $('#txtBtime').val()<='12:00'){
	            			use_hr=round(((12-dec($('#txtBtime').val().substr(0,2)))*60+0-dec($('#txtBtime').val().substr(3,2)))/60,1);
	            		}else{
	            			use_hr=round(((dec($('#txtEtime').val().substr(0,2))-dec($('#txtBtime').val().substr(0,2)))*60+dec($('#txtEtime').val().substr(3,2))-dec($('#txtBtime').val().substr(3,2)))/60,1);
	            		}
	            		if($('#txtBdate').val()!=$('#txtEdate').val())
	            		{
	            			var t_date=$('#txtBdate').val();
	            			var count=0;
	            			while(t_date<=$('#txtEdate').val()){
	            				//日期加一天
								    var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2)));
								    nextdate.setDate(nextdate.getDate() +1)
								    t_date=''+(nextdate.getFullYear()-1911)+'/';
								    //月份
								    if(nextdate.getMonth()+1<10)
								    	t_date=t_date+'0'+(nextdate.getMonth()+1)+'/';
								    else
								       	t_date=t_date+(nextdate.getMonth()+1)+'/';
								    //日期
								    if(nextdate.getDate()<10)
								    	t_date=t_date+'0'+(nextdate.getDate());
								    else
								     	t_date=t_date+(nextdate.getDate());
		            			if(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==0||new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==6){
					    		  	//六日不算
					    		  }else{
					    		  	count++;
					    		  }
					    		}
	            			
	            			use_hr=use_hr*count;
	            		}
	            		$('#txtHr_used').val(use_hr);
			        }
	        	});
	        	
	        	$('#txtHr_used').change(function () {
	        		if(emp($('#txtSssno').val()))
	        		{
	        			alert('請先填寫員工編號!!');
	        			$('#txtHr_used').val('0');
	        			return;
	        		}
	        		if(emp($('#txtHtype').val()))
	        		{
	        			alert('請先填寫假別!!');
	        			$('#txtHr_used').val('0');
	        			return;
	        		}
	        		if($('#txtHname').val().indexOf('特休')>-1)
	            		q_tr('txtTot_special',t_tot_special-q_float('txtHr_used'));
	        	});
	        	
	        	$('#lblAgent').click(function () {
	            	q_box("sss_b2.aspx", 'sss', "95%", "95%", q_getMsg("popSss"));
	        	});
	        	
            }
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'sss':
                        ret = getb_ret();
                        if(q_cur > 0 && q_cur < 4){
	                        if(ret[0]!=undefined){
	                        	for (var i = 0; i < ret.length; i++) {
	                        		if($('#txtAgent').val().length>0){
		                            	var temp=$('#txtAgent').val();
		                            	$('#txtAgent').val(temp+','+ret[i].namea);
		                            }else{
		                            	$('#txtAgent').val(ret[i].namea);
		                            } 
	                        	}
	                        }
						}
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
                b_pop = '';
            }
			
			var ssspartno='';
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'authority':
		                var as = _q_appendData('authority', '', true);
		                if(as[0]!=undefined){
			                if(r_rank >=7)
			                	q_content = "";
			                else if (as.length > 0 && as[0]["pr_modi"] == "true")
			                    q_content = "where=^^partno='"+ssspartno+"'^^";
			                else
			                    q_content = "where=^^sssno='" + r_userno + "'^^";
						}
		                q_gt(q_name, q_content, q_sqlCount, 1)
		                break;
                	
                    case 'sss':
                        	var as = _q_appendData('sss', '', true);
                        	if(as[0]!=undefined){
	                        	ssspartno=as[0].partno;
	                        	q_gt('authority', "where=^^a.noa='salvacause' and a.sssno='" + r_userno + "'^^", q_sqlCount, 1)
                        	}
                        break;
                        
                   case 'salvaca':
                   		if(q_cur == 1){
                   			var as = _q_appendData("salvaca", "", true);	
                   			if(as[0]!=undefined){
                   				var salvacas = _q_appendData("salvacas", "", true);	
                   				for (var i = 0; i < salvacas.length; i++) {
                   					if(salvacas[i].sssno==$('#txtSssno').val()){
                   						$('#txtHr_special').val(salvacas[i].inday);
                   						t_tot_special=salvacas[i].total;
                   						$('#txtTot_special').val(salvacas[i].total);
                   						$('#txtHr_used').val('0.0');
                   						break;
                   					}
                   				}
                   			}
                   		}
                   		break;
                    case q_name:
                    	if(q_cur == 1){
                    		var as = _q_appendData("salvacause", "", true);	
                    		if(as[0]!=undefined){
                    			insed=true;
                    		}else{
                    			insed=false;
                    		}
                    	}
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
            
             function q_popPost(s1) {
		    	switch (s1) {
		    		case 'txtSssno':
		                if(!emp($('#txtSssno').val())){
	            		//找員工的特休假可用天數和特休假剩餘天數
			           		var t_where = "where=^^ noa ='"+$('#txtDatea').val().substr(0, 3)+"' ^^";
			           		q_gt('salvaca', t_where , 0, 0, 0, "", r_accy);
			        	}
			        	if(!emp($('#txtSssno').val()) && !emp($('#txtDatea').val())){
		            		//判斷員工是否重覆請假
				           		var t_where = "where=^^ datea ='"+$('#txtDatea').val()+"' and sssno='"+$('#txtSssno').val()+"' ^^";
				           		q_gt('salvacause', t_where , 0, 0, 0, "", r_accy);
			        	}
			        	var jobname = $('#txtJob').val();
			        	if(jobname.indexOf('副總') != -1)
				        	$('#txtSendboss').val('1');
				        else
				        	$('#txtSendboss').val('0');
		                break;
		    	}
			}

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('salvacause_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }
			
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtBdate').val(q_date());
                $('#txtEdate').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
				t_tot_special=dec($('#txtTot_special').val())+dec($('#txtHr_used').val())
                _btnModi();
                $('#txtHr_used').focus();
                $('#txtDatea').attr('readonly', true);
                $('#txtSssno').attr('readonly', true);
                $('#txtNamea').attr('readonly', true);
            }

            function btnPrint() {
 				q_box('z_salvacause.aspx'+ "?;;;;" + ";noa="+ $('#txtNoa').val(), '', "95%", "650px", q_getMsg("popPrint"));
            }

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')],['txtSssno', q_getMsg('lblSss')],['txtHname', q_getMsg('txtHtype')]]);

                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                /*if(insed) {
                    alert('該員工當天已請假!!!');
                    return;
                }*/
                
                var t_noa = trim($('#txtNoa').val());

                if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll( $('#txtDatea').val(), '/', ''));
				else
					wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if(q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
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
			<div id='dmain' style="overflow:hidden;">
				<div class="dview" id="dview" style="float: left;  width:25%;"  >
					<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
						<tr>
							<td align="center" style="width:5%"><a id='vewChk'></a></td>
							<td align="center" style="width:25%"><a id='vewDatea'></a></td>
							<td align="center" style="width:40%"><a id='vewNamea'></a></td>
						</tr>
						<tr>
							<td >
							<input id="chkBrow.*" type="checkbox" style=''/>
							</td>
							<td align="center" id='datea'>~datea</td>
							<td align="center" id='namea'>~namea</td>
						</tr>
					</table>
				</div>
				<div class='dbbm' style="width: 73%;float: left;">
					<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
						<tr>
							<td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
							<td class="td2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
							<td class="td3" ><!--<input id="btnAuto"  type="button" />--></td>
							<td class="td4"></td>
							<td class="td5" ></td>
							<td class="td6"></td>
						</tr>
						<tr>
							<td class="td1"><span> </span><a id='lblDatea' class="lbl"></a></td>
							<td class="td2"><input id="txtDatea"  type="text" class="txt c1" /></td>
							<td class="td3" ><span> </span><a id='lblBdate' class="lbl"></a></td>
							<td class="td4" colspan="2">
								<input id="txtBdate"  type="text" class="txt" style="width: 120px;"/>
								<a style="float:left;">~</a>
								<input id="txtEdate"  type="text" class="txt" style="width: 120px;"/>
							</td>
						</tr>
						<tr>
							<td class="td1" ><span> </span>	<a id='lblSss' class="lbl btn"></a></td>
							<td class="td2">
								<input id="txtSssno"  type="text"  class="txt c2"/>
								<input id="txtNamea"  type="text"  class="txt c3"/>
							</td>
							<td class="td3" ><span> </span>	<a id='lblPart' class="lbl"></a></td>
							<td class="td4">
								<input id="txtPartno"  type="text"  class="txt c2"/>
								<input id="txtPart"  type="text"  class="txt c3"/>
							</td>
							<td class="td5"><span> </span><a id='lblId' class="lbl"></a></td>
							<td class="td6"><input id="txtId"  type="text" class="txt c1" /></td>
						</tr>
						<tr>
							<td class="td1"><span> </span><a id='lblJob' class="lbl"></a></td>
							<td class="td2">
								<input id="txtJob"  type="text" class="txt c1" />
								<input id="txtJobno"  type="text" style="display:none;" />
								<input id="txtSendboss"  type="text" style="display:none;" />
							</td>
						</tr>
						<tr>
							<td class="td1" ><span> </span>	<a id='lblHtype' class="lbl btn" ></a></td>
							<td class="td2">
								<input id="txtHtype"  type="text"  class="txt c2"/>
								<input id="txtHname"  type="text"  class="txt c3"/>
							</td>
							<td class="td3" ><span> </span><a id='lblHr_special' class="lbl"></a></td>
							<td class="td4"><input id="txtHr_special"  type="text" class="txt num c1" /></td>
							<td class="td5"><span> </span><a id='lblTot_special' class="lbl"></a></td>
							<td class="td6"><input id="txtTot_special"  type="text" class="txt num c1" /></td>
						</tr>
						<tr>
							<td class="td1" ><span> </span><a id='lblBtime' class="lbl"></a></td>
							<td class="td2" colspan="2">
								<input id="txtBtime"  type="text" class="txt" style="width: 120px;"/>
								<a style="float:left;">~</a>
								<input id="txtEtime"  type="text" class="txt" style="width: 120px;"/>
							</td>
							<td class="td4"><span> </span><a id='lblHr_used' class="lbl"></a></td>
							<td class="td5"><input id="txtHr_used"  type="text" class="txt num c1"/></td>
							<td class="td6"></td>
						</tr>
						<tr>
							<td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
							<td class="td2" colspan="5"><input id="txtMemo"  type="text" class="txt c1"/></td>
						</tr>
						<tr>
							<td class="td1"><span> </span><a id='lblAgent' class="lbl btn"></a></td>
							<td class="td2" colspan="5"><input id="txtAgent"  type="text" class="txt c1"/>
							</td>
						</tr>
						<!--<tr>
							<td class="td1"><span> </span><a id='lblHbtime' class="lbl"></a></td>
							<td class="td2"><input id="txtHbtime"  type="text"  class="txt c1"/></td>
							<td class="td3"><span> </span><a id='lblHetime' class="lbl"></a></td>
							<td class="td4"><input id="txtHetime"  type="text" class="txt c1" /></td>
							<td class="td5"></td>
							<td class="td6"></td>
						</tr>
						<tr>
							<td class="td1"><span> </span><a id='lblHr_sick' class="lbl"></a></td>
							<td class="td2"><input id="txtHr_sick"  type="text" class="txt num c1"/></td>
							<td class="td3"><span> </span><a id='lblHr_person' class="lbl"></a></td>
							<td class="td4"><input id="txtHr_person"  type="text" class="txt num c1"/></td>
							<td class="td5" ></td>
							<td class="td6"></td>
						</tr>-->
			</table>
			</div>
			</div>
			<input id="q_sys" type="hidden" />
	</body>
</html>
