<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			q_tables = 't';
			var q_name = "tranvcce";
			var q_readonly = ['txtNoa','txtWorker', 'txtWorker2'];
			var q_readonlys = ['txtOrdeno','txtNo2'];
			var q_readonlyt = [];
			var bbmNum = new Array();
			var bbmMask = new Array(['txtDatea', '999/99/99'],['txtTimea', '99:99'],['textBdate','999/99/99'],['textEdate','999/99/99']);
			var bbsNum = new Array();
			var bbsMask = new Array();
			var bbtNum  = new Array(); 
			var bbtMask = new Array();
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_alias = '';
			q_desc = 1;
			//q_xchg = 1;
			brwCount2 = 7;
			aPop = new Array(['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
				,['txtAddrno_', 'btnAddr_', 'addr', 'noa,addr', 'txtAddrno_,txtAddr_', 'addr_b.aspx']
				,['txtAddrno2_', 'btnAddr2_', 'addr', 'noa,addr', 'txtAddrno2_,txtAddr2_', 'addr_b.aspx']
				,['txtCarno_', 'btnCarno_', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx']
				,['txtDriverno_', 'btnDriver_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx']);

			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
			}
			
			$(document).ready(function() {
				var t_where = '';
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
				
			}

			function mainPost() {
				q_mask(bbmMask);
				$('#textBdate').datepicker();
				$('#textEdate').datepicker();
				
				
				var t_type = q_getPara('trans.typea').split(',');
				for(var i=0;i<t_type.length;i++){
					$('#listTypea').append('<option value="'+t_type[i]+'"></option>');
				}
				var t_unit = q_getPara('trans.unit').split(',');
				for(var i=0;i<t_unit.length;i++){
					$('#listUnit').append('<option value="'+t_unit[i]+'"></option>');
				}
				var t_unit2 = q_getPara('trans.unit2').split(',');
				for(var i=0;i<t_unit2.length;i++){
					$('#listUnit2').append('<option value="'+t_unit2[i]+'"></option>');
				}
				
				$('#btnOrde').click(function(e){
					var t_where = "chk3!=1 and not exists(select * from view_tranvcces where (a.noa=ordeno and a.noq=no2 and (select SUM(uweight)from view_tranvcces where ordeno=a.noa)=a.weight))";
	                q_box("tranordejr_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'tranorde_tranvcce', "95%", "650px");
                });
                
                $('#btnImport').click(function() {
                    $('#divImport').toggle();
                    $('#textBdate').focus();
                });
                $('#btnCancel_import').click(function() {
                    $('#divImport').toggle();
                });
                $('#btnImport_trans').click(function() {
                   if(q_cur != 1 && q_cur != 2){
                		var t_key = q_getPara('sys.key_trans');
                   		var t_bdate = $('#textBdate').val();
                   		var t_edate = $('#textEdate').val();
                   		t_key = (t_key.length==0?'BA':t_key);//一定要有值
                   		q_func('qtxt.query.tranvcce2tran_es', 'tran.txt,tranvccejr2tranjr,' + encodeURI(t_key) + ';'+ encodeURI(t_bdate) + ';'+ encodeURI(t_edate));
                	}
                });
			}
            
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                    	continue;
                	$('#txtCarno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCarno_'+n).click();
                    });
                    $('#txtDriverno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnDriver_'+n).click();
                    });
                    $('#txtProductno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnProduct_'+n).click();
                    });
                    $('#txtAddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddr_'+n).click();
                    });
                    $('#txtAddrno2_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddr2_'+n).click();
                    });
                    $('#txtMount_' + i).change(function(e) {
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        refreshWV(n);
                    });
                    $('#txtLengthb_' + i).change(function(e) {
                        sum();
                    });
                    $('#txtWidth_' + i).change(function(e) {
                        sum();
                    });
                    $('#txtHeight_' + i).change(function(e) {
                        sum();
                    });
				}
				_bbsAssign();
				$('#tbbs').find('tr.data').children().hover(function(e){
					$(this).parent().css('background','#F2F5A9');
				},function(e){
					$(this).parent().css('background','#cad3ff');
				});
				refreshBbs();
			}
			function refreshWV(n){
				var t_productno = $.trim($('#txtProductno_'+n).val());
				if(t_productno.length==0){
					$('#txtWeight_'+n).val(0);
					$('#txtVolume_'+n).val(0);
				}else{
					q_gt('ucc', "where=^^noa='"+t_productno+"'^^", 0, 0, 0, JSON.stringify({action:"getUcc",n:n}));
				}
			}
			
			function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if($('#btnMinut__' + i).hasClass('isAssign'))
                    	continue;
                }
                _bbtAssign();
				$('#tbbt').find('tr.data').children().hover(function(e){
					$(this).parent().css('background','#F2F5A9');
				},function(e){
					$(this).parent().css('background','pink');
				});
				refreshBbs();
            }

			function bbsSave(as) {
				if (!as['addrno'] && !as['addr']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}
			function bbtSave(as) {
				if (!as['addrno'] && !as['lat']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}
			function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'tranorde_tranvcce':
                		if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
								return;
								ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtOrdeno,txtNo2,txtTime1,txtTime2,txtCustno,txtCust,txtConn,txtProductno,txtProduct,txtWeight,txtUweight,txtTotal,txtTotal2,txtAddrno,txtAddr,txtMemo', b_ret.length, b_ret, 
								'noa,noq,date1,date2,addrno2,addr2,conn,productno,product,mount,weight,price,money,addrno,addr,memo', 'txtProductno,txtProduct,txtSpec');
							}
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop='';
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	try{
                    		var t_para = JSON.parse(t_name);
                    		if(t_para.action=="getUcc"){
                    			var n = t_para.n;
                    			as = _q_appendData("ucc", "", true);
                    			if(as[0]!=undefined){
                    				$('#txtWeight_'+n).val(round(q_mul(q_float('txtMount_'+n),parseFloat(as[0].uweight)),3));
                    				$('#txtVolume_'+n).val(round(q_mul(q_float('txtMount_'+n),parseFloat(as[0].stkmount)),0));
                    			}else{
                    				$('#txtWeight_'+n).val(0);
                    				$('#txtVolume_'+n).val(0);
                    			}
                    		}else {
							}
							sum();
                		}catch(e){
                    		Unlock(1);
                    	}
                        break;
                }
            }

		
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('tranvcce_js_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtDatea').val(q_date());
				$('#chkEnda').prop('checked',false);
				$('#txtDatea').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}

			function btnPrint() {
				q_box('z_trans_wh.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({
		                    form : 'tranvcce_wh'
		                    ,noa : trim($('#txtNoa').val())
		                }) + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);
			}

			function btnOk() {
				$('#txtDatea').val($.trim($('#txtDatea').val()));
				if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
                
				sum();
				if(q_cur ==1){
					$('#txtWorker').val(r_name);
				}else if(q_cur ==2){
					$('#txtWorker2').val(r_name);
				}else{
					alert("error: btnok!");
				}
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranvcce') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbs();
				
			}
			function refreshBbs(){
				switch(q_getPara('sys.project').toUpperCase()){
					default:
						break;
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#txtDatea').datepicker('destroy');
					$('#btnOrde').attr('disabled','disabled');
					$('#btnImport_trans').removeAttr('disabled');
				}else{
					$('#txtDatea').datepicker();
					$('#btnOrde').removeAttr('disabled');
					$('#btnImport_trans').attr('disabled','disabled');
				}
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
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.tranvcce2tran_es':
            			var as = _q_appendData("tmp0", "", true, true);
                        alert(as[0].msg);
            			break;
					default:
						break;
				}
			}
			function q_popPost(id) {
				switch(id){
					case 'txtProductno_':
						var n = b_seq;
						refreshWV(n);
						break;
					default:
						break;
				}
			}
			
		</script>
		
		<style type="text/css">
			#dmain {
				overflow: auto;
				width: 1600px;
			}
			.dview {
				float: left;
				width: 300px;
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
				width: 600px;
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
				width: 12%;
			}
			.tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
				background-color: #FFEC8B;
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
			.dbbs {
				width: 1700px;
			}
			.dbbt {
				width: 2000px;
			}
			.tbbs a {
				font-size: medium;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.num {
				text-align: right;
			}
			select {
				font-size: medium;
			}
			
          /*  #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }*/
		</style>
	</head>
	<body 
	ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="divImport" style="position:absolute; top:250px; left:600px; display:none; width:400px; height:200px; background-color: #cad3ff; border: 5px solid gray;">
			<table style="width:100%;">
				<tr style="height:1px;">
					<td style="width:150px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a style="float:right; color: blue; font-size: medium;">派車日期</a></td>
					<td colspan="4">
					<input id="textBdate"  type="text" style="float:left; width:100px; font-size: medium;"/>
					<span style="float:left;display:black;height:100%;width:30px;">~</span>
					<input id="textEdate"  type="text" style="float:left; width:100px; font-size: medium;"/>
					</td>
				</tr>
				
				<tr style="height:35px;">
					<td> </td>
					<td><input id="btnImport_trans" type="button" value="匯入"/></td>
					<td></td>
					<td></td>
					<td><input id="btnCancel_import" type="button" value="關閉"/></td>
				</tr>
			</table>
		</div>
		
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a>日期</a></td>
						<td align="center" style="width:150px; color:black;"><a>電腦編號</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox"/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='noa' style="text-align: center;">~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input type="text" id="txtNoa" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea_js" class="lbl">日期</a></td>
						<td><input type="text" id="txtDatea" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="6">
							<textarea id="txtMemo" class="txt c1" style="height:75px;"> </textarea>
						</td>
					</tr>

					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
						<td> </td>
						<td><input id="btnOrde" type="button" value="訂單匯入" style="width:100%;"/></td>
						<td><input id="btnImport" type="button" value="匯至出車" style="width:100%;"/></td>
					</tr>
				</table>
			</div>
			<img id="img" crossorigin="anonymous" style="float:left;display:none;"/> 
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:90px"><a>出車日期</a></td>
					<td align="center" style="width:90px"><a>進場日期</a></td>
					<td align="center" style="width:150px"><a>常態事業單位</a></td>
					<td align="center" style="width:180px"><a>廢棄物</a></td>
					<td align="center" style="width:120px"><a>事業噸數</a></td>
					<td align="center" style="width:120px"><a>處理廠噸數</a></td>
					<td align="center" style="width:90px"><a>處理單價</a></td>
					<td align="center" style="width:90px"><a>金額</a></td>
					<td align="center" style="width:220px"><a>聯單編號</a></td>
					<td align="center" style="width:100px"><a>出車車號</a></td>
					<td align="center" style="width:150px"><a>處理廠</a></td>
					<td align="center" style="width:220px"><a>訂單</a></td>
					<td align="center" style="width:250px"><a>備註</a></td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input type="text" id="txtTime1.*" style="width:95%;"/></td>
					<td><input type="text" id="txtTime2.*" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtCustno.*" style="float:left;width:40%;" />
						<input type="text" id="txtCust.*" style="float:left;width:45%;"/>
						<input type="button" id="btnCust.*" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtProductno.*" style="float:left;width:40%;"/>
						<input type="text" id="txtProduct.*" style="float:left;width:53%;"/>
					</td>
					<td><input type="text" id="txtWeight.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtUweight.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTotal.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTotal2.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtMemo2.*" style="width:95%;"/></td>
					<td><input type="text" id="txtCarno.*" style="width:95%;"/>
						<input type="text" id="txtDriverno.*" style="display:none;"/>
						<input type="text" id="txtDriver.*" style="display:none;"/>
						<input type="button" id="btnCarno.*" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtAddrno.*" style="float:left;width:40%;"/>
						<input type="text" id="txtAddr.*" style="float:left;width:50%;"/>
						<input type="button" id="btnAddr.*" style="display:none;"/>
					</td>
					<td>
						<input type="text" id="txtOrdeno.*" style="float:left;width:70%;"/>
						<input type="text" id="txtNo2.*" style="float:left;width:20%;"/>
					</td>
					<td><input type="text" id="txtMemo.*" style="width:95%;" /></td>
				</tr>
			</table>
		</div>
		<datalist id="listUnit"> </datalist>
		<datalist id="listUnit2"> </datalist>
		<datalist id="listTypea"> </datalist>
		<div class='dbbt' style="display:none;">
			<table id="tbbt" class='tbbt'>
				<tr style="color:white; background:#003366;">
					<td align="center" style="width:25px"><input class="btn"  id="btnPlut" type="button" value='+' style="font-weight: bold;display:noxne;"  /></td>
					<td align="center" style="width:20px;"> </td>
				</tr>
				<tr class="data" style='background:pink;'>
					<td align="center">
						<input class="btn"  id="btnMinut..*" type="button" value='-' style=" font-weight: bold; display:noxne;" />
						<input type="text" id="txtNoq..*" style="display:none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
