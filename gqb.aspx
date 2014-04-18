<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "gqb";
            var q_readonly = ['txtWorker','txtWorker2','txtTdate','txtEnda','txtTbankno','txtTbank','txtTacc1','txtEndaccno','txtAcc1','txtBkaccno'];
            var bbmNum = [['txtMoney', 10, 0]];
            var bbmMask = [['txtDatea', '999/99/99'], ['txtIndate', '999/99/99'], ['txtTdate', '999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 15;
            q_xchg = 1;
            
            aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtTcompno', 'lblTcomp', 'view_cust_tgg', 'noa,comp', '0txtTcompno,txtTcomp', 'view_cust_tgg_b.aspx']
            , ['txtCompno', 'lblComp', 'view_cust_tgg', 'noa,comp', '0txtCompno,txtComp', 'view_cust_tgg_b.aspx']
            , ['txtBankno', 'lblBank', 'bank', 'noa,bank', 'txtBankno,txtBank', 'bank_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_desc = 1;
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }
            function mainPost() {
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('gqb.typea'));
                $('#txtDatea').datepicker();
                $('#txtIndate').datepicker();
                
                $('#txtMoney').focus(function() {
                	$('#ui-datepicker-title').hide();
                	$('.ui-datepicker').hide();
                });
                
                $("#cmbTypea").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                $('#txtGqbno').change(function() {
                	//判斷支票編號是否重複
                	if($.trim($(this).val()).length>0){
                		var t_where = "where=^^ checkno = '" + $(this).val() + "' ^^";
                    	q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_change1", r_accy);
                	}
                });
                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + r_accy + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                });
            }
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	if(t_name.substring(0,10)=='gqb_btnOk1'){
                    		//存檔時  支票號碼   先檢查view_gqb_chk,再檢查GQB
                    		var t_checkno = t_name.split('_')[2];  
                    		var t_noa =  t_name.split('_')[3];               		
                    		var as = _q_appendData("view_gqb_chk", "", true);
                    		if(as[0]!=undefined){
                    			var t_isExist = false,t_msg = '';
                    			for(var i in as){
                    				if(as[i]['tablea']!=undefined ){
                    					t_isExist = true;
                    					if( as[i]['noa'] != t_noa){
                    						t_msg += (t_msg.length==0?'票據已存在，請由該作業修改:':'')+String.fromCharCode(13) + '【'+as[i]['title']+as[i]['noa']+'】'+as[i]['checkno'];
                    					}
                    				}
                    			}
                    			if(t_isExist && t_msg.length==0){
                    				save();
                    			}
                    			else if(t_isExist && t_msg.length>0){
                    				alert('請由以下單據修改。'+String.fromCharCode(13)+t_msg);
                    				Unlock();
                    			}else if(t_msg.length>0){
                    				alert(t_msg);
                    				Unlock();
                    			}else{
                    				//檢查GQB
	                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
	            					q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOk2_"+t_noa, r_accy);
                    			}
                    		}else{
                				//檢查GQB
                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
            					q_gt('gqb', t_where, 0, 0, 0, "gqb_btnOk2_"+t_noa, r_accy);
                    		}
                    	}else if(t_name.substring(0,10)=='gqb_btnOk2'){
                    		//存檔時   支票號碼檢查
                    		//檢查GQB
                    		var t_noa =  t_name.split('_')[2];  
                    		var as = _q_appendData("gqb", "", true);
                    		if(as[0]!=undefined){
                    			for(var i in as)
                    				if(as[i]['noa']!=undefined && as[i]['noa']!=t_noa){
                    					alert('支票【'+as[i]['gqbno']+'】已存在');
                    					Unlock();
                    					return;
                    				}	
                    			Unlock();
                    			save();
                    		}else{
                    			save();
                    		}
                    	}else if(t_name.substring(0,11)=='gqb_change1'){
                    		//先檢查view_gqb_chk,再檢查GQB
                    		var t_checkno = t_name.split('_')[2];  
                    		var t_noa =  t_name.split('_')[3];           
                    		var as = _q_appendData("view_gqb_chk", "", true);
                    		if(as[0]!=undefined){
                    			var t_isExist = false,t_msg = '';
                    			for(var i in as){
                    				if(as[i]['tablea']!=undefined ){
                    					t_isExist = true;
                    					if( as[i]['noa'] != t_noa){
                    						t_msg += (t_msg.length==0?'票據已存在，請由該作業修改:':'')+String.fromCharCode(13) + '【'+as[i]['title']+as[i]['noa']+'】'+as[i]['checkno'];
                    					}
                    				}
                    			}
                    			if(t_isExist && t_msg.length==0){
                    				Unlock();
                    			}else if(t_isExist && t_msg.length>0){
                    				alert('請由以下單據修改。'+String.fromCharCode(13)+t_msg);
                    				Unlock();
                    			}else if(t_msg.length>0){
                    				alert(t_msg);
                    				Unlock();
                    			}else{
                    				//檢查GQB
	                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
	            					q_gt('gqb', t_where, 0, 0, 0, "gqb_change2_"+t_noa, r_accy);
                    			}
                    		}else{
                				//檢查GQB
                				var t_checkno = t_name.split('_')[1]; 
                				var t_where = "where=^^ gqbno = '" + t_checkno + "' ^^";
            					q_gt('gqb', t_where, 0, 0, 0, "gqb_change2_"+t_noa, r_accy);
                    		}
                    	}else if(t_name.substring(0,11)=='gqb_change2'){
                    		//檢查GQB
                    		var t_noa =  t_name.split('_')[2];   
                    		var as = _q_appendData("gqb", "", true);
                    		if(as[0]!=undefined){
                    			for(var i in as)
                    				if(as[i]['noa']!=undefined && as[i]['noa']!=t_noa)
                    					alert('支票【'+as[i]['gqbno']+'】已存在');
                    		}
                    		Unlock();
                    	}else if(t_name.substring(0,11)=='gqb_status1'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var t_checkno = t_name.split('_')[3];               		
                    		var as = _q_appendData("chk2s", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+t_checkno+'】已託收禁止修改，託收單號【'+as[0].noa+'】');
                    			Unlock(1);
                    		}
                    		else{
                    			var t_where = " where=^^ checkno='"+t_checkno+"'^^";
            					q_gt('ufs', t_where, 0, 0, 0, "gqb_status2_"+t_sel+"_"+t_checkno, r_accy);
                    		}
                    	}else if(t_name.substring(0,11)=='gqb_status2'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var t_checkno = t_name.split('_')[3];               		
                    		var as = _q_appendData("ufs", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+t_checkno+'】已兌現禁止修改，兌現單號【'+as[0].noa+'】');
                    			Unlock(1);
                    		}
                    		else{
                    			checkGqbStatus_btnModi(t_sel-1);
                    		}
                    	}else if(t_name.substring(0,11)=='gqb_statusA'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var t_checkno = t_name.split('_')[3];               		
                    		var as = _q_appendData("chk2s", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+t_checkno+'】已託收禁止刪除，託收單號【'+as[0].noa+'】');
                    			Unlock(1);
                    		}
                    		else{
                    			var t_where = " where=^^ checkno='"+t_checkno+"'^^";
            					q_gt('ufs', t_where, 0, 0, 0, "gqb_statusB_"+t_sel+"_"+t_checkno, r_accy);
                    		}
                    	}else if(t_name.substring(0,11)=='gqb_statusB'){
                    		//檢查GQB
                    		var t_sel = parseFloat(t_name.split('_')[2]);
                    		var t_checkno = t_name.split('_')[3];               		
                    		var as = _q_appendData("ufs", "", true);
                    		if(as[0]!=undefined){
                    			alert('支票【'+t_checkno+'】已兌現禁止刪除，兌現單號【'+as[0].noa+'】');
                    			Unlock(1);
                    		}
                    		else{
                    			checkGqbStatus_btnDele(t_sel-1);
                    		}
                    	}
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('gqb_s.aspx', q_name + '_s', "520px", "600px", q_getMsg("popSeek"));
            }

            function btnIns() {
                var t_curgqbno = $('#txtGqbno').val();
                _btnIns();
                var patt = new RegExp(/[A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/);
                var n = 0;
                if (t_curgqbno.length = 9 && patt.test(t_curgqbno)) {
                    n = "" + (parseInt(t_curgqbno.substring(2, 9)) + 1);
                    for (var i = 7 - n.length; i > 0; i--)
                        n = "0" + n;
                    $('#txtGqbno').val(t_curgqbno.substring(0, 2) + n);
                }
                $('#txtGqbno').focus();
            }
			
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
               if (q_chkClose())
             		    return;
				_btnModi();
            	$('#txtGqbno').focus();
            }
            function q_modif(){
            	Lock(1,{opacity:0});
            	checkGqbStatus_btnModi(0);
			}
			function checkGqbStatus_btnModi(n){
            	if(n<0){
            		q_modif2();
            		Unlock(1);
            	}else{
            		var t_checkno = $.trim($('#txtGqbno').val());
            		if(t_checkno.length>0){
            			var t_where = " where=^^ checkno='"+t_checkno+"'^^";
            			q_gt('chk2s', t_where, 0, 0, 0, "gqb_status1_"+n+"_"+t_checkno, r_accy);
            		}else{
            			checkGqbStatus_btnModi(n-1)
            		}
            	}
            }
            function checkGqbStatus_btnDele(n){
            	if(n<0){
            		q_delef2();          		 
            		Unlock(1);
            	}else{
            		var t_checkno = $.trim($('#txtGqbno').val());
            		if(t_checkno.length>0){
            			var t_where = " where=^^ checkno='"+t_checkno+"'^^";
            			q_gt('chk2s', t_where, 0, 0, 0, "gqb_statusA_"+n+"_"+t_checkno, r_accy);
            		}else{
            			checkGqbStatus_btnDele(n-1)
            		}
            	}
            }
            function btnPrint() {
                q_box('z_gqbp.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtGqbno').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function btnOk() {
            	Lock();
                if ($('#txtIndate').val().length == 0 || !q_cd($('#txtIndate').val())) {
                    alert(q_getMsg('lblIndate') + '錯誤。');
                    Unlock();
                    return;
                }
                if (!q_cd($('#txtTdate').val())) {
                    alert(q_getMsg('lblTdate') + '錯誤。');
                    Unlock();
                    return;
                }

				if($.trim($('#txtGqbno').val()).length>0){
        			var t_noa = $('#txtNoa').val();
    				var t_checkno = $('#txtGqbno').val() ;   	
        			var t_where = "where=^^ checkno = '" + t_checkno + "' ^^";
        			q_gt('view_gqb_chk', t_where, 0, 0, 0, "gqb_btnOk1_"+t_checkno+"_"+ t_noa, r_accy);
        		}else{
        			alert("請輸入票據號碼");
        			Unlock();
        			$('#txtGqbno').focus();
        		}
            }
            function save(){
            	if(q_cur ==1){
	            	$('#txtWorker').val(r_name);
	            }else if(q_cur ==2){
	            	$('#txtWorker2').val(r_name);
	            }else{
	            	alert("error: btnok!")
	            }
            	var t_date = trim($('#txtIndate').val());
                var tt_gqbno = trim($('#txtGqbno').val());
                var t_noa = trim($('#txtNoa').val());

                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(t_date.replace(/\//g, '') + (9 - dec($('#cmbTypea').val())) + (tt_gqbno.length > 4 ? tt_gqbno.substring(0, 2) + tt_gqbno.substring(tt_gqbno.length - 3, 3) : tt_gqbno), '/', ''));
                else
                    wrServer(t_noa);
            }          

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                var s2 = xmlString.split(';');
                abbm[q_recno]['noa'] = s2[0];
                abbm[q_recno]['accno'] = s2[1];
                $('#txtAccno').val(s2[0]);
                Unlock();
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
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
			function q_delef(){
                Lock(1,{opacity:0});
            	checkGqbStatus_btnDele(0);
			}
            function btnDele() {
            	if (q_chkClose())
             		    return;
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
                width: 950px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 950px;
                /*margin: -1px;        
                border: 1px black solid;*/
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
                width: 10%;
            }
            .tbbm .tdZ {
                width: 1%;
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
                width: 100%;
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
						<td style="width: 20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width: 120px; color:black;"><a id='vewGqbno'> </a></td>
						<td style="width: 100px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width: 100px; color:black;"><a id='vewIndate'> </a></td>
						<td style="width: 60px; color:black;"><a id='vewTypea'> </a></td>
						<td style="width: 150px; color:black;"><a id='vewComp'> </a></td>
						<td style="width: 80px; color:black;"><a id='vewMoney'> </a></td>
						<td style="width: 100px; color:black;"><a id='vewTdate'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='gqbno' style="text-align: center;">~gqbno</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='indate' style="text-align: center;">~indate</td>
						<td id='typea=cmbTypea' style="text-align: center;">~typea=cmbTypea</td>
						<td id='comp tcomp' style="text-align: left;">~comp ~tcomp</td>
						<td id='money,0,1' style="text-align: right;">~money,0,1</td>
						<td id='tdate' style="text-align: center;">~tdate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class='tdZ'> </td>
					</tr>
					<tr>
						<td><a id="lblGqb"  style="color: #104E8B ;font-weight:bolder;font-size: 18px; text-align: left;"></a></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblGqbno' class="lbl"></a></td>
						<td colspan="2">
							<input id="txtGqbno"  type="text"  class="txt c1"/>
							<input id="txtNoa"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAccount' class="lbl"> </a></td>
						<td colspan="2"><input id="txtAccount" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td colspan="">
							<input id="txtCno" type="text" style="float:left; width:30%;"/>
							<input id="txtAcomp" type="text" style="float:left; width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBank" class="lbl btn" > </a></td>
						<td colspan="2">
							<input id="txtBankno" type="text" style="float:left; width:40%;"/>
							<input id="txtBank" type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td colspan="2"><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblIndate' class="lbl"> </a></td>
						<td><input id="txtIndate"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td colspan="2"><input id="txtMoney"  type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTcomp" class="lbl btn" > </a></td>
						<td colspan="3">
							<input id="txtTcompno"  type="text" class="txt" style="width:30%;" />
							<input id="txtTcomp"  type="text" class="txt" style="width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblComp" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCompno"  type="text" class="txt" style="width:30%;"/>
							<input id="txtComp"  type="text" class="txt" style="width:70%;"/>
						</td>
					</tr>
					<tr> 
						<td colspan="5"><a id="lblGqbs" style="color: #104E8B ;font-weight:bolder;font-size: 18px; text-align: left;"></a></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTdate' class="lbl"> </a></td>
						<td><input id="txtTdate" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblEnda' class="lbl"> </a></td>
						<td><input id="txtEnda"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTbank" class="lbl" > </a></td>
						<td colspan="2">
							<input id="txtTbankno"  type="text" style="float:left; width:30%;" />
							<input id="txtTbank"  type="text" style="float:left; width:70%;" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblUsage" class="lbl"> </a></td>
						<td colspan="4"><input id="txtUsage"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="4">						
							<textarea id="txtMemo"  rows='5' cols='10' style="width:100%; height: 50px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTacc1' class="lbl"> </a></td>
						<td colspan="2"><input id="txtTacc1"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblEndaccno' class="lbl"> </a></td>
						<td><input id="txtEndaccno"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcc1' class="lbl"> </a></td>
						<td colspan="2"><input id="txtAcc1"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblBkaccno' class="lbl"> </a></td>
						<td><input id="txtBkaccno"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
