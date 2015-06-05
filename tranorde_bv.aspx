<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
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
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}

			q_tables = 't';
			var q_name = "tranorde";
			var q_readonly = ['txtNoa','txtBoat','txtPort','txtEf','txtPrice'];
			var q_readonlys = [];
			var bbmNum = [['txtMount',10,0,1], ['txtBoat',10,0,1], ['txtPort',10,0,1]
			, ['txtTweight2',10,0,1], ['txtEta',10,0,1], ['txtTtrannumber',10,0,1], ['txtEtc',10,0,1], ['txtThirdprice',10,0,1], ['txtEtd',10,0,1]
			, ['txtEf',10,0,1], ['txtPrice',10,0,1]];
			var bbmMask = [['txtDatea', '999/99/99'],['txtDocketno1', '9999999999'],['txtDocketno2', '9999999999']];
			var bbsNum = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_alias = '';
			q_desc = 1;
			brwCount2 = 15;
			aPop = new Array(
				['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx'], 
				['txtComp', 'lblCust', 'cust', 'comp,noa,nick', 'txtComp,txtCustno,txtNick', 'cust_b.aspx']
			);

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
				//q_cmbParse("cmbDeliveryno", "1,2,3");
				q_cmbParse("cmbContainertype", "手寫託運單,edi託運單");
				document.title='2.1預購作業'
				$("#lblCust").text('公司名稱');
				
				$('#txtMount').change(function() {
					//104/05/05 97碼產生方式 同96 最後一碼為檢查碼
					if(emp($('#txtDocketno1').val())&&!emp($('#txtMount').val())){
						//取目前97最大碼
						var t_where = "where=^^ docketno2=(select MAX(docketno2) from tranorde"+r_accy+") ^^";
						q_gt('tranorde', t_where, 0, 0, 0, "GetMax97code",r_accy);
					}else if(!emp($('#txtDocketno1').val())&&!emp($('#txtMount').val())){
						var endcode='97'+('0000000'+(dec($('#txtDocketno1').val().slice(-8).substr(0,7))+(dec($('#txtMount').val())-1))).slice(-7);
						endcode=endcode+(endcode%7);
						$('#txtDocketno2').val(endcode);
					}
				});
				
				$('#txtDocketno1').blur(function() {
					if(q_cur==1 || q_cur==2){
						if(!emp($(this).val())){
	                		if(!((/^97[0-9]{8}$/g).test($(this).val()) && dec($(this).val().substr(0,9))%7 == dec($(this).val().slice(-1))))
	                			alert('請輸入正確的97條碼!!!');
	                	}
						if(!emp($('#txtDocketno1').val())&&!emp($('#txtMount').val()) &&(q_cur==1 || q_cur==2)){
							var endcode='97'+('0000000'+(dec($('#txtDocketno1').val().slice(-8).substr(0,7))+(dec($('#txtMount').val())-1))).slice(-7);
							endcode=endcode+(endcode%7);
							$('#txtDocketno2').val(endcode);
						}
					}
				});
				
				$('#txtDocketno2').blur(function() {
					if(q_cur==1 || q_cur==2){
						if(!emp($(this).val())){
	                		if(!((/^97[0-9]{8}$/g).test($(this).val()) && dec($(this).val().substr(0,9))%7 == dec($(this).val().slice(-1))))
	                			alert('請輸入正確的97條碼!!!');
	                	}
						if(!emp($('#txtDocketno2').val())&&!emp($('#txtMount').val()) &&(q_cur==1 || q_cur==2)){
							var begcode='97'+('0000000'+(dec($('#txtDocketno2').val().slice(-8).substr(0,7))-(dec($('#txtMount').val())-1))).slice(-7);
							begcode=begcode+(begcode%7);
							$('#txtDocketno1').val(begcode);
						}
					}
				});
				
				$('.c3').change(function() {
					var t_mount=0,t_total=0;
					//1號袋
					t_mount=q_add(t_mount,q_float('txtTweight2'));
					t_total=q_add(t_total,q_mul(q_float('txtTweight2'),q_float('txtEta')));
					//2號袋
					t_mount=q_add(t_mount,q_float('txtTtrannumber'));
					t_total=q_add(t_total,q_mul(q_float('txtTtrannumber'),q_float('txtEtc')));
					//3號袋
					t_mount=q_add(t_mount,q_float('txtThirdprice'));
					t_total=q_add(t_total,q_mul(q_float('txtThirdprice'),q_float('txtEtd')));
					if(t_mount>0 && t_total>0){
						$('#txtPrice').val(t_total);
						$('#txtEf').val(round(q_div(t_total,t_mount),0));
					}
				});
			}
			
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	
                    }
				}
				_bbsAssign();
			}
			function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    }
                }
                _bbtAssign();
            }
			function bbsSave(as) {
				if (!as['caseno']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}
			
			function sum() {
				if (!(q_cur == 1 || q_cur == 2))
					return;
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
					case 'getrepeat':
						var as = _q_appendData("tranorde", "", true);
						if(as.length>0){
							alert('預購號碼重複!!【'+as[0].noa+'】');
						}else{
							orde_repeat=true;
							btnOk();
						}
						break;
					case 'GetMax97code':
						var as = _q_appendData("tranorde", "", true);
						var maxcode='9700000004',endcode='9700000004';
						if (as[0] != undefined){
							var maxcode=as[0].docketno2;
							maxcode='97'+('0000000'+(dec(maxcode.slice(-8).substr(0,7))+1)).slice(-7);
							maxcode=maxcode+(maxcode%7);
						}
						endcode='97'+('0000000'+(dec(maxcode.slice(-8).substr(0,7))+(dec($('#txtMount').val())-1))).slice(-7);
						endcode=endcode+(endcode%7);
						
						$('#txtDocketno1').val(maxcode);
						$('#txtDocketno2').val(endcode);
						break;
					case 'getused':
						var as = _q_appendData("view_transef", "", true);
                		$('#txtBoat').val(as.length);
                		$('#txtPort').val(dec($('#txtMount').val())-as.length);
                		if(as.length==dec($('#txtMount').val())){
                			$('#chkEnda').prop('checked',true);
                		}
						break;
					case 'btnModi_getused':
							var as = _q_appendData("view_transef", "", true);
						$('#txtBoat').val(as.length);
                		$('#txtPort').val(dec($('#txtMount').val())-as.length);
                		if(as.length==dec($('#txtMount').val())){
                			$('#chkEnda').prop('checked',true);
                		}
						if(as.length>0){
							alert('預購單已使用禁止修改!!');
						}else{
							_btnModi();
							$('#txtDatea').focus();
						}
						break;
					case 'btnDele_getused':
						var as = _q_appendData("view_transef", "", true);
						$('#txtBoat').val(as.length);
                		$('#txtPort').val(dec($('#txtMount').val())-as.length);
                		if(as.length==dec($('#txtMount').val())){
                			$('#chkEnda').prop('checked',true);
                		}
						if(as.length>0){
							alert('預購單已使用禁止刪除!!');
						}else{
							//未使用
							if (!confirm(mess_dele))
								return;
							q_cur = 3;
							q_func('qtxt.query.t3', 'tboat.txt,post,' + encodeURI(r_accy)+';'+encodeURI($('#txtNoa').val()) + ';0');//刪除
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('tranorde_bv_s.aspx', q_name + '_s', "500px", "430px", q_getMsg("popSeek"));
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
				if ($('#chkEnda').prop("checked")){
					alert("已結案無法修改!!");
					return;
				}
				
				//判斷是否已被使用 
				var t_where = "where=^^ traceno='"+$('#txtNoa').val()+"' and isnull(trandate,'')!='' ^^";
				q_gt('view_transef', t_where, 0, 0, 0, "btnModi_getused");
				
			}

			function btnPrint() {
				q_box("z_tranorde_bv.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({bnoa:trim($('#txtDocketno1').val()),enoa:trim($('#txtDocketno2').val())}) + ";" + r_accy + "_" + r_cno, 'tranorde', "95%", "95%", m_print);
			}
			
			var orde_repeat=false;
			function btnOk() {
				$('#txtDatea').val($.trim($('#txtDatea').val()));
				if (checkId($('#txtDatea').val()) == 0) {
					alert(q_getMsg('lblDatea') + '錯誤。');
					return;
				}
				
				var t_err = '';
				t_err = q_chkEmpField([['cmbContainertype', '託運單形式'],['txtMount', '件數'],['txtDocketno1', '預購起始號碼'],['txtDocketno2', '預購迄止號碼']]);
				if (t_err.length > 0) {
					alert(t_err);
					Unlock();
					return;
				}
				
				//檢查多袋是否與總袋數量相同
				var t_mount=0;
				t_mount=q_add(t_mount,q_float('txtTweight2'));//1號袋
				t_mount=q_add(t_mount,q_float('txtTtrannumber'));//2號袋
				t_mount=q_add(t_mount,q_float('txtThirdprice'));//3號袋
				if (t_mount!=q_float('txtMount')) {
					alert('總件數與分配號袋件數不符!!!');
					Unlock();
					return;
				}
					
				
                if(!((/^97[0-9]{8}$/g).test($('#txtDocketno1').val()) 
                && dec($('#txtDocketno1').val().substr(0,9))%7 == dec($('#txtDocketno1').val().slice(-1)))){
                	alert('預購起始號碼請輸入正確的97條碼!!!');
                	Unlock();
					return;
                }
                
                if(!((/^97[0-9]{8}$/g).test($('#txtDocketno2').val()) 
                && dec($('#txtDocketno2').val().substr(0,9))%7 == dec($('#txtDocketno2').val().slice(-1)))){
                	alert('預購迄止號碼請輸入正確的97條碼!!!');
                	Unlock();
					return;
                }
                
                //檢查預購單號範圍是否重覆
                if(!orde_repeat){
	                var t_where = "where=^^ noa!='"+$('#txtNoa').val()+"' and ( ('"+$('#txtDocketno1').val()+"' >= docketno1 and '"+$('#txtDocketno1').val()+"' <= docketno2) or ('"+$('#txtDocketno2').val()+"' >= docketno1 and '"+$('#txtDocketno2').val()+"' <= docketno2) )^^";
					q_gt('tranorde', t_where, 0, 0, 0, "getrepeat",r_accy);
					return;
                }
                orde_repeat=false;
				
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranorde') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.t1':
						q_func('qtxt.query.t2', 'tboat.txt,post,' +encodeURI(r_accy)+';'+ encodeURI($('#txtNoa').val()) + ';1');//新增,修改
						break;
					case 'qtxt.query.t3':
						_btnOk($('#txtNoa').val(), bbmKey[0], ( bbsHtm ? bbsKey[1] : ''), '', 3)
						break;
				}
			}
			
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				if(q_cur == 2)
					q_func('qtxt.query.t1', 'tboat.txt,post,' +encodeURI(r_accy)+';'+encodeURI($('#txtNoa').val()) + ';0');//修改
				else
					q_func('qtxt.query.t2', 'tboat.txt,post,' +encodeURI(r_accy)+';'+ encodeURI($('#txtNoa').val()) + ';1');//新增,修改
				
			}

			function refresh(recno) {
				_refresh(recno);
				getused();
			}
			
			function getused() {
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (!(t_noa.length == 0 || t_noa == "AUTO")){
					var t_where = "where=^^ traceno='"+$('#txtNoa').val()+"' and isnull(trandate,'')!='' ^^";
					q_gt('view_transef', t_where, 0, 0, 0, "getused");
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				getused();
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
				if ($('#chkEnda').prop("checked")){
				    alert('已結案無法刪除!!');
					 return;
				 }
				
				//判斷是否已被使用 
				var t_where = "where=^^ traceno='"+$('#txtNoa').val()+"' and isnull(trandate,'')!='' ^^";
				q_gt('view_transef', t_where, 0, 0, 0, "btnDele_getused");
				
				//_btnDele();
			}

			function btnCancel() {
				_btnCancel();
			}

			function q_popPost(id) {
				switch(id){
					
				}
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
				} else if ((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//西元年
					var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
					if (regex.test(str))
						return 3;
				} else if ((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//民國年
					str = (parseInt(str.substring(0, 3)) + 1911) + str.substring(3);
					var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
					if (regex.test(str))
						return 4
				}
				return 0;
				//錯誤
			}
		</script>
		<style type="text/css">
			#dmain {
				width:1250px;
				overflow: auto;
			}
			.dview {
				float: left;
				width: 420px;
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
				background-color: #FFEA00;
				color: blue;
			}
			.dbbm {
				float: left;
				width: 750px;
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
			.tbbm .trX {
				background-color: #FFEC8B;
			}
			.tbbm .trY {
				background-color: pink;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 100%;
				float: left;
			}
			.txt.c2 {
				width: 40%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
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
				width: 950px;
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
			.font1 {
				font-family: "細明體", Arial, sans-serif;
			}
			#tableTranordet tr td input[type="text"]{
				width:80px;
			}
            #tbbt {
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
            }
		</style>
	</head>
	<body 
	ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:120px; color:black;"><a>訂單編號</a></td>
						<td align="center" style="width:100px; color:black;"><a>公司名稱</a></td>
						<td align="center" style="width:80px; color:black;"><a>件數</a></td>

					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='mount,0,1' style="text-align: right;">~mount,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td> <input type="text" id="txtCaddr" style="display:none;"></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">訂單編號</a></td>
						<td><input type="text" id="txtNoa" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input type="text" id="txtDatea" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td colspan="3">
							<input type="text" id="txtCustno" class="txt" style="width:15%;float: left; " />
							<input type="text" id="txtComp" class="txt" style="width:85%;float: left; " />
							<input type="text" id="txtNick" class="txt" style="display:none; " />
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">託運單形式</a></td>
						<td><select id="cmbContainertype" class="txt c1"> </select></td>
						<!--<td><span> </span><a class="lbl">速配袋號</a></td>
						<td><select id="cmbDeliveryno" class="txt c1"> </select></td>-->
					</tr>
					<tr>
						<td><span> </span><a class="lbl">總件數</a></td>
						<td><input type="text" id="txtMount" class="txt c1 num"/></td>
						<td><span> </span><a class="lbl">預購起始號碼</a></td>
						<td><input type="text" id="txtDocketno1" class="txt c1"/> </td>
						<td><span> </span><a class="lbl">預購迄止號碼</a></td>
						<td><input type="text" id="txtDocketno2" class="txt c1"/> </td>
					</tr>
					<tr style="background-color: skyblue;">
						<td><span> </span><a class="lbl">速配袋號</a></td>
						<td style="text-align: center;background-color: skyblue;"><span> </span><a class="lbl" style="float: none;">件數</a></td>
						<td style="text-align: center;background-color: skyblue;"><span> </span><a class="lbl" style="float: none;">單價</a></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr style="background-color: skyblue;">
						<td><span> </span><a class="lbl">1號袋</a></td>
						<td style="text-align: center;background-color: skyblue;"><input type="text" id="txtTweight2" class="txt c3 num" style="float: none;"/></td>
						<td style="text-align: center;background-color: skyblue;"><input type="text" id="txtEta" class="txt c3 num" style="float: none;"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr style="background-color: skyblue;">
						<td><span> </span><a class="lbl">2號袋</a></td>
						<td style="text-align: center;"><input type="text" id="txtTtrannumber" class="txt c3 num" style="float: none;"/></td>
						<td style="text-align: center;"><input type="text" id="txtEtc" class="txt c3 num" style="float: none;"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr style="background-color: skyblue;">
						<td><span> </span><a class="lbl">3號袋</a></td>
						<td style="text-align: center;"><input type="text" id="txtThirdprice" class="txt c3 num" style="float: none;"/></td>
						<td style="text-align: center;"><input type="text" id="txtEtd" class="txt c3 num" style="float: none;"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">均價</a></td>
						<td><input type="text" id="txtEf" class="txt c1 num"/></td>
						<td><span> </span><a class="lbl">合計</a></td>
						<td><input type="text" id="txtPrice" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">已使用</a></td>
						<td><input type="text" id="txtBoat" class="txt c1 num"/></td>
						<td><span> </span><a class="lbl">未使用</a></td>
						<td><input type="text" id="txtPort" class="txt c1 num"/></td>
						<td><span> </span><a class="lbl">結案</a></td>
						<td><input id="chkEnda" type="checkbox" style=' '/></td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>
