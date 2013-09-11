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
		var q_name="signform";
		var q_readonly = [];
		var bbmNum = [];  
		var bbmMask = []; 
		q_sqlCount = 6; brwCount = 6; brwList =[] ; brwNowPage = 0 ; brwKey = 'noa';
		//ajaxPath = ""; //  execute in Root
		aPop = new Array(['txtPartno', 'lblPart','part','noa,part', 'txtPartno,txtPart','part_b.aspx'],
					['txtCheckerno', 'lblChecker','sss','noa,namea,email', 'txtCheckerno,txtChecker,txtMailchecker','sss_b.aspx'],
					['txtApprovemano', 'lblApprovema','sss','noa,namea,email', 'txtApprovemano,txtApprovema,txtMailapprovema','sss_b.aspx'],
					['txtApprovefino', 'lblApprovefi','sss','noa,namea,email', 'txtApprovefino,txtApprovefi,txtMailapprovefi','sss_b.aspx'],
					['txtApprovegmno', 'lblApprovegm','sss','noa,namea,email', 'txtApprovegmno,txtApprovegm,txtMailapprovegm','sss_b.aspx'],
					['txtApprovebsno', 'lblApprovebs','sss','noa,namea,email', 'txtApprovebsno,txtApprovebs,txtMailapprovebs','sss_b.aspx']);
		$(document).ready(function () {
			bbmKey = ['noa'];
			q_brwCount();
			q_gt(q_name, q_content, q_sqlCount, 1);
			$('#txtNoa').focus;
		});

		//////////////////   end Ready
       function main() {
			if (dataErr)   
			{
				dataErr = false;
				return;
			}
			mainForm(0); // 1=Last  0=Top
		}  ///  end Main()

			function currentData() {
			}
			currentData.prototype = {
				data : [],
				/*排除的欄位,新增時不複製*/
				exclude : [],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isExclude = false;
						for (var j in curData.exclude) {
							if (fbbm[i] == curData.exclude[j]) {
								isExclude = true;
								break;
							}
						}
						if (!isExclude) {
							curData.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in curData.data) {
						$('#' + curData.data[i].field).val(curData.data[i].value);
					}
				}
			};
			var curData = new currentData();

		function mainPost() { 
			q_mask(bbmMask);
			q_gt('part', '', 0, 0, 0, "");
			change_cur();
			//q_cmbParse("cmbSingcon", q_getPara('sign.process'));
			$("#combPartno").change(function() {
				combtodo($(this));
			});
			$("#combPartno2").change(function() {
				combtodo($(this));
			});
		}
		function combtodo(do_object){
			if((q_cur == 1 || q_cur == 2) && do_object.val() != ''){
				t_where = '';
				choice_check = do_object.val();
				choice_check = choice_check.split('-');
				if(choice_check[0] != 'All'){
					t_where = "partno='"+choice_check[0]+"'";
				}
				if(choice_check[1] == 'All'){
					if(choice_check[0] != 'All'){
						t_where = "where=^^ " + t_where + " ^^";
					}
			        q_gt('sssall', t_where , 0, 0, 0, "", r_accy);	
				}else{
					q_box("sssall_check_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where , 'sssall', "50%", "650px", q_getMsg('popSssallcheck'));
				}
			}
		}
		function txtCopy(dest, source) {
			var adest = dest.split(',');
			var asource = source.split(',');
			$('#' + adest[0]).focus(function () { if (trim($(this).val()).length == 0) $(this).val( q_getMsg('msgCopy')); });
			$('#' + adest[0]).focusout(function () {
				var t_copy = ($(this).val().substr(0, 1) == '=');
				var t_clear = ($(this).val().substr(0, 2) == ' =') ;
				for (var i = 0; i < adest.length; i++) {
				 {
					if (t_copy)
						$('#' + adest[i]).val($('#' + asource[i]).val());

					if( t_clear)
						$('#' + adest[i]).val('');
				 }
				}
			});
		}
		
		function q_boxClose( s2) { 
			var ret; 
			switch (b_pop) {  
            	case 'sssall':
            		var now_txtObject;
            		if($('#combPartno').val() != ''){
            			now_txtObject = $('#txtReceiver');
            			$('#combPartno').val('');
            		}else{
            			now_txtObject = $('#txtEnder');
            			$('#combPartno2').val('');
            		}
            		b_ret = getb_ret();         ///  q_box() 執行後，選取的資料
            		if (!b_ret || b_ret.length == 0)
                        return;
					for(var i = 0;i < b_ret.length;i++){
						str = now_txtObject.val();
						name = b_ret[i].namea;
						if(str.match(name) == null){
							newstr = str + name + ';';
							now_txtObject.val(newstr);
						}
					}
            		break;
				case q_name + '_s':
				 q_boxClose2(s2); ///   q_boxClose 3/4
				 break;
			}   /// end Switch
		}


		function q_gtPost(t_name) {  
			switch (t_name) {
                case 'sssall':
                	var as = _q_appendData("sssall", "", true);
             		var now_txtObject;
            		if($('#combPartno').val() != ''){
            			now_txtObject = $('#txtReceiver');
						$('#combPartno').val('');
            		}else{
            			now_txtObject = $('#txtEnder');
 						$('#combPartno2').val('');
           			}
					for(var i = 0;i < as.length;i++){
						str = now_txtObject.val();
						name = as[i].namea;
						if(str.match(name) == null){
							newstr = str + name + ';';
							now_txtObject.val(newstr);
						}
					}
                	break;
				case 'part':
                	var as = _q_appendData("part", "", true);
                    if (as[0] != undefined) {
                    	var t_item = "@,All@全部";
                    	var t_item2 = ",All-All@全部(全選)";
                        for ( i = 0; i < as.length; i++) {
                        	t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        	t_item2 = t_item2 + (t_item2.length > 0 ? ',' : '') + as[i].noa + '-All@' + as[i].part + '(全選)';
                        }
                        q_cmbParse("combPartno", t_item + t_item2);
                        q_cmbParse("combPartno2", t_item + t_item2);
                    }
                	break;
				case q_name: if (q_cur == 4)  
					q_Seek_gtPost();
				 break;
			}  /// end switch
		}
		
		function _btnSeek() {
			if (q_cur > 0 && q_cur < 4)  // 1-3
				return;
			q_box('signform_s.aspx', q_name + '_s', "500px", "330px", q_getMsg( "popSeek"));
		}

		function btnIns() {
            if($('#Copy').is(':checked')){
            	curData.copy();
            }
            _btnIns();
            if($('#Copy').is(':checked')){
            	curData.paste();
            }
            $('#Copy').removeAttr('checked');
            change_cur();
			$('#txtNoa').focus();
		}

		function btnModi() {
			if (emp($('#txtNoa').val()))
				return;
			_btnModi();
			change_cur();
			$('#txtNoa').focus();
		}

		function btnPrint() {
 
		}
		function change_cur(){
			if(q_cur == 1 || q_cur == 2){
				$('#combPartno').removeAttr('disabled');
				$('#combPartno').css('background-color', 'rgb(255, 255, 255)');
				$('#combPartno2').removeAttr('disabled');
				$('#combPartno2').css('background-color', 'rgb(255, 255, 255)');
			}else{
				$('#combPartno').attr('disabled','disabled');
				$('#combPartno').css('background-color', 'rgb(237, 237, 238)');
				$('#combPartno2').attr('disabled','disabled');
				$('#combPartno2').css('background-color', 'rgb(237, 237, 238)');
			}

		}
		function btnOk() {
			var t_err = '';
			t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
			chkChker_chk = new Array('chkIsmailchecker','chkIsmailapprovema','chkIsmailapprovefi',
									'chkIsmailapprovegm','chkIsmailapprovebs','chkIsmailreceiver',
									'chkIsmailender',
									'chkIsmesschecker','chkIsmessapprovema','chkIsmessapprovefi',
									'chkIsmessapprovegm','chkIsmessapprovebs','chkIsmessreceiver',
									'chkIsmessender'
									);
			for(var i = 0;i < chkChker_chk.length;i++){
				chkChker_lbl1 = 'lbl' + chkChker_chk[i].substr(9).substr(0,1).toUpperCase() + chkChker_chk[i].substr(10);
				chkChker_lbl2 = 'lbl' + chkChker_chk[i].substr(3);
				chkChker_txt = 'txt' + chkChker_chk[i].substring(5).substring(0,1).toUpperCase() + chkChker_chk[i].substring(6);
				if($('#' + chkChker_chk[i]).is(':checked') && emp($('#' + chkChker_txt).val())){
					alert('請填寫' + q_getMsg(chkChker_lbl1)+'的'+q_getMsg(chkChker_lbl2)+'欄位');
					$('#' + chkChker_txt).focus();
					return;
				}				
			}
			if( t_err.length > 0) {
				alert(t_err);
				return;
			}
			var t_noa = trim($('#txtNoa').val());
			if ( t_noa.length==0 )  
				q_gtnoa(q_name, t_noa);
			else
				wrServer(  t_noa);
		}
		function wrServer( key_value) {
			var i;

			xmlSql = '';
			if (q_cur == 2)   /// popSave
				xmlSql = q_preXml();

			$('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
			_btnOk(key_value, bbmKey[0], '','',2);
		}
		function refresh(recno) {
			_refresh(recno);
			change_cur();
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

		function btnSeek(){
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
				width: 98%;
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
				width: 98%;
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
				width: 11%;
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
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
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
			
			input[type="text"],input[type="button"] {     
				font-size: medium;
			}
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
		<div class="dview" id="dview" style="float: left;  width:98%;"  >
		<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
			<tr>
				<td align="center" style="width:5%"><a id='vewChk'></a></td>
				<td align="center" style="width:8%"><a id='vewNoa'></a></td>
				<td align="center" style="width:15%"><a id='vewFormname'></a></td>
				<td align="center" style="width:8%"><a id='vewPart'></a></td>
				<td align="center" style="width:8%"><a id='vewChecker'></a></td>
				<td align="center" style="width:8%"><a id='vewApprovema'></a></td>
				<td align="center" style="width:8%"><a id='vewApprovefi'></a></td>
				<td align="center" style="width:8%"><a id='vewApprovegm'></a></td>
				<!--<td align="center" style="width:8%"><a id='vewApprovebs'></a></td>-->
				<td align="center" style="width:20%"><a id='vewMemo'></a></td>
			</tr>
			<tr>
				<td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
				<td align="center" id='noa'>~noa</td>
				<td align="center" id='formname'>~formname</td>
				<td align="center" id='part'>~part</td>
				<td align="center" id='checker'>~checker</td>
				<td align="center" id='approvema'>~approvema</td>
				<td align="center" id='approvefi'>~approvefi</td>
				<td align="center" id='approvegm'>~approvegm</td>
				<!--<td align="center" id='approvebs'>~approvebs</td>-->
				<td align="center" id='memo'>~memo</td>
			</tr>
		</table>
		</div>
		<div class='dbbm' style="width: 98%;float: left;">
		<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
			<tr>
				<td class="td1">
					<span> </span><a id='lblNoa' class="lbl"></a>
				</td>
				<td class="td2">
					<input id="txtNoa"  type="text" class="txt c1"/>
				</td>
				<td class="td3">
					<span> </span><a id="lblFormname" class="lbl"></a>
				</td>
				<td class="td4">
					<input id="txtFormname" type="text" class="txt c1" />
				</td>
				<td class="td5">
					<span> </span><a id="lblPart" class="lbl btn"></a>
				</td>
				<td class="td6">
					<input id="txtPartno" type="text" class="txt c2" />
					<input id="txtPart" type="text" class="txt c3" />
				</td>
				<td class="td7" align="right">
					<input id="chkSignprocess" type="checkbox" />
					<span> </span><a id='lblSignprocess' class="lbl"> </a>
				</td>
				<!--
				<td class="td8">
					<select id="cmbSingcon" class="txt c1"> </select>
				</td>
				-->
			</tr>
			<tr>
				<td class="td1" align="right">
					<span> </span><a id="lblReceiver" class="lbl"></a>
				</td>
				<td class="td2">
					<select id="combPartno" class="txt c1"> </select>
				</td>
				<td colspan="2" class="td3">
					<input id="txtReceiver"  type="text" class="txt c1"/>
				</td>
				<td class="td4" align="right">
					<input id="chkIsmailreceiver" type="checkbox" />
					<span> </span><a id="lblIsmailreceiver" class="lbl"></a>
				</td>
				<td class="td5">
					<input id="txtMailreceiver"  type="text" class="txt c1"/>
				</td>
				<td class="td6" align="right">
					<input id="chkIsmessreceiver" type="checkbox" />
					<span> </span><a id="lblIsmessreceiver" class="lbl"></a>
				</td>
				<td class="td7">
					<input id="txtMessreceiver"  type="text" class="txt c1"/>
				</td>
			</tr>
			<tr>
				<td class="td1">
					<div style="float:left;">
						<input id="Copy" type="checkbox" />
						<span> </span><a id="lblCopy"></a>
					</div>
					<span> </span><a id='lblChecker' class="lbl btn"></a>
				</td>
				<td class="td2">
					<input id="txtCheckerno"  type="text" class="txt c2"/>
					<input id="txtChecker"  type="text" class="txt c3"/>
				</td>
				<td class="td3" align="right">
					<input id="chkIsmailchecker" type="checkbox" />
					<span> </span><a id="lblIsmailchecker" class="lbl"></a>
				</td>
				<td class="td4">
					<input id="txtMailchecker" type="text" class="txt c1" />
				</td>
				<td class="td5" align="right">
					<input id="chkIsmesschecker" type="checkbox" />
					<span> </span><a id="lblIsmesschecker" class="lbl"></a>
				</td>
				<td class="td6">
					<input id="txtMesschecker" type="text" class="txt c1" />
				</td>
				<td class="td7">
					<span> </span><a id="lblForm" class="lbl"></a>
				</td>
				<td class="td8">
					<input id="txtForm" type="text" class="txt c1" />
				</td>
				<td style="display:none">
					<span> </span><a id="lblYears" class="lbl" style="display:none"></a>
				</td>
				<td style="display:none">
					<input id="txtYears" type="text" class="txt c2" style="display:none"/>
					<a id="lblYears_yn" class="txt c3" style="display:none"></a>
				</td>
			</tr>
			<tr>
				<td class="td1">
					<span> </span><a id="lblApprovema" class="lbl btn"></a>
				</td>
				<td class="td2">
					<input id="txtApprovemano" type="text" class="txt c2" />
					<input id="txtApprovema" type="text" class="txt c3" />
				</td>
				<td class="td3" align="right">
					<input id="chkIsmailapprovema" type="checkbox" />
					<span> </span><a id="lblIsmailapprovema" class="lbl"></a>
				</td>
				<td class="td4">
					<input id="txtMailapprovema" type="text" class="txt c1" />
				</td>
				<td class="td5" align="right">
					<input id="chkIsmessapprovema" type="checkbox" />
					<span> </span><a id="lblIsmessapprovema" class="lbl"></a>
				</td>
				<td class="td6">
					<input id="txtMessapprovema" type="text" class="txt c1" />
				</td>
				<td class="td7">
					<span> </span><a id="lblApprovemacon" class="lbl"></a>
				</td>
				<td class="td8">
					<input id="txtApprovemacon" type="text" class="txt c1" />
				</td>
			</tr>
			<tr>
				<td class="td1">
					<span> </span><a id='lblApprovefi' class="lbl btn"></a>
				</td>
				<td class="td2">
					<input id="txtApprovefino"  type="text" class="txt c2"/>
					<input id="txtApprovefi"  type="text" class="txt c3"/>
				</td>
				<td class="td3" align="right">
					<input id="chkIsmailapprovefi" type="checkbox" />
					<span> </span><a id="lblIsmailapprovefi" class="lbl"></a>
				</td>
				<td class="td4">
					<input id="txtMailapprovefi" type="text" class="txt c1" />
				</td>
				<td class="td5" align="right">
					<input id="chkIsmessapprovefi" type="checkbox" />
					<span> </span><a id="lblIsmessapprovefi" class="lbl"></a>
				</td>
				<td class="td6">
					<input id="txtMessapprovefi" type="text" class="txt c1" />
				</td>
				<td class="td7">
					<span> </span><a id='lblApproveficon' class="lbl"></a>
				</td>
				<td class="td8">
					<input id="txtApproveficon"  type="text" class="txt c1"/>
				</td>
			</tr>
			<tr>
				<td class="td1">
					<span> </span><a id='lblApprovegm' class="lbl btn"></a>
				</td>
				<td class="td2">
					<input id="txtApprovegmno"  type="text" class="txt c2"/>
					<input id="txtApprovegm"  type="text" class="txt c3"/>
				</td>
				<td class="td3" align="right">
					<input id="chkIsmailapprovegm" type="checkbox" />
					<span> </span><a id="lblIsmailapprovegm" class="lbl"></a>
				</td>
				<td class="td4">
					<input id="txtMailapprovegm" type="text" class="txt c1" />
				</td>
				<td class="td5" align="right">
					<input id="chkIsmessapprovegm" type="checkbox" />
					<span> </span><a id="lblIsmessapprovegm" class="lbl"></a>
				</td>
				<td class="td6">
					<input id="txtMessapprovegm" type="text" class="txt c1" />
				</td>
				<td class="td7">
					<span> </span><a id='lblApprovegmcon' class="lbl"></a>
				</td>
				<td class="td8">
					<input id="txtApprovegmcon"  type="text" class="txt c1"/>
				</td>
			</tr>
			<tr>
				<td class="td1">
					<span> </span><a id='lblApprovebs' class="lbl btn"></a>
				</td>
				<td class="td2">
					<input id="txtApprovebsno"  type="text" class="txt c2"/>
					<input id="txtApprovebs"  type="text" class="txt c3"/>
				</td>
				<td class="td3" align="right">
					<input id="chkIsmailapprovebs" type="checkbox" />
					<span> </span><a id="lblIsmailapprovebs" class="lbl"></a>
				</td>
				<td class="td4">
					<input id="txtMailapprovebs" type="text" class="txt c1" />
				</td>
				<td class="td5" align="right">
					<input id="chkIsmessapprovebs" type="checkbox" />
					<span> </span><a id="lblIsmessapprovebs" class="lbl"></a>
				</td>
				<td class="td6">
					<input id="txtMessapprovebs" type="text" class="txt c1" />
				</td>
				<td class="td7">
					<span> </span><a id='lblApprovebscon' class="lbl"></a>
				</td>
				<td class="td8">
					<input id="txtApprovebscon"  type="text" class="txt c1"/>
				</td>
			</tr>
			<tr>
				<td class="td1" align="right">
					<span> </span><a id="lblEnder" class="lbl"></a>
				</td>
				<td class="td2">
					<select id="combPartno2" class="txt c1"> </select>
				</td>
				<td colspan="2" class="td3">
					<input id="txtEnder"  type="text" class="txt c1"/>
				</td>
				<td class="td4" align="right">
					<input id="chkIsmailender" type="checkbox" />
					<span> </span><a id="lblIsmailender" class="lbl"></a>
				</td>
				<td class="td5">
					<input id="txtMailender"  type="text" class="txt c1"/>
				</td>
				<td class="td6" align="right">
					<input id="chkIsmessender" type="checkbox" />
					<span> </span><a id="lblIsmessender" class="lbl"></a>
				</td>
				<td class="td7">
					<input id="txtMessender"  type="text" class="txt c1"/>
				</td>
			</tr>
			<tr>
				<td class="td1">
					<span> </span><a id="lblSigncon" class="lbl"></a>
				</td>
				<td class="td2" colspan="3">
					<input id="txtSigncon"  type="text" class="txt c1"/>
				</td>
				<td class="td3" align="right">
					<input id="chkOnedata" type="checkbox" />
					<span> </span><a id="lblOnedata" class="lbl"></a>
				</td>
				<td class="td4"></td>
				<td class="td5">
					<span> </span><a id="lblSignpost" class="lbl"></a>
				</td>
				<td class="td6">
					<input id="txtSignpost"  type="text" class="txt c1"/>
				</td>

			</tr>
			<tr>
				<td class="td1">
					<span> </span><a id='lblMemo' class="lbl"></a>
				</td>
				<td class="td2" colspan="5">
					<textarea id="txtMemo" cols="10" rows="5" style="width: 99%; height: 50px;"></textarea>
				</td>
				<td align="right">
				</td>
			</tr>
		
		</table>
		</div>
		</div>
		<input id="q_sys" type="hidden" />    
</body>
</html>
			